# windows 10 iso download
https://www.microsoft.com/en-us/download/details.aspx?id=56485


WMIC PROCESS get Caption,Commandline,Processid 2>&1 | vi -
WMIC /OUTPUT:"C:\ProcessList.txt" process where processid=8196 get Caption,Commandline,Processid
wmic process where "caption='chrome.exe'" get caption,commmandLine,processId
wmic process where "caption like 'c%.ex_' and processId<5000" get caption,commandLine,processId
wmic process where "caption like 'zabbix%'" get caption,commandLine,processId
wmic process where "caption like 'zabbix%'" get *
wmic service where "name like 'zabbix%'"
wmic service where "name like 'zabbix%'" get caption,processid,name,statuswmic service where "name like 'zabbix%'"
sc query "Zabbix Agent 2"
sc delete "Zabbix Agent"
sc stop "Zabbix Agent 2"
sc start "Zabbix Agent 2"
Get-Content "C:\Program Files\Zabbix Agent 2\zabbix_agent2.log.old" -Tail 30
Get-Content "C:\Program Files\Zabbix Agent 2\zabbix_agent2.log" -Tail 30

disable windows key
google Microsoft Fix it 50465
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Keyboard Layout
REG_BINARY "Scancode Map" 00000000 00000000 03000000 00005BE0 00005CE0 00000000

Scancode Map spec: http://msdn.microsoft.com/en-us/library/windows/hardware/gg463447.aspx
Value	Interpretation
0x00000000	Header: Version. Set to all zeroes.
0x00000000	Header: Flags. Set to all zeroes.
0x00000003	Three entries in the map (including null entry).
0xE01D0000	Remove the right CTRL key (0xE01D --> 0x00).
0xE038E020	Right ALT key --> Mute key (0xE038 --> 0xE020).
0x00000000	Null terminator.

0x001D003A Left CTRL key --> CAPS LOCK (0x1D --> 0x3A).
0x003A001D CAPS LOCK --> Left CTRL key (0x3A --> 0x1D).
0xE01D0000	Remove the right CTRL key (0xE01D --> 0x00).
0xE038E020	Right ALT key --> Mute key (0xE038 --> 0xE020).

@begin=sh@
# escape to caps lock http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_Windows
cat >/tmp/capslock2escape.reg <<EOF
REGEDIT4

[HKEY_CURRENT_USER\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,00,00,00,00,03,00,00,00,3a,00,46,00,01,00,3a,00,00,00,00,00
EOF
cygstart /tmp/capslock2escape.reg
@end=sh@


HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
32-bit DWORD: NoWinKeys set to 1

# shortcul to network adapter settings
rundll32.exe shell32.dll,Control_RunDLL ncpa.cpl


cd "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
cd %APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup
~/stdhome/bin/cron-from-win32.bat # dont forget to go to stdhome dir as windows wont interpret symlink




How to remove 'Administrator:' from the command prompt title
	# HINT: before editing, move those files in another directory using explorer.exe to not have surprise with bullshit System32 SYSWow64 problems
    You’ll need to modify the MUI data file for cmd.exe. This file is called cmd.exe.mui, and is located in C:\Windows\System32\en-US on a standard 32-bit, United States installation. For other languages, the en-US will be different, and for 64-bit installations, you’ll need to modify both the version in System32 and in SysWOW64.

        First off, take ownership of cmd.exe.mui. Right-click on the file, click Advanced on the security tab. On the Owner tab, click Edit, and select the Administrators account.

        Now, give access to modify the file. Go back into the properties for the file, click Edit on the Security tab, click Add, and enter Administrators, then make sure they have the Full Control option set to Allow.

        Using a hex editor, resource editor, or other editor of your choice, modify the string in the file from “Administrator: %0” to “ %0” (That’s two spaces before the %0, don’t forget the null character at the end).

        Save the file

        Run mcbuilder.exe (this could take some time to run)

        Reboot the computer.



# https://support.microsoft.com/en-us/help/831426/chkdsk.exe-or-autochk.exe-starts-when-you-try-to-shut-down-or-restart-your-computer
Locate and then click the following key in the registry:
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\BootExecute
On the Edit menu, click Modify.
Type autocheck autochk *, and then press ENTER.

# change user disconnect utility
C:\Windows\System32\tsdiscon.exe

https://msdn.microsoft.com/en-us/library/dd373424(VS.85).aspx # webcam AmCap, but have to download 570mb SDK
https://amw.github.io/jpeg_camera/demo/ # webcam to png webapp

# title bar focused inactive color:
Start
Accent
Choose your accent color
Transparency effects: Off
Show accent color on the following surfaces: Title bars

Windows Key + Ctrl + D – Create a new virtual desktop and switch to it
Windows Key + Ctrl + F4 – Close the current virtual desktop.
Windows Key + Ctrl + Left / Right – Switch to the virtual desktop on the left or right.
Windows Key + Left – Snap current window to the left side of the screen.
Windows Key + Right – Snap current window the the right side of the screen.
Windows Key + Up – Snap current window to the top of the screen.
Windows Key + Down – Snap current window to the bottom of the screen.

# Expose:
* Win + Tab
* Win press + Left/Right Release + Win Release 
if done by accident (which happens all the time), press Esc

# Bash windows
1)
Start
turn windows features on or off (alternative: uninstall, which opens an intermediate window)
Windows Subsystem for Linux (Beta)
Reboot
Or
Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
2)
Start
For developers Settings
set to developer mode
3)
Start
cmd
bash
4a) 
https://www.fosshub.com/ConEmu.html
https://www.fosshub.com/ConEmu.html/ConEmuPack.161206.7z
4b)  mintty steps # https://github.com/mintty/mintty/wiki/Tips#using-mintty-for-bash-on-ubuntu-on-windows-uow--windows-subsystem-for-linux-wsl
https://github.com/rprichard/wslbridge/releases
download
tar xzf *cygwin64.tar.gz
cdl
mv wslbridge* /bin
mintty.exe /bin/wslbridge.exe -t /bin/bash -l

http://babun.github.io/

# curl
bitsadmin /addfile thisissomejobname http://kakao.ro/Pictures.iso C:\john_pictures.iso
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Invoke-WebRequest -Uri "https://blabla.com/pictures.iso" -OutFile "c:\lol.iso"
