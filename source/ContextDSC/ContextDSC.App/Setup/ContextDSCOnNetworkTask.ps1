Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\..\DomainLayer\ContextDSCAppCore.ps1"

function Register-ContextDSCOnNetworkTask() {
    param(
        [System.IO.FileInfo]$TargetScript
    )
    
    [Xml] $private:taskXml = @"
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2017-07-27T21:19:06.8525917</Date>
    <Author>BinaryWard</Author>
    <URI></URI>
  </RegistrationInfo>
  <Triggers>
    <EventTrigger>
      <Enabled>true</Enabled>
      <Subscription>&lt;QueryList&gt;&lt;Query Id="0" Path="Microsoft-Windows-NetworkProfile/Operational"&gt;&lt;Select Path="Microsoft-Windows-NetworkProfile/Operational"&gt;*[System[Provider[@Name='Microsoft-Windows-NetworkProfile'] and EventID=10000]]&lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;</Subscription>
    </EventTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>Queue</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT1H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell</Command>
      <Arguments></Arguments>
      <WorkingDirectory></WorkingDirectory>
    </Exec>
  </Actions>
</Task>
"@


    $private:workstationConventions = Get-ContextDSCAppConventions
   
    $private:contextDscPath = $("$PSScriptRoot\..\..\BinaryWard.ContextDSC.ps1").Replace("[", "`[").Replace("]", "`]")
    $private:oneventScriptPath = $TargetScript.FullName
    $private:taskXml.Task.Actions.Exec.Arguments = "-ExecutionPolicy bypass -File `"$private:oneventScriptPath`" -ContextDscPath `"$private:contextDscPath`""
    $private:taskXml.Task.Actions.Exec.WorkingDirectory = "$PSScriptRoot\..\..\"

    Register-ScheduledTask -TaskName $private:workstationConventions.ScheduledTask.CdscOnNetworkProfileEvent10000 -Xml $private:taskXml.OuterXml
}

function Unregister-ContextDSCOnNetworkTask() {
    $private:workstationConventions = Get-ContextDSCAppConventions
    Unregister-ScheduledTask -Confirm:$False -TaskName $private:workstationConventions.ScheduledTask.CdscOnNetworkProfileEvent10000
}
  