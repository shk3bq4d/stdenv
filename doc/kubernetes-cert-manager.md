* https://cert-manager.io/docs/
* https://cert-manager.io/docs/release-notes/
* https://github.com/cert-manager/cert-manager
* https://github.com/cert-manager/cert-manager/releases

kubectl cert-manager renew letsencrypt-prod.blabla.bip.bop.com # certificate.cert-manager.io/
kubectl cert-manager renew -n prometheus           --all
kubectl cert-manager renew -n prometheus           --all --all-namespaces

kgp -Al app.kubernetes.io/instance=cert-manager
kgp -Al app.kubernetes.io/name=cert-manager
kgp -Al app.kubernetes.io/name=cainjector
kgp -Al app.kubernetes.io/name=webhook,app.kubernetes.io/instance=cert-manager
kgp -Al app=cert-manager

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
