# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

Start-Service -Name "MpsSvc" # start firewall service
Start-Process -FilePath sc.exe -ArgumentList 'start winlogbeat'
Start-Process -FilePath sc.exe -ArgumentList 'status winlogbeat'
get-aduser -Filter 'Name -like "*oper"'
get-service "wuauserv"       -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename –autosize # windows update
get-service "Zabbix Agent 2"
get-service "Zabbix Agent 2" -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename –autosize
get-content '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' # cat
hostname | select-string -pattern '[abcx]' # grep

[system.net.dns]::gethostbyname is deprecated
[system.net.dns]::gethostentry($env:computername).hostname # fqdn hostname -f
[system.net.dns]::gethostentry($env:computername).hostname -split("\.")
([system.net.dns]::gethostentry($env:computername).hostname -split("\."))[0]
([system.net.dns]::gethostentry($env:computername).hostname -match("\.([^.]+)"))[0]
select-String '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' -Pattern ^Server # grep
get-content '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.log' -Tail 100 # tail
get-content 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' -Tail 100 # tail

Get-Help Search-ADAccount -ShowWindow

Get-ComputerInfo | select WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer, CsName, CsDomain, CsModel # no remote call
Get-ComputerInfo | select WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer, @{n='displayname';e={$_.csname.tolower() + '.' + $_.csdomain}}, CsModel # no remote call
Get-WmiObject -class win32_operatingsystem -computer remotemachine # there is a version but not human readable&
(Get-NetIPConfiguration|Where-Object{$_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress
shutdown.exe /l

<# multiline comment start
multiline comment continued
multiline comment end #>

# regex
https://powershellexplained.com/2017-07-31-Powershell-regex-regular-expression/
can be used with .net
[regex].replace('\d+', hostname, '_')
https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.match?view=net-6.0


Invoke-command -computername mymachine -scriptblock {(get-eventlog -logname System -newest 40 )}

get-vmsnapshot      -vmname mymachine
remove-vmsnapshot   -vmname mymachine -name "my snap shot"
restore-vmsnapshot
export-vmsnapshot
