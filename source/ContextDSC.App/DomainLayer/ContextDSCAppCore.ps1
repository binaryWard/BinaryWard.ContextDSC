Set-StrictMode -Version 'Latest'
function Get-ContextDSCAppConventions() {
    Import-PowerShellDataFile -Path "$PSScriptRoot\ContextDSCAppConventions.psd1"
}

function Write-ContextDscSetResultEventLog() {    
    param (
        [System.Collections.Hashtable]$LogEntryModel, 
        [switch]$IsError
    )

    try {
        $private:logEntryText = ConvertTo-JSON -InputObject $LogEntryModel -Depth 5
        $private:eventLogEntryType = "Information"

        if ( $IsError -eq $True ) {
            $private:eventLogEntryType = "Error"
        }

        $private:workstationConventions = Get-ContextDSCAppConventions
        Write-EventLog -LogName "$($private:workstationConventions.WinEvent.WinEventLogName.Application)" -source "$($private:workstationConventions.WinEvent.WinEventSource.BinaryWardCdcs)" -EntryType $private:eventLogEntryType -EventId 1978 -Category 0 -Message "$private:logEntryText"
    }
    catch {
        Write-Error -Exception $_.Exception -Message "Failed to log $private:logEntryText"
    }
}
