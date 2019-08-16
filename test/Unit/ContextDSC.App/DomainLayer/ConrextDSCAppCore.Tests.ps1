Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\..\..\..\source\ContextDSC\ContextDSC.App\DomainLayer\ContextDSCAppCore.ps1"

Describe "ContextDSC.App\DomainLayer\ContextDSCAppCore" {
    
    Context 'get conventions' {
        $cdscConventions = Get-ContextDSCAppConventions

        It 'returns convention model' {
            $cdscConventions.ContainsKey("WinEvent") | Should Be $True
            $cdscConventions.ContainsKey("ScheduledTask") | Should Be $True
    
        }
    }
}