* https://cert-manager.io/docs/
* https://cert-manager.io/docs/release-notes/
* https://github.com/cert-manager/cert-manager
* https://github.com/cert-manager/cert-manager/releases

kubectl cert-manager renew letsencrypt-prod.blabla.bip.bop.com # certificate.cert-manager.io/
kubectl cert-manager renew -n prometheus           --all
kubectl cert-manager renew -n prometheus           --all --all-namespaces
