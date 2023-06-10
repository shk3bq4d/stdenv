https://github.com/kubereboot/kured
https://github.com/kubereboot/charts
https://github.com/kubereboot/kured/releases
https://github.com/weaveworks/kured # legacy repo, currently forwarding to kubereboot

# reboot
```sh
echo b | keti -n kured kured-6brpw tee /proc/sysrq-trigger # rough  force reboot
```
