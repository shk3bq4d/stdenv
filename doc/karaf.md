features:list
features:list | grep MrScanEmail
features:uninstall MrScanEmail-feature
features:listrepositories
features:removerepository MrScanEmail-feature
bundles:list
bundles:stop
features:uninstall MrSendMail-feature/0.4
ssh -p 8101 karaf@ly200

ssh_jail.sh jtos-esb-5-3-1
ssh -p 8101 -o KexAlgorithms=diffie-hellman-group1-sha1 karaf@localhost

ssh config: ~/TOS_ESB-r104014-V5.3.1/Runtime_ESBSE/container/data_mr/cache/org.eclipse.osgi/bundles/5/data/config/org/apache/karaf/shell.config
password file /home/mruser/TOS_ESB-r104014-V5.3.1/Runtime_ESBSE/container/etc/users.properties

tail -f ~/TOS_ESB-r104014-V5.3.1/Runtime_ESBSE/container/log/tesb.log
vi ~/TOS_ESB-r104014-V5.3.1/Runtime_ESBSE/container/data/karaf.out

cd ~/TOS_ESB-r104014-V5.3.1/Runtime_ESBSE/container/bin && ./client
bundles:list | grep MrSendMail
bundles:uninstall 244 245

~/docker/tos-esb-5.3.1/run.sh
