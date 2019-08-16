Set-StrictMode -Version 'Latest'
. "$PSScriptRoot\..\..\..\ContextDSC.Core\BinaryWard.ContextDSC.Core.ps1"

function Get-Public_Security_ConnectionProfile_ConfigurationtState() {
    [cmdletbinding()]Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$InterfaceAlias
    )
  
    return @(
        $(New-xNetworkConnectionProfile @{
                InterfaceAlias  = $InterfaceAlias;
                NetworkCategory = "Public";
            })
    )
}

function Get-Private_Security_ConnectionProfile_ConfigurationtState() {
    [cmdletbinding()]Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$InterfaceAlias
    )

    return @(
        $(New-xNetworkConnectionProfile @{
                InterfaceAlias  = $InterfaceAlias;
                NetworkCategory = "Private";
            })
    )
}
