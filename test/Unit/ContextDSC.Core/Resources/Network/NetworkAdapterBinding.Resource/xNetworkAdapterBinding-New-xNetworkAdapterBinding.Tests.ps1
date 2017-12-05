Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\..\source\ContextDSC.Core\Resources\Network\NetworkAdapterBinding.Resource\xNetworkAdapterBinding.ps1"

Describe "Resource\xNetworkAdapterBinding\New-xNetworkAdapterBinding" {
    
    Context 'class constructor using hashtable to supply arguments' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkAdapterBindingInstance = [xNetworkAdapterBinding]@{
            InterfaceAlias = $MockAdapterInterfaceAlias;
            ComponentId    = 'ms_tcpip63';
            State          = 'Enabled';
        }
 
        It 'should be an instance with the desired state properties set' {
            $xNetworkAdapterBindingInstance.InterfaceAlias | Should Be $MockAdapterInterfaceAlias
            $xNetworkAdapterBindingInstance.ComponentId | Should Be 'ms_tcpip63'
            $xNetworkAdapterBindingInstance.State | Should be 'Enabled'
        }
    }
    
    Context 'new function using hashtable to supply arguments' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkAdapterBindingInstance = New-xNetworkAdapterBinding @{
            InterfaceAlias = $MockAdapterInterfaceAlias;
            ComponentId    = 'ms_tcpip63';
            State          = 'Enabled';
        }
 
        It 'should be an instance with the desired state properties set' {
            $xNetworkAdapterBindingInstance.InterfaceAlias | Should Be $MockAdapterInterfaceAlias
            $xNetworkAdapterBindingInstance.ComponentId | Should Be 'ms_tcpip63'
            $xNetworkAdapterBindingInstance.State | Should be 'Enabled'
        }
    }

    Context 'declare literal array using class constructor' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkAdapterBindingInstances = @(
            [xNetworkAdapterBinding] @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_msclient";
                State          = "Disabled";
            },
            [xNetworkAdapterBinding] @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_lldp";
                State          = "Disabled";
            },
            [xNetworkAdapterBinding] @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_lltdio";
                State          = "Disabled";
            },
            [xNetworkAdapterBinding] @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_rspndr";
                State          = "Disabled";
            },
            [xNetworkAdapterBinding] @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_server";
                State          = "Disabled";
            }
        )
 
        It 'should be an array of the configuration states' {
            $xNetworkAdapterBindingInstances.Count | Should Be 5
        }
    }

    Context 'declare literal array using function' {
        # Find out why this fails.  what is going on with the types during runtime?
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkAdapterBindingInstances = @(
            New-xNetworkAdapterBinding @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_msclient";
                State          = "Disabled";
            },
            New-xNetworkAdapterBinding @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_lldp";
                State          = "Disabled";
            },
            New-xNetworkAdapterBinding @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_lltdio";
                State          = "Disabled";
            },
            New-xNetworkAdapterBinding @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_rspndr";
                State          = "Disabled";
            },
            New-xNetworkAdapterBinding @{
                InterfaceAlias = $MockAdapterInterfaceAlias;
                ComponentId    = "ms_server";
                State          = "Disabled";
            }
        )
 
        It 'should be an array of the configuration states' {
            $xNetworkAdapterBindingInstances.Count | Should Be 5
        }
    }

    Context 'declare literal array using wrapped function' {
        $MockAdapterInterfaceAlias = "Ethernet$([System.Guid]::NewGuid().ToString("n"))"

        $xNetworkAdapterBindingInstances = @(
            $(New-xNetworkAdapterBinding @{
                    InterfaceAlias = $MockAdapterInterfaceAlias;
                    ComponentId    = "ms_msclient";
                    State          = "Disabled";
                }),
            $(New-xNetworkAdapterBinding @{
                    InterfaceAlias = $MockAdapterInterfaceAlias;
                    ComponentId    = "ms_lldp";
                    State          = "Disabled";
                }),
            $(New-xNetworkAdapterBinding @{
                    InterfaceAlias = $MockAdapterInterfaceAlias;
                    ComponentId    = "ms_lltdio";
                    State          = "Disabled";
                }),
            $(New-xNetworkAdapterBinding @{
                    InterfaceAlias = $MockAdapterInterfaceAlias;
                    ComponentId    = "ms_rspndr";
                    State          = "Disabled";
                }),
            $(New-xNetworkAdapterBinding @{
                    InterfaceAlias = $MockAdapterInterfaceAlias;
                    ComponentId    = "ms_server";
                    State          = "Disabled";
                })
        )
 
        It 'should be an array of the configuration states' {
            $xNetworkAdapterBindingInstances.Count | Should Be 5
        }
    }
}

