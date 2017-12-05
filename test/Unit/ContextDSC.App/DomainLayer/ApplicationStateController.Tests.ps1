Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\source\ContextDSC.App\DomainLayer\ApplicationStateController.ps1"
. "$PSScriptRoot\..\..\..\..\source\ContextDSC.App\DomainLayer\Model\ApplicationSetStateModel.ps1"
. "$PSScriptRoot\..\..\Mock\Resource\AuditCall.Resource\xAuditCall.ps1"

Describe "ContextDSC.App\DomainLayer\ApplicationStateController" {
    
    Context 'empty hashtable' {
        $emptyHashTable = @{}
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateModel $emptyHashTable

        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be $True
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be $True
            $invokeResult.ContainsKey("Exception") | Should Be $True
        }
    }

    Context 'array of empty hashtable' {
        $emptyArray = @(@{}, @{}, @{})
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateModel $emptyArray
 
        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("Exception") | Should Be @($True, $True, $True)
        }
    }

    Context 'empty ApplicationSetStateModel' {
        $applicationSetStateModel = New-ApplicationSetStateModel
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode $applicationSetStateModel
 
        It 'returns utput' {
            $invokeResult.ContainsKey("Metadata") | Should Be $True
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be $True
            $invokeResult.ContainsKey("Exception") | Should Be $True
        }
    }

    Context 'empty ApplicationSetStateModel array' {
        $applicationSetStateModel = @($(New-ApplicationSetStateModel), $(New-ApplicationSetStateModel), $(New-ApplicationSetStateModel))
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode $applicationSetStateModel

        It 'returns null output' {
            $invokeResult.ContainsKey("Metadata") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("Exception") | Should Be @($True, $True, $True)
        }
    }

    Context 'ApplicationSetStateModel: metadata is null, empty states' {
        $applicationSetStateModel = New-ApplicationSetStateModel
        $applicationSetStateModel.Metadata = $Null
        $applicationSetStateModel.ConfigurationStates = @()
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode $applicationSetStateModel

        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be $True
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be $True
            $invokeResult.ContainsKey("Exception") | Should Be $True
        }
    }

    Context 'ApplicationSetStateModel: mock metadata empty states - array' {
        $applicationSetStateModel = New-ApplicationSetStateModel
        $applicationSetStateModel.Metadata = @{
            P = "pdata";
            S = "sdata";
        }
        $applicationSetStateModel.ConfigurationStates = @()
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode  @($applicationSetStateModel, $applicationSetStateModel, $applicationSetStateModel)

        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("Exception") | Should Be @($True, $True, $True)
        }
    }
    
    Context 'ApplicationSetStateModel: mock metadata mock states' {
        $applicationSetStateModel = New-ApplicationSetStateModel
        $applicationSetStateModel.Metadata = @{
            P = "pdata";
            S = "sdata";
        }
        $applicationSetStateModel.ConfigurationStates.AddRange(@(
                [xAuditCall]@{
                    Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                },
                [xAuditCall]@{
                    Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                }, 
                [xAuditCall]@{
                    Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                })
        )
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode  $applicationSetStateModel

        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be $True
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be $True
            $invokeResult.ContainsKey("Exception") | Should Be $True
        }

        It 'should not return exception model' {
            $invokeResult.Exception -eq $null | Should Be $True
        }

        It 'returns metadata' {
            $invokeResult.Metadata.P | Should Be  $applicationSetStateModel.Metadata.P
            $invokeResult.Metadata.S | Should Be  $applicationSetStateModel.Metadata.S
        }

        It 'should return invokation results' {
            $invokeResult.CDSCApplyResult -eq $null | Should Be $false
            $invokeResult.CDSCApplyResult.ApplyResult | Should Be $True
            $invokeResult.CDSCApplyResult.Resources.Count | Should Be 3
            
            for ($i = 0; $i -lt 3; $i++) {
                $invokeResult.CDSCApplyResult.Resources[$i].ResourceName | Should Be "xAuditCall"
                $invokeResult.CDSCApplyResult.Resources[$i].Title | Should Be $applicationSetStateModel.ConfigurationStates[$i].Title
                $invokeResult.CDSCApplyResult.Resources[$i].UpdateCallCount | Should Be 1
                $invokeResult.CDSCApplyResult.Resources[$i].GetCallCount | Should Be 0
                $invokeResult.CDSCApplyResult.Resources[$i].TestCallCount | Should Be 2
                $invokeResult.CDSCApplyResult.Resources[$i].SetCallCount | Should Be 1
                $invokeResult.CDSCApplyResult.Resources[$i].GetResourceInfoCount | Should Be 1
            }
        }
    }

      
    Context 'ApplicationSetStateModel: mock metadata mock states - array' {
        $applicationSetStateModels = @($(New-ApplicationSetStateModel), $(New-ApplicationSetStateModel), $(New-ApplicationSetStateModel))

        foreach ($o in $applicationSetStateModels) {
            $o.Metadata = @{
                P = "pdata:$([System.Guid]::NewGuid().ToString("n"))";
                S = "sdata:$([System.Guid]::NewGuid().ToString("n"))";
            }
            $o.ConfigurationStates.AddRange(@(
                    [xAuditCall]@{
                        Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                    },
                    [xAuditCall]@{
                        Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                    }, 
                    [xAuditCall]@{
                        Title = "xAuditCall:$([System.Guid]::NewGuid().ToString("n"))";
                    })
            )
        }
        $invokeResult = Invoke-ApplicationStateController -ApplicationSetStateMode  $applicationSetStateModels

        It 'returns output' {
            $invokeResult.ContainsKey("Metadata") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("CDSCApplyResult") | Should Be @($True, $True, $True)
            $invokeResult.ContainsKey("Exception") | Should Be @($True, $True, $True)
        }

        It 'returns metadata' {
            for ($m = 0; $m -lt 3; $m++) {
                $invokeResult[$m].Metadata.P | Should Be  $applicationSetStateModels[$m].Metadata.P
                $invokeResult[$m].Metadata.S | Should Be  $applicationSetStateModels[$m].Metadata.S
            }
        }

        It 'should return invocation results' {
            for ($m = 0; $m -lt 3; $m++) {
                $invokeResult[$m].CDSCApplyResult -eq $null | Should Be $false
                $invokeResult[$m].CDSCApplyResult.ApplyResult | Should Be $True
                $invokeResult[$m].CDSCApplyResult.Resources.Count | Should Be 3
            
                for ($i = 0; $i -lt 3; $i++) {
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].ResourceName | Should Be "xAuditCall"
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].Title | Should Be $applicationSetStateModels[$m].ConfigurationStates[$i].Title
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].UpdateCallCount | Should Be 1
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].GetCallCount | Should Be 0
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].TestCallCount | Should Be 2
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].SetCallCount | Should Be 1
                    $invokeResult[$m].CDSCApplyResult.Resources[$i].GetResourceInfoCount | Should Be 1
                }
            }
        }
    }
}

