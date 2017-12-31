#!/usr/bin/env bash

VI=vi
which vim 2>/dev/null && VI=vim
sudo=

# https://en.wikipedia.org/wiki/Hosts_(file)
case $(uname) in \
	*linux*|*Linux*)           
		f=/etc/hosts
		sudo="sudo "
		;;
	*cygwin*|*CYGWIN*)
		f=$SYSTEMROOT/System32/drivers/etc/hosts
		if net session &> /dev/null; then
			#echo 'Admin!'
			true
		else
			echo 'Your are not an admin, start a local terminal with elevated priviledges. Press ENTER key to open the file read-only'
			read a
		fi
		;;
	*)
		echo "FATAL unimplemented for $(uname)"
		exit 1
		;;
esac


$sudo $VI $f


exit 0

Operating System	Version(s)	Location
Unix, Unix-like, POSIX		/etc/hosts[3]
Microsoft Windows	3.1	%WinDir%\HOSTS
95, 98, ME	%WinDir%\hosts[4]
NT, 2000, XP,[5] 2003, Vista,
2008, 7, 2012, 8, 10	%SystemRoot%\System32\drivers\etc\hosts [6]
Windows Mobile, Windows Phone		Registry key under HKEY_LOCAL_MACHINE\Comm\Tcpip\Hosts
Apple Macintosh	9 and earlier	Preferences or System folder
Mac OS X 10.0–10.1.5[7]	(Added through NetInfo or niload)
Mac OS X 10.2 and newer	/etc/hosts (a symbolic link to /private/etc/hosts)[7]
Novell NetWare		SYS:etc\hosts
OS/2 & eComStation		"bootdrive":\mptn\etc\
Symbian	Symbian OS 6.1–9.0	C:\system\data\hosts
Symbian OS 9.1+	C:\private\10000882\hosts
MorphOS	NetStack	ENVARC:sys/net/hosts
AmigaOS	4	DEVS:Internet/hosts
AROS		ENVARC:AROSTCP/db/hosts
Android		/etc/hosts (a symbolic link to /system/etc/hosts)
iOS	iOS 2.0 and newer	/etc/hosts (a symbolic link to /private/etc/hosts)
TOPS-20		<SYSTEM>HOSTS.TXT
Plan 9		/lib/ndb/hosts
BeOS		/boot/beos/etc/hosts[8]
Haiku		/boot/common/settings/network/hosts[8]
OpenVMS	UCX	UCX$HOST
TCPware	TCPIP$HOST
RISC OS	3.7, 5	!Boot.Resources.!Internet.files.Hosts
later boot sequence	!Boot.Choices.Hardware.Disabled.Internet.Files.Hosts
