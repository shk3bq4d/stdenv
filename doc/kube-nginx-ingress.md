# helm
grep version ~/git/github/helm/charts/stable/nginx-ingress/Chart.yaml    # chart version
grep appVersion ~/git/github/helm/charts/stable/nginx-ingress/Chart.yaml # nginx version
https://github.com/helm/charts/blob/master/stable/nginx-ingress/Chart.yaml
curl -s https://raw.githubusercontent.com/helm/charts/master/stable/nginx-ingress/Chart.yaml | grep -i version
helm search repo -l nginx-ingress

https://github.com/kubernetes/ingress-nginx
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#enable-cors

keti -n ingress-nginx nginx-ingress-controller-7fb5cfd89-hvqkm 
keti -n $(kgp -Al app=nginx-ingress -o custom-columns=ns:.metadata.namespace,name:.metadata.name --no-headers | head -n 1) -- cat /etc/nginx/nginx.conf | dos2unix | vi -

kgp -Al k8s-app=fluentd-logging # labels
kgp -Al app=kured               # labels
