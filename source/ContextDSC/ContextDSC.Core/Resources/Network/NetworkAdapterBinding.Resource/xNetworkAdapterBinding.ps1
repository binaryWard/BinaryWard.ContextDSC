Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\Model\xNetworkAdapterBindingResourceModel.ps1"

class xNetworkAdapterBinding {
    [ValidateNotNullOrEmpty()][String]$InterfaceAlias
    [ValidateNotNullOrEmpty()][String]$ComponentId
    [ValidateSet('Enabled', 'Disabled')][String]$State = 'Enabled'

    xNetworkAdapterBinding() {}

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
        $currentNetAdapterBinding = Get-NetAdapterBinding -InterfaceAlias $this.InterfaceAlias -ComponentId $this.ComponentId -ErrorAction Stop

        $adapterState = $currentNetAdapterBinding.Enabled | Sort-Object -Unique

        if ( @($adapterState).Count -gt 1) {
            $currentEnabled = 'Mixed'
        }
        elseif ( $adapterState -eq $true ) {
            $currentEnabled = 'Enabled'
        }
        else {
            $currentEnabled = 'Disabled'
        }
        
        return $this.Get_ResourceModel($this.InterfaceAlias, $this.ComponentId, $currentEnabled)
    }

    [System.Collections.Hashtable]Get_ResourceInfo() {
        return $this.Get_ResourceModel($this.InterfaceAlias, $this.ComponentId, $this.State)
    }


    [System.Collections.Hashtable]Get_ResourceModel([System.String]$interfaceAlias, [System.String]$componentId, [System.String]$state) {
        $returnValue = New-xNetworkAdapterBindingResourceModel
        
        $returnValue.ResourceName = "xNetworkAdapterBinding"
        $returnValue.InterfaceAlias = $interfaceAlias
        $returnValue.ComponentId = $componentId
        $returnValue.State = $state
        
        return $returnValue
    }

    [System.Boolean] Test_TargetResource() {
        $currentNetAdapterBinding = Get-NetAdapterBinding -InterfaceAlias $this.InterfaceAlias -ComponentId $this.ComponentId -ErrorAction Stop

        $adapterState = $currentNetAdapterBinding.Enabled | Sort-Object -Unique

        if ( @($adapterState).Count -gt 1) {
            $currentEnabled = 'Mixed'
        }
        elseif ( $adapterState -eq $true ) {
            $currentEnabled = 'Enabled'
        }
        else {
            $currentEnabled = 'Disabled'
        }

        # Test if the binding is in the correct state
        if ($currentEnabled -ne $this.State) {
            return $false
        }
        else {
            return $true
        } 
    } 

    [void] Set_TargetResource() {
        if ($this.State -eq 'Enabled') {
            Enable-NetAdapterBinding -InterfaceAlias $this.InterfaceAlias -ComponentID $this.ComponentId
        }
        else {
            Disable-NetAdapterBinding -InterfaceAlias $this.InterfaceAlias -ComponentID $this.ComponentId
        }
    }
}


function New-xNetworkAdapterBinding() {
    <#
    .SYNOPSIS
    Allow the module to expose the creation of the class while having the similar splat like syntax when using the class constructor.
    
    .DESCRIPTION
    Long description
    
    .PARAMETER DesiredState
    A hashtable based upon the properties of the class
    #>
    [CmdletBinding()]
    [OutputType([xNetworkAdapterBinding])]
    param (
        [parameter(Mandatory = $true)]
        [Hashtable]$DesiredState
    )

    return [xNetworkAdapterBinding]@{
        InterfaceAlias = $DesiredState.InterfaceAlias;
        ComponentId    = $DesiredState.ComponentId;
        State          = $DesiredState.State;
    }
}