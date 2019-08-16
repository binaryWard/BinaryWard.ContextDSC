Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\source\ContextDSC\ContextDSC.SFFP\Security\Resource\PublicPrivateAdapterBindingSFFP.ps1"


Describe "ContextDSC.SFFP\Security\AdapterBinding Resource Profile" {
    
    Context 'Public configuration states' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $profileConfigurationStates = Get-Public_Security_AdapterBinding_ConfigurationtState -InterfaceAlias $MockAdapterInterfaceAlias
        
        It 'should return expected number of states' {
            $profileConfigurationStates.Length | Should Be 5
        }

        It 'should return all with disabled state' {
            ($($profileConfigurationStates).State -eq "Disabled").Count | Should Be 5
        }

        It 'should return the expected componentIds' {
            $expectedComponentIds = @("ms_msclient", "ms_lldp", "ms_lltdio", "ms_rspndr", "ms_server")
            $actualComponentIds = $($profileConfigurationStates).ComponentId | Sort-Object -Unique

            $actualComponentIds.Count | Should Be 5
            (Compare-Object -referenceObject $expectedComponentIds -differenceObject $actualComponentIds -includeEqual).Count | Should Be 5
        }
    }
    
    Context 'Private configuration states' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $profileConfigurationStates = Get-Private_Security_AdapterBinding_ConfigurationtState -InterfaceAlias $MockAdapterInterfaceAlias
        
        It 'should return expected number of states' {
            $profileConfigurationStates.Length | Should Be 5
        }

        It 'should return all with enabled state' {
            ($($profileConfigurationStates).State -eq "Enabled").Count | Should Be 5
        }

        It 'should return the expected componentIds' {
            $expectedComponentIds = @("ms_msclient", "ms_lldp", "ms_lltdio", "ms_rspndr", "ms_server")
            $actualComponentIds = $($profileConfigurationStates).ComponentId | Sort-Object -Unique

            $actualComponentIds.Count | Should Be 5
            (Compare-Object -referenceObject $expectedComponentIds -differenceObject $actualComponentIds -includeEqual).Count | Should Be 5
        }
    }
}

