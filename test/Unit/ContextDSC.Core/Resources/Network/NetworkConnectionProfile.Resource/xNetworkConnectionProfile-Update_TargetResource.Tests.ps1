Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkConnectionProfile\Update_TargetResource" {
    
    Context 'update private profile with public' {
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
        
        $result = $xNetworkConnectionProfileInstance.Update_TargetResource()
        
        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 2
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }
     
    Context 'update public profile with private' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
        }

        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }
        Mock Set-NetConnectionProfile -Verifiable -ParameterFilter { $InterfaceAlias -eq $MockAdapterInterfaceAlias -and $NetworkCategory -eq "Private" } -MockWith {  $Mock_GetNetConnectionProfile_Result.NetworkCategory = $NetworkCategory }
        Mock Set-NetConnectionProfile -MockWith { throw "reached the generic mock.  meaning the mock was not called with the expected arguments" }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Private";
        }
        
        $result = $xNetworkConnectionProfileInstance.Update_TargetResource()

        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 2
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }

    Context 'update private profile with private' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
        }

        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }
        Mock Set-NetConnectionProfile -MockWith { throw "should not be called" }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Private";
        }
        
        $result = $xNetworkConnectionProfileInstance.Update_TargetResource()
        
        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 0
        }
    }

    Context 'update public profile with public' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
        }

        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }
        Mock Set-NetConnectionProfile -MockWith {throw "should not be called" }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Public";
        }
        
        $result = $xNetworkConnectionProfileInstance.Update_TargetResource()

        It 'should return true if in expected state or set successfully.' {
            $result | should be $true
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 0
        }
    }
}

