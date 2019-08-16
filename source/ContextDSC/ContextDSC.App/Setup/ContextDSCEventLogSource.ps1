Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\DomainLayer\ContextDSCAppCore.ps1"

function Register-ContextDSCEventLogSource () {
    $private:workstationConventions = Get-ContextDSCAppConventions
    New-EventLog -LogName $private:workstationConventions.WinEvent.WinEventLogName.Application -source $private:workstationConventions.WinEvent.WinEventSource.BinaryWardCdcs
}

function Unregister-ContextDSCEventLogSource () {
    $private:workstationConventions = Get-ContextDSCAppConventions
    Remove-EventLog -source "$($private:workstationConventions.WinEvent.WinEventSource.BinaryWardCdcs)"
}
