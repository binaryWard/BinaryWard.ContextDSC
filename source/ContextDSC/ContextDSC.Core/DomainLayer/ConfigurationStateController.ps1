Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\Model\CDSCApplyResultModel.ps1"
class ConfigurationStateController {

    [PSCustomObject[]] $ConfigurationStates

    [System.Collections.Hashtable[]] InvokeConfigurationStates() {
        [System.Collections.Hashtable[]]$private:configStates = [System.Collections.Hashtable[]]::new($this.ConfigurationStates.Count)

        $private:globalApplyResult = $true

        for ($i = 0; $i -lt $this.ConfigurationStates.Count; $i++) {
            $private:configurationState = $this.ConfigurationStates[$i]
            $private:applyResult = $false
            if ( $configurationState.Update_TargetResource() ) {
                # Successfully applied
                $private:applyResult = $true
            }   
            else {
                # Failed to apply
                $private:applyResult = $false
                $private:globalApplyResult = $false
            }   

            $private:configStates[$i] = $private:configurationState.Get_ResourceInfo()
            $private:configStates[$i].ApplyResult = $private:applyResult
        }

        $private:invokeResult = New-CDSCApplyResult
        $private:invokeResult.ApplyResult = $private:globalApplyResult
        $private:invokeResult.Resources = $private:configStates
        
        return $private:invokeResult
    }
}

function Invoke-ConfigurationState() {
    param (
        [parameter(Mandatory = $true)]
        $ConfigurationStates
    )

    $private:configurationStateController = [ConfigurationStateController]@{
        ConfigurationStates = $ConfigurationStates
    }

    $private:results = $private:configurationStateController.InvokeConfigurationStates() 

    Write-Output $private:results
}