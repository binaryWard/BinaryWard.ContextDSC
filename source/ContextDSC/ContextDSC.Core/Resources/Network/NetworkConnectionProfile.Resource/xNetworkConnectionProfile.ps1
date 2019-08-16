Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\Model\xNetworkConnectionProfileResourceModel.ps1"

class xNetworkConnectionProfile {
    [ValidateNotNullOrEmpty()][String]$InterfaceAlias
    [ValidateSet('Public', 'Private')][String]$NetworkCategory

    xNetworkConnectionProfile() {}

    [System.Boolean]Update_TargetResource() {
        if ( !$this.Test_TargetResource()) {
            $this.Set_TargetResource()

            # Validate the state and report state update failure if the state set is not correct
            return $this.Test_TargetResource()
        }
        else {
            return $true
        }
    }

    [System.Collections.Hashtable]Get_TargetResource() {       
        $private:result = Get-NetConnectionProfile -InterfaceAlias $this.InterfaceAlias
    
        return $this.Get_ResourceModel($private:result.InterfaceAlias, $private:result.NetworkCategory)
    }
    
    [System.Collections.Hashtable]Get_ResourceInfo() {
        return $this.Get_ResourceModel($this.InterfaceAlias, $this.NetworkCategory)
    }

    [System.Collections.Hashtable]Get_ResourceModel([System.String]$interfaceAlias, [System.String]$networkCategory) {
        $returnValue = New-xNetworkConnectionProfileResourceModel

        $returnValue.ResourceName = "xNetworkConnectionProfile"
        $returnValue.InterfaceAlias = $interfaceAlias
        $returnValue.NetworkCategory = $networkCategory
    
        return $returnValue
    }

    [System.Boolean] Test_TargetResource() {
        $private:current = Get-NetConnectionProfile -InterfaceAlias $this.InterfaceAlias
        
        if ($this.NetworkCategory -ne $private:current.NetworkCategory) {
            return $false
        }
    
        return $true
    }

    [void] Set_TargetResource() {
        Set-NetConnectionProfile -InterfaceAlias $this.InterfaceAlias -NetworkCategory $this.NetworkCategory
    }
}

function New-xNetworkConnectionProfile() {
    <#
    .SYNOPSIS
    Allow the module to expose the creation of the class while having the similar splat like syntax when using the class constructor.
    
    .DESCRIPTION
    Long description
    
    .PARAMETER DesiredState
    A hashtable based upon the properties of the class
    
    #>
    [CmdletBinding()]
    [OutputType([xNetworkConnectionProfile])]
    param (
        [parameter(Mandatory = $true)]
        [Hashtable]$DesiredState
    )

    return [xNetworkConnectionProfile]@{
        InterfaceAlias  = $DesiredState.InterfaceAlias;
        NetworkCategory = $DesiredState.NetworkCategory;
    }
}