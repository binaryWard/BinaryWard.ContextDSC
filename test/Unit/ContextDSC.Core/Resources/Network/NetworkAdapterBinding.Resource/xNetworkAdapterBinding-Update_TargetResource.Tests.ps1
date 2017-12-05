Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetworkAdapterBinding\Udate_TargetResource" {
    
    Context 'single binding component as enabled update enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $true
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
       
        $result = $xNetworkAdapterBindingInstance.Update_TargetResource()

        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }

        
        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding 1
        }
    }

    Context 'single binding component as disabled update disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $false
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
        
        $result = $xNetworkAdapterBindingInstance.Update_TargetResource()
        
        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }
        
        It 'should call Get-NetAdapterBinding' {
            Assert-MockCalled Get-NetAdapterBinding -Exactly 1
        }
    }
     
    Context 'single binding component as enabled update disabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $true
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }
        Mock Disable-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result.Enabled = $false }

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
        
        $result = $xNetworkAdapterBindingInstance.Update_TargetResource()
        
        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }
       
        It 'should call mock' {
            Assert-MockCalled Get-NetAdapterBinding -Exactly 2
            Assert-MockCalled Disable-NetAdapterBinding -Exactly 1
        }

    }

    Context 'single binding component as disabled update enabled' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetAdapterBinding_Result = @{
            InterfaceAlias = $MockAdapterInterfaceAlias
            ComponentId    = 'ms_tcpip63'
            Enabled        = $false
        }

        # mock overrides
        Mock Get-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result }
        Mock Enable-NetAdapterBinding -Verifiable -MockWith { $Mock_GetNetAdapterBinding_Result.Enabled = $true }

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
        
        $result = $xNetworkAdapterBindingInstance.Update_TargetResource()
        
        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }
       
        It 'should call mock' {
            Assert-MockCalled Get-NetAdapterBinding -Exactly 2
            Assert-MockCalled Enable-NetAdapterBinding 1
        }
    }
}

