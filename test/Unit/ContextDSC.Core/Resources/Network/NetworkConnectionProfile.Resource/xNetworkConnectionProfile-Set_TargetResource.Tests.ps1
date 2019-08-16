Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkConnectionProfile\Set_TargetResource" {
    
    Context 'set public profile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        
        # mock overrides
        Mock Set-NetConnectionProfile -Verifiable -ParameterFilter { $InterfaceAlias -eq $MockAdapterInterfaceAlias -and $NetworkCategory -eq "Public" }
        Mock Set-NetConnectionProfile -MockWith { throw "reached the generic mock.  meaning the mock was not called with the expected arguments" }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Public";
        }
        
        $xNetworkConnectionProfileInstance.Set_TargetResource()
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }

     
    Context 'set private profile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        # mock overrides
        Mock Set-NetConnectionProfile -Verifiable -ParameterFilter { $InterfaceAlias -eq $MockAdapterInterfaceAlias -and $NetworkCategory -eq "Private" }
        Mock Set-NetConnectionProfile -MockWith { throw "reached the generic mock.  meaning the mock was not called with the expected arguments" }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = "Private";
        }
        $xNetworkConnectionProfileInstance.Set_TargetResource()

        It 'should call mock methods' {
            Assert-MockCalled -commandName Set-NetConnectionProfile -Exactly 1
        }
    }
}

