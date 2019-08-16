Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetworkAdapterBinding\Get_TargetResource" {
    
    Context 'single binding component as enabled' {
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
        
        $result = $xNetworkAdapterBindingInstance.Get_TargetResource()

        It 'should return binding info with state enabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 1
        }
    }

    Context 'single binding component as disabled' {
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

        $result = $xNetworkAdapterBindingInstance.Get_TargetResource()
        
        It 'should return binding info with state disabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 1
        }
    }

    Context 'multiple binding components as enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $True
        },
        @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $True
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

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

        $result = $xNetworkAdapterBindingInstance.Get_TargetResource()

        It 'should return a single binding enabled with state enabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 1
        }
    }

    Context 'multiple binding components as disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $False
        },
        @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $False
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

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

        $result = $xNetworkAdapterBindingInstance.Get_TargetResource()
        
        It 'should return a single binding enabled with state disabled' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be $Expected_GetTargetResource_Result.State
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 1
        }
    }

    Context 'multiple binding components as disabled and enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $False
        },
        @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $True
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }

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

        $result = $xNetworkAdapterBindingInstance.Get_TargetResource()

        It 'should return a single binding enabled with state mixed' {
            $result.InterfaceAlias | Should Be $Expected_GetTargetResource_Result.InterfaceAlias
            $result.ComponentId | Should Be $Expected_GetTargetResource_Result.ComponentId
            $result.State | Should be 'Mixed'
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 1
        }
    }
}

