Set-StrictMode -Version 'Latest'

function New-ApplicationSetStateModel() {
    Write-Output @{
        Metadata            = $Null;
        ConfigurationStates = [System.Collections.Generic.List[System.Object]]::new();
    }
}