# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

Start-Service -Name "MpsSvc" # start firewall service
get-service "Zabbix Agent 2" -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename –autosize
get-content '\\fsmgt101p01\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' # cat
select-String '\\fsmgt101p01\C$\Program Files\Zabbix Agent 2\zabbix_agent2.conf' -Pattern ^Server # grep
get-content '\\fsmgt101p01\C$\Program Files\Zabbix Agent 2\zabbix_agent2.log' -Tail 100 # tail

<# multiline comment start
multiline comment continued
multiline comment end #>
