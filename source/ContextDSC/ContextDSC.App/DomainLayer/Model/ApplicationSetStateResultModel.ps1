Set-StrictMode -Version 'Latest'
function New-ApplicationSetStateResultModel() {
    Write-Output @{
        Metadata        = $Null;
        CDSCApplyResult = $Null;
        Exception       = $Null;
    }
}
