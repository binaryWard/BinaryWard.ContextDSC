Set-StrictMode -Version 'Latest'
function New-CDSCApplyResult() {
    Write-Output @{
        ApplyResult = $Null
        Resources   = $Null
    }
}
