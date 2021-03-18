# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

Start-Service -Name "MpsSvc" # start firewall service
get-service "wuauserv"       -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename –autosize # windows update
get-service "Zabbix Agent 2"
get-service "Zabbix Agent 2" -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename –autosize
get-content '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' # cat
select-String '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' -Pattern ^Server # grep
get-content '\\remotemachine\C$\Program Files\Zabbix Agent 2\zabbix_agent2.log' -Tail 100 # tail
get-content 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' -Tail 100 # tail

Get-ComputerInfo | select WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer, CsName, CsDomain, CsModel # no remote call
Get-ComputerInfo | select WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer, @{n='displayname';e={$_.csname.tolower() + '.' + $_.csdomain}}, CsModel # no remote call
Get-WmiObject -class win32_operatingsystem -computer remotemachine # there is a version but not human readable&
(Get-NetIPConfiguration|Where-Object{$_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress
shutdown.exe /l

<# multiline comment start
multiline comment continued
multiline comment end #>
