Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetAdapterBinding\Test_TargetResource" {
    
    Context 'single binding component as enabled test if enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $True
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId
            State          = 'Enabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }
            
        $result = $xNetworkAdapterBindingInstance.Test_TargetResource()

        It 'should return true' {
            $result | Should Be $True
        }

        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding 1
        }
    }

    Context 'single binding component as disabled test if enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $False
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId
            State          = 'Enabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }

        $result = $xNetworkAdapterBindingInstance.Test_TargetResource()

        It 'should return false' {
            $result | Should Be $False
        }

        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding 1
        }
    }

    Context 'single binding component as enabled test if diabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $True
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId
            State          = 'Disabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }
        
        $result = $xNetworkAdapterBindingInstance.Test_TargetResource()

        It 'should return false' {
            $result | Should Be $False
        }

        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding 1
        }
    }
    
    Context 'single binding component as disabled test if disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $False
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

        $Expected_GetTargetResource_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId
            State          = 'Disabled'
        }        

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $Expected_GetTargetResource_Result.InterfaceAlias;
            ComponentId    = $Expected_GetTargetResource_Result.ComponentId;
            State          = $Expected_GetTargetResource_Result.State;
        }

        $result = $xNetworkAdapterBindingInstance.Test_TargetResource()

        It 'should return true' {
            $result | Should Be $True
        }

        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding 1
        }
    }
}

