Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetworkAdapterBinding\Set_TargetResource" {
    
    Context 'single binding component set enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        # mock overrides
        Mock Enable-NetAdapterBinding -Verifiable 

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            State          = 'Enabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = 'ms_tcpip63';
            State          = $Expected_GetTargetResource_Result.State;
        }
        
        $xNetworkAdapterBindingInstance.Set_TargetResource()
      
        It 'should call Enable-NetAdapterBinding' {
            Assert-MockCalled Enable-NetAdapterBinding 1
        }
    }

      
    Context 'single binding component set disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
     
        # mock overrides
        Mock Disable-NetAdapterBinding -Verifiable 

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            State          = 'Disabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = 'ms_tcpip63';
            State          = $Expected_GetTargetResource_Result.State;
        }
    
        $xNetworkAdapterBindingInstance.Set_TargetResource()
    
        It 'should call Disable-NetAdapterBinding' {
            Assert-MockCalled Disable-NetAdapterBinding 1
        }
    }
}

