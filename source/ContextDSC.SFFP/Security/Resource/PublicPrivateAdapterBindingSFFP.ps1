Set-StrictMode -Version 'Latest'
. "$PSScriptRoot\..\..\..\ContextDSC.Core\BinaryWard.ContextDSC.Core.ps1"

function Get-Public_Security_AdapterBinding_ConfigurationtState() {
    [cmdletbinding()]Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$InterfaceAlias
    )

    return @(
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_msclient";
                State          = "Disabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_lldp";
                State          = "Disabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_lltdio";
                State          = "Disabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_rspndr";
                State          = "Disabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_server";
                State          = "Disabled";
            })
    )
}

function Get-Private_Security_AdapterBinding_ConfigurationtState() {
    [cmdletbinding()]Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$InterfaceAlias
    )

    return @(
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_msclient";
                State          = "Enabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_lldp";
                State          = "Enabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_lltdio";
                State          = "Enabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_rspndr";
                State          = "Enabled";
            }),
        $(New-xNetworkAdapterBinding @{
                InterfaceAlias = $InterfaceAlias;
                ComponentId    = "ms_server";
                State          = "Enabled";
            })
    )
}
