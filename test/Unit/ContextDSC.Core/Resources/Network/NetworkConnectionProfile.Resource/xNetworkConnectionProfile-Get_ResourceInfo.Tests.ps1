Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkConnectionProfile\Get_ResourceInfo" {
    
    Context 'public profile' {
        # mock models
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
        $Expected_TargetResource_Result = @{
            InterfaceAlias  = $MockAdapterInterfaceAlias
            NetworkCategory = "Public"
        }        

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $Expected_TargetResource_Result.InterfaceAlias;
            NetworkCategory = $Expected_TargetResource_Result.NetworkCategory;
        }
        $result = $xNetworkConnectionProfileInstance.Get_ResourceInfo()
        It 'should return public profile' {
            $result.InterfaceAlias | Should Be $Expected_TargetResource_Result.InterfaceAlias
            $result.NetworkCategory | Should Be $Expected_TargetResource_Result.NetworkCategory
        }
    }
}

