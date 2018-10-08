
https://docs.helm.sh/using_helm/

helm create MYPACKAGE
helm search MYPACKAGE
helm delete MYRELEASE
helm repo list
helm repo update
helm inspect
helm ls
helm package MYPACKAGE # creates the .tgz as well as copy the .tgz to ~/.heml/repository/local/
helm upgrade --set replicaCount=2 ....
helm upgrade -f bip.yaml releasename packagename
helm get values releasename
helm rollback myrelease myversion
helm package --sign

helm fetch && helm template ... | kubectl apply -f - # tiller less deployment


mv bip.tgz ./repo/
helm repo index ./repo/


# security tiller
remove clusterIP
ensure TLS
https://engineering.bitnami.com/articles/helm-security.html

