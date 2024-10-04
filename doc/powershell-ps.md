# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

Start-Service -Name "MpsSvc" # start firewall service
Start-Process -FilePath sc.exe -ArgumentList 'start winlogbeat'
Start-Process -FilePath sc.exe -ArgumentList 'status winlogbeat'
get-aduser -Filter 'Name -like "*oper"'
get-service "wuauserv"       -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename -autosize # windows update
get-service "Zabbix Agent 2"
get-service "Zabbix Agent 2" -ComputerName remotePC1,remotePC2, remotePC3| format-table Name,Status,Machinename -autosize
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
get-content 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' -wait # tail -f follow
powershell.exe get-content 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' -wait # tail -f follow

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
Checkpoint-VM -name mymachine -snapshotname "my snap shot"


# windows service delayed start, dependent dependency
--Create DelayedAutostart property
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MSSQL`$$($Using:InstName)" -Name 'DelayedAutostart' -PropertyType DWord -Value 1
--Set value for DelayedAutostart property
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MSSQL`$$($Using:InstName)" -Name 'DelayedAutostart' -Value 1
-- Add dependencies to SQL server service
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MSSQL`$$($Using:InstName)" -Name 'DependOnService' -Value @("KEYISO", "W32Time")

Test-NetConnection -Computername MYHOSTNETCAT -Port PORT # nc
tnc                -Computername MYHOSTNETCAT -Port PORT
tnc                              MYHOSTNETCAT -Port PORT


$Username = "MyUserName";
$Password = "MyPassword";
$path = "C:\attachment.txt";

function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "YourName@gmail.com";
    $message.To.Add($email);
    $message.Subject = "subject text here...";
    $message.Body = "body text here...";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ;
    $attachment.Dispose();
 }
Send-ToEmail  -email "reciever@gmail.com" -attachmentpath $path;

# function to get stack trace
function Resolve-Error ($ErrorRecord=$Error[0])
{
   $ErrorRecord | Format-List * -Force
   $ErrorRecord.InvocationInfo |Format-List *
   $Exception = $ErrorRecord.Exception
   for ($i = 0; $Exception; $i++, ($Exception = $Exception.InnerException))
   {   "$i" * 80
       $Exception |Format-List * -Force
   }
}

function log() {
  $timestamp = Get-Date -Format "yyyy.MM.dd HH:mm:ss.fff" # %y.%M.%d %H:%m:%s,fff";
  $message = $args -join ' ';  # Concatenate all input arguments into a single string
  $message = "$timestamp $message";
  Write-Host("$message");
  #$LogFile = "c:\Users\myself\Documents\mrclip.log";
  #Add-Content -Path $LogFile -Value $message -Encoding UTF8;
}

`" escape a double quote with a backtick (or use single quotes strings)
`$ escape a dollar sign  with a backtick
