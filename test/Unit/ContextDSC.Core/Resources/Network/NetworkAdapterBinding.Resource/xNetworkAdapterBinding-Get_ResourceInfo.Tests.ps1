Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetworkAdapterBinding\Get_ResourceInfo" {
    
    Context 'single binding component as enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            State          = 'Enabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }

        $result = $xNetworkAdapterBindingInstance.Get_ResourceInfo()
 
        It 'should return binding info with state enabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }
    }

    Context 'single binding component as disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        
        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            State          = 'Disabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }

        $result = $xNetworkAdapterBindingInstance.Get_ResourceInfo()

        It 'should return binding info with state disabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }
    }
}

