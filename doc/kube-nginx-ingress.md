# helm
grep version ~/git/github/helm/charts/stable/nginx-ingress/Chart.yaml    # chart version
grep appVersion ~/git/github/helm/charts/stable/nginx-ingress/Chart.yaml # nginx version
https://github.com/helm/charts/blob/master/stable/nginx-ingress/Chart.yaml
curl -s https://raw.githubusercontent.com/helm/charts/master/stable/nginx-ingress/Chart.yaml | grep -i version
helm search repo -l nginx-ingress

https://github.com/kubernetes/ingress-nginx
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#enable-cors

keti -n ingress-nginx nginx-ingress-controller-7fb5cfd89-hvqkm cat /etc/nginx/nginx.conf V

kgp -Al k8s-app=fluentd-logging # labels
kgp -Al app=kured               # labels
