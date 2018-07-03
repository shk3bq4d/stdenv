
https://superuser.com/questions/952870/how-do-i-force-ie-and-or-microsoft-edge-to-reload-pac-file
Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings
Value: EnableAutoproxyResultCache (REG_DWORD)
1 (default) = enable caching and 0 = disable caching

file://C:\Users\myuser\cygwin64\home\myuser\proxy.corp.pac

chrome://net-internals/#events
PAC_JAVASCRIPT_ALERT
PROXY_SCRIPT_DECIDER
alert("Local IP address is: " + myIpAddress());
