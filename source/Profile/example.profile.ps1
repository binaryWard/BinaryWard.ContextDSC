[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  # Path to BinaryWard.ContextDSC.ps1 
  [string]$ContextDscPath
)

<#
    A profile is where the desired configuration is defined.

    Network
    The network desired state supports putting a network adapter 
    into a public or private configuration state.  If an adapter
    does not match the criteria it will be put into a public state.
    The public and private state are terms Windows uses to describe
    the network connection profile.  The terms describe the network.
    A network is matched upon the network name or the adapter name.
    Network Name is name Windows has assigned to the network.
    Adapter Name is the name assigned to the network adapter.

    Use network name to set a desired state based upon the connected
    network.  For example different Wi-Fi hotspots.

    Use adapter name to set a constant desired state for an adapter.
    For example a VPN adapter.

    A list is able to be empty
#>

try {
  . $ContextDscPath

  $configData = New-SecurityNetworkProfileModel
  $configData.NetworkNames.Private = @(
    "home-wifi",
    "alt-home-wifi",
    "home-lan"
  )
  $configData.NetworkNames.Public = @(
    "work-wifi",
    "hotspot-wifi",
    "work-lan",
    "friend-wifi"
  )
  $configData.AdapterNames.Private = @(
  )
  $configData.AdapterNames.Public = @(
    "LanAdapter-02",
    "WiFi-02"
  )

  <#
    Prepare the execute of the desired state configuration
  #>
  $profileStates = Get-Security_PublicPrivateNetwork_ConfigurationtState -ConfigurationData $configData

  $applicationSetStateModel = New-ApplicationSetStateModel
  $applicationSetStateModel.Metadata = @{}
  $applicationSetStateModel.ConfigurationStates.AddRange(@($profileStates))
  Invoke-ApplicationStateController -ApplicationSetStateMode  $applicationSetStateModel
}
finally {

}