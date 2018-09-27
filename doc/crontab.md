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

# one day in a lifetime
* * * * * test $(date +'\%Y.\%m.\%d') = 2018.04.18 && touch /tmp/ab

30 08 * * * env | sort > ~/.tmp/cronenv
30 08 * * * ~/bin/mrlsyncd.sh

0 0 * * * sleep ${RANDOM:0:3}; systemctl restart goferd

# good ideads
@daily updatedb
@reboot rm -f ~/.ssh/environment

@hourly find ~/.tmp/vim/{output,undodir} -type f -name '*tmp' \( -mtime +25 -or \( -mtime +10 -and -size +100k \) -or \( -mtime +2 -and -size +10M \) \) -print -delete | logger -t cronvimdelete -p user.info
@hourly git=gitprivate; f=~/.tmp/crontab/$(hostname -f); mkdir -p ~/.tmp/crontab; crontab -l > $f; $git add $f; $git commit -m . $f
@daily            minikube completion zsh > ~/.zsh-aliases/minikube
@daily            helm completion zsh > ~/.zsh-aliases/helm
@daily            kubectl completion zsh > ~/.oh-my-zsh/cache/kubectl_completion

# power saving at work during the night
29 07 * * mon-thu DISPLAY=:0 xset -dpms && DISPLAY=:0 xset s off
00 20 * * mon-thu DISPLAY=:0 xset +dpms && DISPLAY=:0 xset s on
* 07 * * * test $(date +'\%Y.\%m.\%d') = 2018.04.18 && touch /tmp/ab && DISPLAY=:0 xset -dpms && DISPLAY=:0 xset s off && touch /tmp/abc

# short-circuit stdhome-pull while jexternalssh not available
0	*	31,1-7 3,4 *	test $(date +\%Y) = 2018 && touch ~/.tmp/touch/stdhome-pull


# think of the children!
46  *   *      *   *    grep -E $'\x70\x6f\x72\x6e' ~/.bash_history ~/.zsh_history && sed -r -i -e  '/\x70\x6f\x72\x6e/ d' ~/.bash_history ~/.zsh_history

# container_ip updated in mrlighttpd
*/3	*	*		*	*	~/bin/container-ip.sh


# file cleanup
5 5 * * * sleep ${RANDOM:0:2} && find ~/Downloads/ -maxdepth 1 -type f -mtime +2 -name 'zbx_export_templates*.xml' -delete

