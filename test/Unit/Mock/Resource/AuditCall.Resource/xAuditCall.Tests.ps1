Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\xAuditCall.ps1"
Describe "Mock\Resource\AuditCall.Resource" {
    Context 'create new instance with class constructor using hashtable' {
        $uniqueName = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))"

        $resource = [xAuditCall]@{
            Title = $uniqueName;
        }
        $testCallResult = $resource.Test_TargetResource()
        $updateCallResult = $resource.Update_TargetResource()
        $getCallResult = $resource.Get_TargetResource()
        $getResourceInfo = $resource.Get_ResourceInfo()

        It 'should return true upon first call to test before a set' {
            $testCallResult | Should Be $False
        }

        It 'should be an instance with the title assigned' {
            $getCallResult.Title | Should Be $uniqueName
        }

        It 'should return true upon update call' {
            $updateCallResult | Should Be $True
        }

        It 'should have state values at the expected values after calls' {
            $getCallResult.UpdateCallCount | Should Be 1
            $getCallResult.GetCallCount | Should Be 1
            $getCallResult.TestCallCount | Should Be 3
            $getCallResult.SetCallCount | Should Be 1
            $getCallResult.GetResourceInfoCount | Should Be 0 
            
            $getResourceInfo.GetResourceInfoCount | Should Be 1
        }            
    }
}