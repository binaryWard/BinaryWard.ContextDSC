Set-StrictMode -Version 'Latest'
function New-xNetworkAdapterBindingResourceModel() {
    Write-Output @{
        ResourceName   = $Null;
        InterfaceAlias = $Null;
        ComponentId    = $Null;
        State          = $Null;
    }
}