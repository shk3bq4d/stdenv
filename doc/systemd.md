systemctl enable nginx.service   # Start nginx as system boot
journalctl --no-tail -f -u nginx.service
journalctl --since "2017-10-07 10:00:00"
journalctl --since "2017-10-07 10:00:00"  -u kafka.service

https://linuxconfig.org/how-to-automatically-execute-shell-script-at-startup-boot-on-systemd-linux
 vi /etc/systemd/system/SERVICENAME.service
  [Unit]
  After=network.target
  [Service]
  ExecStart=/usr/local/bin/disk-space-check.sh
  [Install]
  WantedBy=default.target
 systemctl daemon-reload
 systemctl enable SERVICENAME.service

/usr/lib/systemd/system/zookeeper.service


Sysvinit Command	          Systemd Command	                                              Notes
service frobozz start	      systemctl start frobozz	                                      Used to start a service (not reboot persistent)
service frobozz stop	      systemctl stop frobozz	                                      Used to stop a service (not reboot persistent)
service frobozz restart	      systemctl restart frobozz	                                      Used to stop and then start a service
service frobozz reload	      systemctl reload frobozz	                                      When supported, reloads the config file without interrupting pending operations.
service frobozz condrestart	  systemctl condrestart frobozz	                                  Restarts if the service is already running.
service frobozz status	      systemctl status frobozz	                                      Tells whether a service is currently running.
ls /etc/rc.d/init.d/	      systemctl (or) systemctl list-unit-files --type=service (or)    Used to list the services that can be started or stopped 
                              ls /lib/systemd/system/*.service /etc/systemd/system/*.service  Used to list all the services and other units
chkconfig frobozz on	      systemctl enable frobozz	                                      Turn the service on, for start at next boot, or other trigger.
chkconfig frobozz off	      systemctl disable frobozz	                                      Turn the service off for the next reboot, or any other trigger.
chkconfig frobozz	          systemctl is-enabled frobozz	                                  Used to check whether a service is configured to start or not in the current environment.
chkconfig --list	          systemctl list-unit-files --type=service (or)                   Print a table of services that lists which runlevels each is configured on or off
                              ls /etc/systemd/system/*.wants/	
chkconfig frobozz --list	  ls /etc/systemd/system/*.wants/frobozz.service	              Used to list what levels this service is configured on or off
chkconfig frobozz --add	u     systemctl daemon-reload	                                      Used when you create a new service file or modify any configuration



UNIT FILE                                     STATE   
arp-ethers.service                            disabled
atd.service                                   enabled 
auditd.service                                enabled 
autovt@.service                               enabled 
blk-availability.service                      disabled
brandbot.service                              static  
chrony-dnssrv@.service                        static  
chrony-wait.service                           disabled
chronyd.service                               enabled 
console-getty.service                         disabled
console-shell.service                         disabled
container-getty@.service                      static  
cpupower.service                              disabled
crond.service                                 enabled 
dbus-org.fedoraproject.FirewallD1.service     enabled 
dbus-org.freedesktop.hostname1.service        static  
dbus-org.freedesktop.import1.service          static  
dbus-org.freedesktop.locale1.service          static  
dbus-org.freedesktop.login1.service           static  
dbus-org.freedesktop.machine1.service         static  
dbus-org.freedesktop.network1.service         bad     
dbus-org.freedesktop.timedate1.service        static  
dbus.service                                  static  
debug-shell.service                           disabled
dm-event.service                              disabled
dnsmasq.service                               disabled
dracut-cmdline.service                        static  
dracut-initqueue.service                      static  
dracut-mount.service                          static  
dracut-pre-mount.service                      static  
dracut-pre-pivot.service                      static  
dracut-pre-trigger.service                    static  
dracut-pre-udev.service                       static  
dracut-shutdown.service                       static  
ebtables.service                              disabled
emergency.service                             static  
fail2ban.service                              enabled 
firewalld.service                             enabled 
fstrim.service                                static  
getty@.service                                enabled 
goferd.service                                enabled 
halt-local.service                            static  
htcacheclean.service                          static  
httpd.service                                 disabled
initrd-cleanup.service                        static  
initrd-parse-etc.service                      static  
initrd-switch-root.service                    static  
initrd-udevadm-cleanup-db.service             static  
iprdump.service                               disabled
iprinit.service                               disabled
iprupdate.service                             disabled
irqbalance.service                            enabled 
kdump.service                                 enabled 
kmod-static-nodes.service                     static  
lvm2-lvmetad.service                          disabled
lvm2-lvmpolld.service                         disabled
lvm2-monitor.service                          enabled 
lvm2-pvscan@.service                          static  
mariadb.service                               disabled
messagebus.service                            static  
microcode.service                             enabled 
NetworkManager-dispatcher.service             disabled
NetworkManager-wait-online.service            disabled
NetworkManager.service                        disabled
ntpd.service                                  disabled
ntpdate.service                               disabled
plymouth-halt.service                         disabled
plymouth-kexec.service                        disabled
plymouth-poweroff.service                     disabled
plymouth-quit-wait.service                    disabled
plymouth-quit.service                         disabled
plymouth-read-write.service                   disabled
plymouth-reboot.service                       disabled
plymouth-start.service                        disabled
plymouth-switch-root.service                  static  
polkit.service                                static  
postfix.service                               enabled 
puppet.service                                disabled
puppetagent.service                           disabled
quotaon.service                               static  
rc-local.service                              static  
rdisc.service                                 disabled
rdma.service                                  disabled
rescue.service                                static  
rhel-autorelabel-mark.service                 static  
rhel-autorelabel.service                      static  
rhel-configure.service                        static  
rhel-dmesg.service                            disabled
rhel-domainname.service                       disabled
rhel-import-state.service                     static  
rhel-loadmodules.service                      static  
rhel-readonly.service                         static  
rhsmcertd.service                             enabled 
rsyncd.service                                disabled
rsyncd@.service                               static  
rsyslog.service                               enabled 
selinux-policy-migrate-local-changes@.service static  
serial-getty@.service                         disabled
shorewall.service                             disabled
snmpd.service                                 enabled 
snmptrapd.service                             disabled
sshd-keygen.service                           static  
sshd.service                                  enabled 
sshd@.service                                 static  
sysstat.service                               enabled 
systemd-ask-password-console.service          static  
systemd-ask-password-plymouth.service         static  
systemd-ask-password-wall.service             static  
systemd-backlight@.service                    static  
systemd-binfmt.service                        static  
systemd-bootchart.service                     disabled
systemd-firstboot.service                     static  
systemd-fsck-root.service                     static  
systemd-fsck@.service                         static  
systemd-halt.service                          static  
systemd-hibernate-resume@.service             static  
systemd-hibernate.service                     static  
systemd-hostnamed.service                     static  
systemd-hwdb-update.service                   static  
systemd-hybrid-sleep.service                  static  
systemd-importd.service                       static  
systemd-initctl.service                       static  
systemd-journal-catalog-update.service        static  
systemd-journal-flush.service                 static  
systemd-journald.service                      static  
systemd-kexec.service                         static  
systemd-localed.service                       static  
systemd-logind.service                        static  
systemd-machine-id-commit.service             static  
systemd-machined.service                      static  
systemd-modules-load.service                  static  
systemd-nspawn@.service                       disabled
systemd-poweroff.service                      static  
systemd-quotacheck.service                    static  
systemd-random-seed.service                   static  
systemd-readahead-collect.service             enabled 
systemd-readahead-done.service                indirect
systemd-readahead-drop.service                enabled 
systemd-readahead-replay.service              enabled 
systemd-reboot.service                        static  
systemd-remount-fs.service                    static  
systemd-rfkill@.service                       static  
systemd-shutdownd.service                     static  
systemd-suspend.service                       static  
systemd-sysctl.service                        static  
systemd-timedated.service                     static  
systemd-tmpfiles-clean.service                static  
systemd-tmpfiles-setup-dev.service            static  
systemd-tmpfiles-setup.service                static  
systemd-udev-settle.service                   static  
systemd-udev-trigger.service                  static  
systemd-udevd.service                         static  
systemd-update-done.service                   static  
systemd-update-utmp-runlevel.service          static  
systemd-update-utmp.service                   static  
systemd-user-sessions.service                 static  
systemd-vconsole-setup.service                static  
tcsd.service                                  disabled
teamd@.service                                static  
tuned.service                                 enabled 
vmtoolsd.service                              enabled 
wpa_supplicant.service                        disabled
yum-cron.service                              enabled 
zabbix-agent.service                          enabled 

164 unit files listed.
