https://github.com/helm/helm/releases/


helm create MYPACKAGE
helm search MYPACKAGE
helm delete MYRELEASE
helm repo list
helm repo update
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm inspect
helm ls -A
helm history  -n sfw-production sfw-web-app
helm history  -n sfw-production sfw-server
helm rollback -n sfw-production sfw-server 39
helm package MYPACKAGE # creates the .tgz as well as copy the .tgz to ~/.heml/repository/local/
helm upgrade --set replicaCount=2 ....
helm upgrade -f bip.yaml releasename packagename
helm get values    releasename
helm get values -a releasename
helm rollback myrelease myversion
helm package --sign
helm search repo -l nginx-ingress

helm fetch && helm template ... | kubectl apply -f - # tiller less deployment


mv bip.tgz ./repo/
helm repo index ./repo/


# security tiller
remove clusterIP
ensure TLS
https://engineering.bitnami.com/articles/helm-security.html

- helm search:    search for charts
- helm fetch:     download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts
Environment:
  $HELM_HOME          set an alternative location for Helm files. By default, these are stored in ~/.helm
  $HELM_HOST          set an alternative Tiller host. The format is host:port
  $HELM_NO_PLUGINS    disable plugins. Set HELM_NO_PLUGINS=1 to disable plugins.
  $TILLER_NAMESPACE   set an alternative Tiller namespace (default "kube-system")
  $KUBECONFIG         set an alternative Kubernetes configuration file (default "~/.kube/config")
Usage:
  helm [command]
Available Commands:
  completion  Generate autocompletions script for the specified shell (bash or zsh)
  create      create a new chart with the given name
  delete      given a release name, delete the release from Kubernetes
  dependency  manage a chart's dependencies
  fetch       download a chart from a repository and (optionally) unpack it in local directory
  get         download a named release
  history     fetch release history
  home        displays the location of HELM_HOME
  init        initialize Helm on both client and server
  inspect     inspect a chart
  install     install a chart archive
  lint        examines a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      add, list, or remove Helm plugins
  repo        add, list, remove, update, and index chart repositories
  reset       uninstalls Tiller from a cluster
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  serve       start a local http web server
  status      displays the status of the named release
  template    locally render templates
  test        test a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client/server version information
Flags:
      --debug                           enable verbose output
  -h, --help                            help for helm
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "$HOME/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")



This command installs a chart archive.
The install argument must be a chart reference, a path to a packaged chart,
a path to an unpacked chart directory or a URL.
To override values in a chart, use either the '--values' flag and pass in a file
or use the '--set' flag and pass configuration from the command line.  To force string
values in '--set', use '--set-string' instead. In case a value is large and therefore
you want not to use neither '--values' nor '--set', use '--set-file' to read the
single large value from file.
	$ helm install -f myvalues.yaml ./redis
or
	$ helm install --set name=prod ./redis
or
	$ helm install --set-string long_int=1234567890 ./redis
or
    $ helm install --set-file multiline_text=path/to/textfile
You can specify the '--values'/'-f' flag multiple times. The priority will be given to the
last (right-most) file specified. For example, if both myvalues.yaml and override.yaml
contained a key called 'Test', the value set in override.yaml would take precedence:
	$ helm install -f myvalues.yaml -f override.yaml ./redis
You can specify the '--set' flag multiple times. The priority will be given to the
last (right-most) set specified. For example, if both 'bar' and 'newbar' values are
set for a key called 'foo', the 'newbar' value would take precedence:
	$ helm install --set foo=bar --set foo=newbar ./redis
To check the generated manifests of a release without installing the chart,
the '--debug' and '--dry-run' flags can be combined. This will still require a
round-trip to the Tiller server.
If --verify is set, the chart MUST have a provenance file, and the provenance
file MUST pass all verification steps.
There are five different ways you can express the chart you want to install:
1. By chart reference: helm install stable/mariadb
2. By path to a packaged chart: helm install ./nginx-1.2.3.tgz
3. By path to an unpacked chart directory: helm install ./nginx
4. By absolute URL: helm install https://example.com/charts/nginx-1.2.3.tgz
5. By chart reference and repo url: helm install --repo https://example.com/charts/ nginx
CHART REFERENCES
A chart reference is a convenient way of reference a chart in a chart repository.
When you use a chart reference with a repo prefix ('stable/mariadb'), Helm will look in the local
configuration for a chart repository named 'stable', and will then look for a
chart in that repository whose name is 'mariadb'. It will install the latest
version of that chart unless you also supply a version number with the
'--version' flag.
To see the list of chart repositories, use 'helm repo list'. To search for
charts in a repository, use 'helm search'.
Usage:
  helm install [CHART] [flags]
Flags:
      --ca-file string           verify certificates of HTTPS-enabled servers using this CA bundle
      --cert-file string         identify HTTPS client using this SSL certificate file
      --dep-up                   run helm dependency update before installing the chart
      --description string       specify a description for the release
      --devel                    use development versions, too. Equivalent to version '>0.0.0-0'. If --version is set, this is ignored.
      --dry-run                  simulate an install
      --key-file string          identify HTTPS client using this SSL key file
      --keyring string           location of public keys used for verification (default "$HOME/.gnupg/pubring.gpg")
  -n, --name string              release name. If unspecified, it will autogenerate one for you
      --name-template string     specify template used to name the release
      --namespace string         namespace to install the release into. Defaults to the current kube config namespace.
      --no-crd-hook              prevent CRD hooks from running, but run other hooks
      --no-hooks                 prevent hooks from running during install
      --password string          chart repository password where to locate the requested chart
      --replace                  re-use the given name, even if that name is already used. This is unsafe in production
      --repo string              chart repository url where to locate the requested chart
      --set stringArray          set values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
      --set-file stringArray     set values from respective files specified via the command line (can specify multiple or separate values with commas: key1=path1,key2=path2)
      --set-string stringArray   set STRING values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
      --timeout int              time in seconds to wait for any individual Kubernetes operation (like Jobs for hooks) (default 300)
      --tls                      enable TLS for request
      --tls-ca-cert string       path to TLS CA certificate file (default "$HELM_HOME/ca.pem")
      --tls-cert string          path to TLS certificate file (default "$HELM_HOME/cert.pem")
      --tls-hostname string      the server name used to verify the hostname on the returned certificates from the server
      --tls-key string           path to TLS key file (default "$HELM_HOME/key.pem")
      --tls-verify               enable TLS for request and verify remote
      --username string          chart repository username where to locate the requested chart
  -f, --values valueFiles        specify values in a YAML file or a URL(can specify multiple) (default [])
      --verify                   verify the package before installing it
      --version string           specify the exact chart version to install. If this is not specified, the latest version is installed
      --wait                     if set, will wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment are in a ready state before marking the release as successful. It will wait for as long as --timeout
Global Flags:
      --debug                           enable verbose output
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "$HOME/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")
