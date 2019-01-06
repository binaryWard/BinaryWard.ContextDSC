Set-StrictMode -Version 'Latest'
function GetNetConnectionProfileName() {
  (Get-NetConnectionProfile).Name | Sort-Object | Get-Unique
}

function HasElevatedShell() {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent( ) )
  return $currentPrincipal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator ) 
}

<#
  Using the registry to obtain the list of networks.
  netsh will work without elevated acccess but it fails to handle UTF-8 correctly.
  Extended ASCII > 127 is encoded as UTF-8 two bytes and these applications fail to hanle this correctly.
#>

function TryGetRegistryProfileName() {
  <#
    To access the registry the shell must be run as administrator.  
    The shell must have elevated access to obtain all networks stored in the registry.
  #>

  if ( -not (HasElevatedShell) ){
    return
  }

  GetRegistryProfileName
}

function GetRegistryProfileName() {
  
  try {
    Push-Location 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles'
    (Get-Childitem | Get-ItemProperty).ProfileName 
  }
  finally {
    Pop-Location
  }
}