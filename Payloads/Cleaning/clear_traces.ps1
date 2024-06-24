
$wshell = New-Object -ComObject WScript.Shell; 
$wshell.RegDelete("HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_0483&PID_5740");