Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\DomainLayer\Resource\Network\BinaryWard.ContextDSC.GetNetworkName.ps1"

<#
  Use Get-NetConnectionProfile to get the list of active networks and the network adapter
  to identify the network used by a specific network adapter.
#>

<#
  Use the registry key for the network and view the binary value.  This is the most effective way to correctly
  get the network name if it uses extended ASCII or UNICODE.
#>

<# 
  Network names with extended ASCII or unicode may not copy/paste correctly from a terminal.
  To get the names the list must be saved to a UTF-8 file with the BOM bytes set.
#>

GetNetworkName