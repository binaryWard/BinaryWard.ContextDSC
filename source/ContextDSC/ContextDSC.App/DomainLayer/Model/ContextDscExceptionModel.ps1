Set-StrictMode -Version 'Latest'

function New-ContextDscExceptionModel() {
    param(
        [System.Exception]$Exception
    )
    $private:exceptionModel = @{
        Message = $Null;
        Stack   = $Null;
    }
    if ($Exception) {   
        $private:exceptionModel.Message = $Exception.Message
        $private:exceptionModel.Stack = $Exception.StackTrace
    }
    Write-Output $private:exceptionModel 
}