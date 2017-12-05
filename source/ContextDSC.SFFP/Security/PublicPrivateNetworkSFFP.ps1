Set-StrictMode -Version 'Latest'

function Get-Security_PublicPrivateNetwork_ConfigurationtState() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [System.Collections.Hashtable]$ConfigurationData
    )

    BEGIN {
        . "$PSScriptRoot\Resource\PublicPrivateAdapterBindingSFFP.ps1"
        . "$PSScriptRoot\Resource\PublicPrivateConnectionProfileSFFP.ps1"
    }

    PROCESS {
        function Get-PublicConnectionConfigurationStates([string]$interfaceAlias) {
            # ADAPTER BINDING
            Get-Public_Security_AdapterBinding_ConfigurationtState -InterfaceAlias $interfaceAlias
    
            # CONNECTION PROFILE
            Get-Public_Security_ConnectionProfile_ConfigurationtState -InterfaceAlias $interfaceAlias
        }
        function Get-PrivateConnectionConfigurationStates([string]$interfaceAlias) {
            # ADAPTER BINDING
            Get-Private_Security_AdapterBinding_ConfigurationtState -InterfaceAlias $interfaceAlias
    
            # CONNECTION PROFILE
            Get-Private_Security_ConnectionProfile_ConfigurationtState -InterfaceAlias $interfaceAlias
        }

        #####> Configuration 
        $private:privateNetworks = $ConfigurationData.NetworkNames.Private.Clone()

        # Networks that are trusted to connect to but should be configured with higher security
        $private:publicNetworks = $ConfigurationData.NetworkNames.Public.Clone()

        # Network Adapters that are always considered public connections.  The network name will be obtained from the adapter for the network profile assignment.
        $private:publicAdapters = $ConfigurationData.AdapterNames.Public.Clone()

        # Network Adapters that are always considered private connections.  The network name will be obtained from the adapter for the network profile assignment.
        $private:privateAdapters = $ConfigurationData.AdapterNames.Private.Clone()

    
        #####<  Configuration

        #
        # S-----------------------------------------------------------------------------------------S

        $private:netConnectionProfiles = Get-NetConnectionProfile
        foreach ( $private:netConnectionProfile in $private:netConnectionProfiles) {    
            # Adding network based upon the adapter names from configuration.
            if ( $private:publicAdapters.Contains($private:netConnectionProfile.InterfaceAlias)) {
                $private:publicNetworks = $private:publicNetworks + $private:netConnectionProfile.Name
            }
            elseif ( $private:privateAdapters.Contains($private:netConnectionProfile.InterfaceAlias)) {
                $private:privateNetworks = $private:privateNetworks + $private:netConnectionProfile.Name
            }

            # private
            if ($private:privateNetworks.Contains($private:netConnectionProfile.Name)) {
                Get-PrivateConnectionConfigurationStates -InterfaceAlias $private:netConnectionProfile.InterfaceAlias
            } 
            # public
            elseif ($private:publicNetworks.Contains($private:netConnectionProfile.Name)) {
                Get-PublicConnectionConfigurationStates -InterfaceAlias $private:netConnectionProfile.InterfaceAlias
            }
            # else
            else {
                # networks not tracked default to public network settings
                Get-PublicConnectionConfigurationStates -InterfaceAlias $private:netConnectionProfile.InterfaceAlias
            }   
        }
    }

    END {}
}
