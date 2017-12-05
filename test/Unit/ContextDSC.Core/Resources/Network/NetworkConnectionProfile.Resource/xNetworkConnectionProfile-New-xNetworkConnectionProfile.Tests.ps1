Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkConnectionProfile.Resource\xNetworkConnectionProfile.ps1"

Describe "Resource\xNetworkAdapterBinding\New-xNetworkConnectionProfile" {
    
    Context 'class constructor using hashtable to supply arguments' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkConnectionProfileInstance = [xNetworkConnectionProfile]@{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = 'Public';
        }
 
        It 'should be an instance with the desired state properties set' {
            $xNetworkConnectionProfileInstance.InterfaceAlias | Should Be $MockAdapterInterfaceAlias
            $xNetworkConnectionProfileInstance.NetworkCategory | Should Be 'Public'
        }
    }
    
    Context 'new function using hashtable to supply arguments' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkConnectionProfileInstance = New-xNetworkConnectionProfile @{
            InterfaceAlias  = $MockAdapterInterfaceAlias;
            NetworkCategory = 'Public';
        }
 
        It 'should be an instance with the desired state properties set' {
            $xNetworkConnectionProfileInstance.InterfaceAlias | Should Be $MockAdapterInterfaceAlias
            $xNetworkConnectionProfileInstance.NetworkCategory | Should Be 'Public'
        }
    }

    Context 'declare listeral array using class' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkConnectionProfileInstances = @([xNetworkConnectionProfile] @{
                InterfaceAlias  = $MockAdapterInterfaceAlias;
                NetworkCategory = 'Public';
            })
 
        It 'should be expected count' {
            $xNetworkConnectionProfileInstances.Count | Should Be 1
        }
    }
    
    Context 'declare listeral array using function' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkConnectionProfileInstances = @(New-xNetworkConnectionProfile @{
                InterfaceAlias  = $MockAdapterInterfaceAlias;
                NetworkCategory = 'Public';
            })
 
        It 'should be expected count' {
            $xNetworkConnectionProfileInstances.Count | Should Be 1
        }
    }

    Context 'declare listeral array using function wrap' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkConnectionProfileInstances = @($(New-xNetworkConnectionProfile @{
                    InterfaceAlias  = $MockAdapterInterfaceAlias;
                    NetworkCategory = 'Public';
                }))
 
        It 'should be expected count' {
            $xNetworkConnectionProfileInstances.Count | Should Be 1
        }
    }
}


