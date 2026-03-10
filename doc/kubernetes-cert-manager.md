* https://cert-manager.io/docs/
* https://cert-manager.io/docs/release-notes/
* https://github.com/cert-manager/cert-manager
* https://github.com/cert-manager/cert-manager/releases
* https://github.com/cert-manager/cert-manager/blob/master/deploy/charts/cert-manager/values.yaml
* https://raw.githubusercontent.com/cert-manager/cert-manager/refs/heads/master/deploy/charts/cert-manager/values.yaml

cmctl renew -n graylog gl.e.boop.com
kubectl cert-manager renew letsencrypt-prod.blabla.bip.bop.com # certificate.cert-manager.io/
kubectl cert-manager renew -n prometheus           --all
kubectl cert-manager renew -n prometheus           --all --all-namespaces

kgp -Al app.kubernetes.io/instance=cert-manager
kgp -Al app.kubernetes.io/name=cert-manager
kgp -Al app.kubernetes.io/name=cainjector
kgp -Al app.kubernetes.io/name=webhook,app.kubernetes.io/instance=cert-manager
kgp -Al app=cert-manager

klf -n cert-manager deployment/cert-manager
klf -n cert-manager deployment/cert-manager-cainjector
klf -n cert-manager deployment/cert-manager-webhook

# cmctl
https://cert-manager.io/docs/reference/cmctl/
https://github.com/cert-manager/cmctl
cmctl is a CLI tool manage and configure cert-manager resources for Kubernetes

Usage: cmctl [command]

Available Commands:
  approve      Approve a CertificateRequest
  check        Check cert-manager components
  completion   Generate completion scripts for the cert-manager CLI
  convert      Convert cert-manager config files between different API versions
  create       Create cert-manager resources
  deny         Deny a CertificateRequest
  experimental Interact with experimental features
  help         Help about any command
  inspect      Get details on certificate related resources
  renew        Mark a Certificate for manual renewal
  status       Get details on current status of cert-manager resources
  upgrade      Tools that assist in upgrading cert-manager
  version      Print the cert-manager CLI version and the deployed cert-manager version

Flags:
  -h, --help                           help for cmctl
      --log-flush-frequency duration   Maximum number of seconds between log flushes (default 5s)
      --logging-format string          Sets the log format. Permitted formats: "json" (gated by LoggingBetaOptions), "text". (default "text")
  -v, --v Level                        number for the log level verbosity
      --vmodule pattern=N,...          comma-separated list of pattern=N settings for file-filtered logging (only works for text log format)

```sh
kubectl get certificate
cmctl check api
eval $(cmctl completion zsh)
eval $(cmctl completion bash)

kubectl get orders.acme.cert-manager.io -A
kubectl get certificates.cert-manager.io -A
kubectl get certificaterequests.cert-manager.io -A
kubectl get certificatesigningrequests.certificates.k8s.io -A
kubectl cert-manager status certificate -n namespace certificates.cert-manager.io


https://cert-manager.io/docs/releases/release-notes/release-notes-1.18/
https://github.com/kubernetes/ingress-nginx/issues/11176
