Set-StrictMode -Version 'Latest'

function Invoke-ApplicationStateController() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [System.Collections.Hashtable[]]$ApplicationSetStateModel
    )

    BEGIN {
        . "$PSScriptRoot\..\..\ContextDSC.Core\BinaryWard.ContextDSC.Core.ps1"
        . "$PSScriptRoot\Model\ContextDscExceptionModel.ps1"
        . "$PSScriptRoot\Model\ApplicationSetStateResultModel"
        . "$PSScriptRoot\ContextDSCAppCore.ps1"

        function SetState() {
            param (
                [Parameter(Mandatory = $True)]
                [System.Collections.Hashtable]$AppSetStateModel
            )

            try {
                if ( $appSetStateModel ) {
                    $private:exeResult = $Null
                    if ($appSetStateModel.ContainsKey("ConfigurationStates") -and $appSetStateModel.ConfigurationStates) {
                        $private:exeResult = Invoke-ConfigurationState -ConfigurationStates $appSetStateModel.ConfigurationStates
                    }

                    $result = New-ApplicationSetStateResultModel
                    $result.CDSCApplyResult = $private:exeResult

                    if ($appSetStateModel.ContainsKey("Metadata")) {
                        $result.Metadata = $appSetStateModel.Metadata
                    }

                    Write-Output $result
                }
            }
            catch {
                $exResult = New-ApplicationSetStateResultModel
                $exResult.Exception = New-ContextDscExceptionModel -Exception $_.Exception
                Write-Output $exResult
            }
        }
    }

    PROCESS {      
        foreach ($appSetStateModel in $ApplicationSetStateModel) {
            $private:setResult = SetState -AppSetStateModel $appSetStateModel
            Write-ContextDscSetResultEventLog -LogEntryModel $private:setResult
            Write-Output $private:setResult
        }
    
    }

    END {}
}