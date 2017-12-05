Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\source\ContextDSC.Core\DomainLayer\ConfigurationStateController.ps1"
. "$PSScriptRoot\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"
. "$PSScriptRoot\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "DomainLayer\ConfigurationStateController" {
    
    Context 'Invoke with empty state array' {
        $configurationStates = [System.Collections.Generic.List[System.Object]]::new()
        $invokeResult = Invoke-ConfigurationState -ConfigurationStates $configurationStates

        It 'should return a result of the invokation' {
            $invokeResult.ApplyResult | Should Be $true
            $invokeResult.Resources.Count | Should Be 0
        }
    }

    Context 'Invoke with single xNetworkAdapterBinding' {
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
     
        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $MockAdapterInterfaceAlias;
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId;
            State          = 'Disabled';
        }
             
        $configurationStates = [System.Collections.Generic.List[System.Object]]::new()
        $configurationStates.Add($xNetworkAdapterBindingInstance)
        $invokeResult = Invoke-ConfigurationState -ConfigurationStates $configurationStates

        It 'should return a result of the invokation' {
            $invokeResult.ApplyResult | Should Be $true
            $invokeResult.Resources.Count | Should Be 1
        }
          
        It 'should call mocks in xNetworkAdapterBinding' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 2
            Assert-MockCalled -commandName Disable-NetAdapterBinding -Exactly 1
        }
    }

    Context 'Invoke with single xNetworkConnectionProfile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
        }
     
        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }
        Mock Set-NetConnectionProfile -Verifiable -ParameterFilter { $InterfaceAlias -eq $MockAdapterInterfaceAlias -and $NetworkCategory -eq "Public" } -MockWith {  $Mock_GetNetConnectionProfile_Result.NetworkCategory = $NetworkCategory }
        Mock Set-NetConnectionProfile -MockWith { throw "reached the generic mock.  meaning the mock was not called with the expected arguments" }    
     
        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Public";
        }
             
        $configurationStates = [System.Collections.Generic.List[System.Object]]::new()
        $configurationStates.Add($xNetworkConnectionProfileInstance)
        $invokeResult = Invoke-ConfigurationState -ConfigurationStates $configurationStates

        It 'should return a result of the invokation' {
            $invokeResult.ApplyResult | Should Be $true
            $invokeResult.Resources.Count | Should Be 1
        }
          
        It 'should call mocks in xNetworkConnectionProfile' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 2
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }

    Context 'Invoke with single xNetworkAdapterBinding and xNetworkConnectionProfile' {
        # -- xNetworkAdapterBinding
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
     
        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $MockAdapterInterfaceAlias;
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId;
            State          = 'Disabled';
        }
        
        # -- xNetworkConnectionProfile
        # mock models
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
        }
     
        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }
        Mock Set-NetConnectionProfile -Verifiable -ParameterFilter { $InterfaceAlias -eq $MockAdapterInterfaceAlias -and $NetworkCategory -eq "Public" } -MockWith {  $Mock_GetNetConnectionProfile_Result.NetworkCategory = $NetworkCategory }
        Mock Set-NetConnectionProfile -MockWith { throw "reached the generic mock.  meaning the mock was not called with the expected arguments" }    
     
        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Public";
        }
             
        $configurationStates = [System.Collections.Generic.List[System.Object]]::new()
        $configurationStates.Add($xNetworkAdapterBindingInstance)
        $configurationStates.Add($xNetworkConnectionProfileInstance)
        $invokeResult = Invoke-ConfigurationState -ConfigurationStates $configurationStates

        It 'should return a result of the invokation' {
            $invokeResult.ApplyResult | Should Be $true
            $invokeResult.Resources.Count | Should Be 2
        }
          
        It 'should call mocks in xNetworkAdapterBinding' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 2
            Assert-MockCalled -commandName Disable-NetAdapterBinding -Exactly 1
        }
          
        It 'should call mocks in xNetworkConnectionProfile' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 2
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }

    
    Context 'Invoke with single xNetworkAdapterBinding not passed as array' {
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
     
        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $MockAdapterInterfaceAlias;
            ComponentId    = $Mock_GetNetAdapterBinding_Result.ComponentId;
            State          = 'Disabled';
        }
       
        $invokeResult = Invoke-ConfigurationState -ConfigurationStates $xNetworkAdapterBindingInstance

        It 'should return a result of the invokation' {
            $invokeResult.ApplyResult | Should Be $true
            $invokeResult.Resources.Count | Should Be 1
        }
          
        It 'should call mocks in xNetworkAdapterBinding' {
            Assert-MockCalled -commandName Get-NetAdapterBinding -Exactly 2
            Assert-MockCalled -commandName Disable-NetAdapterBinding -Exactly 1
        }
    }
}