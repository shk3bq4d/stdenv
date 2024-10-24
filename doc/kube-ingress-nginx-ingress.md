# helm
curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/charts/ingress-nginx/Chart.yaml | grep -i version
helm search repo -l nginx-ingress

* https://github.com/kubernetes/ingress-nginx
* https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml
* https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx
* https://github.com/kubernetes/ingress-nginx/releases
* https://github.com/kubernetes/ingress-nginx/tree/main/changelog
* https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#enable-cors

keti -n ingress-nginx nginx-ingress-controller-7fb5cfd89-hvqkm 
keti -n $(kgp -Al app.kubernetes.io/name=ingress-nginx -o custom-columns=ns:.metadata.namespace,name:.metadata.name --no-headers | head -n 1) -- cat /etc/nginx/nginx.conf | dos2unix | sed -r -e 's/\t/    /g' -e 's/ +$//' | vi -
keti -n $(kgp -Al app.kubernetes.io/name=ingress-nginx -o custom-columns=ns:.metadata.namespace,name:.metadata.name --no-headers | head -n 1) -- nginx -v # nginx version

kgp -Al app.kubernetes.io/name=ingress-nginx # labels

# tcp service
https://medium.com/@ahmedwaleedmalik/exposing-tcp-and-udp-services-in-kubernetes-using-nginx-ingress-9b8fd639c576
https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/

kubectl get ingress.extensions
kubectl get ingresses.networking.k8s.io
kubectl get orders.acme.cert-manager.io
kubectl get certificates.cert-manager.io
kubectl get certificaterequests.cert-manager.io
kubectl get certificatesigningrequests.certificates.k8s.io

#staging
https://acme-staging-v02.api.letsencrypt.org/directory
#prod
https://acme-v02.api.letsencrypt.org/directory



nginx.ingress.kubernetes.io/configuration-snippet: 'more_clear_headers "Server";' # https://stackoverflow.com/questions/64075170/how-to-remove-the-server-header-from-kubernetes-deployed-applications
