Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\DomainLayer\ApplicationStateController.ps1"
. "$PSScriptRoot\DomainLayer\Model\ApplicationSetStateModel.ps1"
. "$PSScriptRoot\DomainLayer\Model\ApplicationSetStateResultModel.ps1"
. "$PSScriptRoot\DomainLayer\Model\ContextDscExceptionModel.ps1"
. "$PSScriptRoot\Setup\ContextDSCEventLogSource.ps1"
. "$PSScriptRoot\Setup\ContextDSCOnNetworkTask.ps1"