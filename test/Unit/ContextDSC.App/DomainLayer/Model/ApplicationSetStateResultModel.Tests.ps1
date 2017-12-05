Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\source\ContextDSC.App\DomainLayer\Model\ApplicationSetStateResultModel.ps1"

Describe "ContextDSC.App\DomainLayer\Model\ApplicationSetStateResultModel" {
    
    Context 'New ApplicationSetStateResultModel' {
       
        $model = New-ApplicationSetStateResultModel

        It 'should be initialized' {
            $model.Metadata | Should Be $Null
            $model.CDSCApplyResult | Should Be $Null
            $model.Exception | Should Be $Null
        }

    }
    
}

