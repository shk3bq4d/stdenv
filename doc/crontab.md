PATH=/home/myuser/bin:/usr/local/bin:/usr/bin:/cygdrive/c/ProgramData/Oracle/Java/javapath:/cygdrive/c/Windows/system32:/cygdrive/c/Windows:/cygdrive/c/Windows/System32/Wbem:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0:/usr/lib/lapack
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/home/myuser/bin                                                                                                                                                                    
SHELL=/bin/bash
SHELL=/usr/local/bin/bash
PYTHONPATH=/home/myuser/py
LANG=en_US.utf8
LC_TIME=en_DK.utf
HOSTNAME=bip
HOSTNAMEF=bip.ly.lan

MAILTO="a@b.com,b@b.com"
When your cron jobs have output, or, more importantly, when they fail, cron will send the output e-mail these addresses.

PATH="/usr/bin:/sbin:/bin"
Logged in to the user account whose crontab you're setting up, go ahead and echo $PATH and copy those contents into the PATH variable of your crontab. Remember, this isn't a real script file, so you can't implicitly append :$PATH.  After assigning PATH and MAILTO, setting up your crontab is much easier. 

HOME="/path/to/app/root" The HOME variable tells which directory cron should execute the crontab commands from. Often times you'll have a user/crontab per project. If so, set the HOME variable to your project's root directory to avoid long, absolute paths to scripts or from having to 'cd /path/to/app/root && ...' for each job. 

SHELL="/bin/bash



# m h   dom mon dow command
0   */2 *   *   *   mri3lock-shuffle-images.sh
@reboot touch /tmp/cron.reboot

@daily touch /tmp/cron.daily
@weekly touch /tmp/cron.weekly
@hourly touch /tmp/cron.hourly
* * * * * touch /tmp/cron.touch


# escapes
date +'\%Y\%m\%d'

30 08 * * * env | sort > ~/.tmp/cronenv
30 08 * * * ~/bin/mrlsyncd.sh

0 0 * * * sleep ${RANDOM:0:3}; systemctl restart goferd

# good ideads
@daily updatedb
@reboot rm -f ~/.ssh/environment

@hourly find ~/.tmp/vim/{output,undodir} -type f -name '*tmp' \( -mtime +25 -or \( -mtime +10 -and -size +100k \) -or \( -mtime +2 -and -size +10M \) \) -print -delete | logger -t cronvimdelete -p user.info
@hourly git=gitprivate; f=~/.tmp/crontab/$(hostname -f); mkdir -p ~/.tmp/crontab; crontab -l > $f; $git add $f; $git commit -m . $f

0	*	31,1-7 3,4 *	test $(date +\%Y) = 2018 && touch ~/.tmp/touch/stdhome-pull # short-circuit stdhome-pull while jexternalssh not available
