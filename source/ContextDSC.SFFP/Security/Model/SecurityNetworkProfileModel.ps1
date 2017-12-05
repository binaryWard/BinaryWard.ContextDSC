Set-StrictMode -Version 'Latest'
function New-SecurityNetworkProfileModel() {
    Write-Output @{
        NetworkNames = @{
            Private = @();
            Public  = @();
        };
        AdapterNames = @{
            Private = @();
            Public  = @();
        };
    }
}