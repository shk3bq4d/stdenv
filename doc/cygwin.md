<code>
ftp://mirror.switch.ch
package list:
nc			# netcat
nc6			# netcat with ipv6 support
coreutils
binutils
cron
curl
libiconv
wget
gawk
grep
gvim
openssh
mintty
rsync
sed
git
util-linux
ascii
iconv
iconv2
git
svn
gettext


NOP python  # prefer main python distribution from python.org site
# along with the following binaries from
http://www.lfd.uci.edu/~gohlke/pythonlibs
# pip, lxml, distribution
# then through pip:
# pip install unidecode

</code>


#lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
# https://github.com/transcode-open/apt-cyg
lynx -source https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
install apt-cyg /bin
curl https://beyondgrep.com/ack-2.18-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
~/bin/cron-from-win32.bat
explorer ~/stdhome/bin/cron-from-win32.bat

# https://superuser.com/questions/580968/how-to-use-cygwin-to-copy-an-image-from-an-sd-memory-card
id | grep -qi admin && echo "good! you are an admin" || echo "not admin, run mintty as admin"
cat /proc/partitions # to find out your USB thing



C:\Windows\system32>@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

apt-cyg mirror http://mirrors.kernel.org/sources.redhat.com/cygwin/
apt-cyg update
apt-cyg install php
	
http://babun.github.io/
