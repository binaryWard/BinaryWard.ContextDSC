Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkConnectionProfile\Test_TargetResource" {
    
    Context 'public profile with target public' {
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
        $result = $xNetworkConnectionProfileInstance.Test_TargetResource()
        It 'should return true' {
            $result | Should Be $True
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

     
    Context 'private profile with target private' {
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
        $result = $xNetworkConnectionProfileInstance.Test_TargetResource()
        It 'should return true' {
            $result | Should Be $True
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

    
    Context 'public profile with target private' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
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
        $result = $xNetworkConnectionProfileInstance.Test_TargetResource()
        It 'should return false' {
            $result | Should Be $False
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

     
    Context 'private profile with target public' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Mock_GetNetConnectionProfile_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Private"
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
        $result = $xNetworkConnectionProfileInstance.Test_TargetResource()
        It 'should return false' {
            $result | Should Be $False
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }
}

