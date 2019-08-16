Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\source\ContextDSC\ContextDSC.App\DomainLayer\Model\ApplicationSetStateModel.ps1"

Describe "ContextDSC.App\DomainLayer\Model\ApplicationSetStateModel" {
    
    Context 'New ApplicationSetStateModel' {
       
        $model = New-ApplicationSetStateModel

        It 'should be initialized' {
            $model.Metadata | Should Be $Null
            $model.ConfigurationStates.Count | Should Be 0
        }

    }
    
     
    Context 'add to configuration state list' {
        
        $model = New-ApplicationSetStateModel
        $model.ConfigurationStates.Add("item")
        $model.ConfigurationStates.AddRange(@(5,8,4,9,3,9))
        It 'should be contain items' {
            $model.Metadata | Should Be $Null
            $model.ConfigurationStates.Count | Should Be 7
        }
 
    }
     
}

