Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\source\ContextDSC\ContextDSC.SFFP\Security\Resource\PublicPrivateConnectionProfileSFFP.ps1"


Describe "ContextDSC.SFFP\Security\ConnectionProfile Resource Profile" {
    
    Context 'Public configuration states' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $profileConfigurationStates = Get-Public_Security_ConnectionProfile_ConfigurationtState -InterfaceAlias $MockAdapterInterfaceAlias
        
       
        It 'should return all with public NetworkCategory' {
            $profileConfigurationStates.NetworkCategory -eq "Public" | Should Be $true
        }
    }
    
    Context 'Private configuration states' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $profileConfigurationStates = Get-Private_Security_ConnectionProfile_ConfigurationtState -InterfaceAlias $MockAdapterInterfaceAlias
        
        It 'should return all with private NetworkCategory' {
            $profileConfigurationStates.NetworkCategory -eq "Private" | Should Be $true
        }
    }
}

