[CmdletBinding()]
param(
    [System.IO.FileInfo]$TargetScript
)

. "$PSScriptRoot\ContextDSCOnNetworkTask.ps1"

Register-ContextDSCOnNetworkTask -TargetScript $TargetScript