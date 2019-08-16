Set-StrictMode -Version 'Latest'


Describe "ContextDSC.SFFP\Security\PublicPrivateNetworkSFFP" {
    #Import-Module -Name "$PSScriptRoot\..\..\..\..\source\ContextDSC\ContextDSC.SFFP\BinaryWard.ContextDSC.SFFP.psd1"
    . "$PSScriptRoot\..\..\..\..\source\ContextDSC\ContextDSC.SFFP\Security\Model\SecurityNetworkProfileModel.ps1" 
    . "$PSScriptRoot\..\..\..\..\source\ContextDSC\ContextDSC.SFFP\Security\PublicPrivateNetworkSFFP.ps1"

    Context 'Empty config and no net connection profiles' {

        Mock Get-NetConnectionProfile -Verifiable -MockWith { Write-Output @() }

        $configData = New-SecurityNetworkProfileModel
        $profileStates = Get-Security_PublicPrivateNetwork_ConfigurationtState -ConfigurationData $configData

        It 'should return no states' {
            @($profileStates).Count | Should Be 0
        }

        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

    Context 'Empty config and has net connection profiles' {
        
        $Mock_GetNetConnectionProfile_Result = @(@{
                InterfaceAlias  = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
                Name            = "Name-$([System.Guid]::NewGuid().ToString("n"))"
                NetworkCategory = "Public"
            },
            @{
                InterfaceAlias  = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
                Name            = "Name-$([System.Guid]::NewGuid().ToString("n"))"
                NetworkCategory = "Private"
            }
        )

        Mock Get-NetConnectionProfile -Verifiable -MockWith { Write-Output $Mock_GetNetConnectionProfile_Result }
        
        $configData = New-SecurityNetworkProfileModel
        $profileStates = Get-Security_PublicPrivateNetwork_ConfigurationtState -ConfigurationData $configData
        
        $NetworkAdapterBindingStateCount = 5
        $NetworkConnectionProfileStateCount = 1
        $ExpectedCount = $Mock_GetNetConnectionProfile_Result.Count * ($NetworkAdapterBindingStateCount + $NetworkConnectionProfileStateCount)
        It 'should return expected count' {
            @($profileStates).Count | Should Be $ExpectedCount
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

    
    Context 'config and no net connection profiles' {
        
        Mock Get-NetConnectionProfile -Verifiable -MockWith { Write-Output @() }
        
        $configData = New-SecurityNetworkProfileModel
        $configData.NetworkNames.Private = @(
            "PrivateName-$([System.Guid]::NewGuid().ToString("n"))", 
            "PrivateName-$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.NetworkNames.Public = @(
            "PublicName-$([System.Guid]::NewGuid().ToString("n"))", 
            "PublicName-$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.AdapterNames.Private = @(
            "PrivateEthernet$([System.Guid]::NewGuid().ToString("n"))",
            "PrivateEthernet$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.AdapterNames.Public = @(
            "PublicEthernet$([System.Guid]::NewGuid().ToString("n"))",
            "PublicEthernet$([System.Guid]::NewGuid().ToString("n"))"
        )

        $profileStates = Get-Security_PublicPrivateNetwork_ConfigurationtState -ConfigurationData $configData
        
        It 'should return no states' {
            @($profileStates).Count | Should Be 0
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }

    
    Context 'config and has net connection profiles' {
        $MockNetworkName = "Name-$([System.Guid]::NewGuid().ToString("n"))"

        $Mock_GetNetConnectionProfile_Result = @(@{
                InterfaceAlias  = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"
                Name            = $MockNetworkName
                NetworkCategory = "Public"
            }
        )

        Mock Get-NetConnectionProfile -Verifiable -MockWith { Write-Output $Mock_GetNetConnectionProfile_Result }
        
        $configData = New-SecurityNetworkProfileModel
        $configData.NetworkNames.Private = @(
            $MockNetworkName, 
            "PrivateName-$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.NetworkNames.Public = @(
            "PublicName-$([System.Guid]::NewGuid().ToString("n"))", 
            "PublicName-$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.AdapterNames.Private = @(
            "PrivateEthernet$([System.Guid]::NewGuid().ToString("n"))",
            "PrivateEthernet$([System.Guid]::NewGuid().ToString("n"))"
        )
        $configData.AdapterNames.Public = @(
            "PublicEthernet$([System.Guid]::NewGuid().ToString("n"))",
            "PublicEthernet$([System.Guid]::NewGuid().ToString("n"))"
        )
        $profileStates = Get-Security_PublicPrivateNetwork_ConfigurationtState -ConfigurationData $configData
        
        $NetworkAdapterBindingStateCount = 5
        $NetworkConnectionProfileStateCount = 1
        $ExpectedCount = $Mock_GetNetConnectionProfile_Result.Count * ($NetworkAdapterBindingStateCount + $NetworkConnectionProfileStateCount)
       
        It 'should return expected count' {
            @($profileStates).Count | Should Be $ExpectedCount
        }
        
        It 'should call mock methods' {
            Assert-MockCalled -commandName Get-NetConnectionProfile -Exactly 1
        }
    }
}