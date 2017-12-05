Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkConnectionProfile\Get_TargetResource" {
    
    Context 'public profile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
        }

        $Expected_TargetResource_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
        }        

        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $Expected_TargetResource_Result.InterfaceAlias;
            NetworkCategory = $Expected_TargetResource_Result.NetworkCategory;
        }
        
        $result = $xNetworkConnectionProfileInstance.Get_TargetResource()
        
        It 'should return public profile' {
            $result.InterfaceAlias | Should Be $Expected_TargetResource_Result.InterfaceAlias
            $result.NetworkCategory | Should Be $Expected_TargetResource_Result.NetworkCategory
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }
     
    Context 'private profile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
        }

        $Expected_TargetResource_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
        }        

        # mock overrides
        Mock Get-NetConnectionProfile -Verifiable -MockWith { $Mock_GetNetConnectionProfile_Result }

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $Expected_TargetResource_Result.InterfaceAlias;
            NetworkCategory = $Expected_TargetResource_Result.NetworkCategory;
        }
       
        $result = $xNetworkConnectionProfileInstance.Get_TargetResource()
       
        It 'should return private profile' {
            $result.InterfaceAlias | Should Be $Expected_TargetResource_Result.InterfaceAlias
            $result.NetworkCategory | Should Be $Expected_TargetResource_Result.NetworkCategory
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }
}

