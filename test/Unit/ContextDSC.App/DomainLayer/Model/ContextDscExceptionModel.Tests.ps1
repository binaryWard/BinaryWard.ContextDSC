Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\..\source\ContextDSC.App\DomainLayer\Model\ContextDscExceptionModel.ps1"

Describe "ContextDSC.App\DomainLayer\Model\ContextDscExceptionModel" {
    
    Context 'New ContextDscExceptionModel' {
       
        $model = New-ContextDscExceptionModel

        It 'should be initialized' {
            $model.Message | Should Be $Null
            $model.Stack | Should Be $Null
        }

    }
    
     
    Context 'New ContextDscExceptionModel from exception' {
        $exception=$null
        try {
            throw "mock script exception"
        }
        catch {
            $exception = $_.Exception
        }

         $model = New-ContextDscExceptionModel -Exception $exception
 
         It 'should have exception values' {
             [System.String]::IsNullOrEmpty($model.Message) | Should Be $False
         }
 
     }
}

