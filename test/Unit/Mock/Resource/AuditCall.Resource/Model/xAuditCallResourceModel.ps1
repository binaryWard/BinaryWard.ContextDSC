Set-StrictMode -Version 'Latest'
function New-xAuditCallResourceModel() {
    Write-Output @{
        ResourceName         = $Null;
        Title                = $Null;
        UpdateCallCount      = 0;
        GetCallCount         = 0;
        TestCallCount        = 0;
        SetCallCount         = 0;
        GetResourceInfoCount = 0;
    }
}