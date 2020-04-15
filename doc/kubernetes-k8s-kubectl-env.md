/* ex: set expandtab ts=2 sw=2 : */

# acronyms
CNCF Cloud Native Computing Foundation
CRI  container runtime interface # spec'ed by CNCF
CSI  container storage interface # spec'ed by CNCF
CNI  container networking interface # spec'ed by CNCF
gRPC (gRPC Remote Procedure Calls[1]) is an open source remote procedure call (RPC) system initially developed at Google


# DNS
POD   .NAMESPACE .TYPE .cluster.local
heketi.default   .svc.cluster.local
heketi.default.svc.cluster.local
heketi.default.pod.cluster.local # dns # name
podname.namespace.podorsvc.cluster.local # dns # name

minikube     Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.
# https://kubernetes.io/docs/setup/minikube/#quickstart
minikube start --vm-driver=virtualbox
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl expose deployment hello-minikube --type=NodePort # create a service
kubectl get pod
curl $(minikube service hello-minikube --url)
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube
minikube stop # stop VM
minikube addons list
minikube addons enable ingress


# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.1/minikube-linux-amd64 && chmod +x minikube
minikube status
minikube service
minikube ssh
minikube logs -f
minikube dashboard
minikube config set disk-size 200000MB
minikube config set memory 16384
minikube config set cpus 4
minikube config view
minikube config -h
eval $(minikube docker-env)

~/.minikube/config/config.json
https://darkowlzz.github.io/post/minikube-config/

# kubectl
https://kubernetes.io/docs/reference/kubectl/cheatsheet/
curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o ~/bin/kubectl && chmod u+x ~/bin/kubectl
version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt); cd ~/bin && curl -L https://storage.googleapis.com/kubernetes-release/release/$version/bin/linux/amd64/kubectl -o kubectl-$version && chmod u+x kubectl-$version && ln -is kubectl-$version kubectl
~/.kube/config
eval $(kubectl completion zsh)
kubectl get pod
kubectl get pod --context minikube
kubectl get node
kubectl get pod --all-namespaces
kubectl get pod -o wide
kubectl get pod -o name
kubectl get namespace
kubectl get service
kubectl get deployment
kubectl get secret -o jsonpath='{.data.admin-password}' -n monitoring grafana  | base64 -d | xclip
kubectl options
kubectl exec zookeeper-d8f95899d-z5b5c -it /bin/sh
kubectl exec -n monitoring kube-prometheus-exporter-node-wchkz -i -t -- /bin/sh
kubectl proxy
kubectl create ns kafka
kubectl get pv,pvc,pod --all-namespaces
kubectl cp ~/go/src/bip/consumer kafka/mrgolang:/tmp
kubectl get pv -o json | jq '.items[].metadata.annotations."http://gluster.kubernetes.io/heketi-volume-id (gluster.kubernetes.io/heketi-volume-id)"

kubectl logs -f -n kafka --timestamps=true mrgolang

kubectl describe all --all-namespaces
kubectl describe deployment
kubectl describe deployment --all-namespaces
kubectl describe deployment -n kube-system
kubectl describe deployment -n kube-system tiller

kubectl describe pod/runner-cdb645ff-project-6405963-concurrent-1x9jfn -n ci # list containers in pod

kubectl explain ingress
kubectl explain configmap
kubectl explain pvc
kubectl explain persistentvolumeclaim
kubectl explain pods
kubectl explain pods.spec
kubectl explain pods.spec.containers
kubectl explain pods.spec.containers.workingDir


kubectl create configmap myname --from-file file.txt
kubectl create configmap myname --from-literal=key=value
kubectl create configmap myliteral --from-literal=key1=value1 --from-literal=key2=value2

while :; do kubectl get pod         -w --watch-only --all-namespaces -o wide --no-headers --context=bravo.clusters.greypay.net; done | ts
while :; do kubectl get pvc         -w --watch-only --all-namespaces -o wide --no-headers --context=bravo.clusters.greypay.net; done | ts
while :; do kubectl get namespaces  -w --watch-only                          --no-headers --context=bravo.clusters.greypay.net; done | ts

kubectl port-forward  -n kafka my-kafka-zookeeper-0 60001:2181
kubectl port-forward  -n kafka service/my-kafka 9092:9092
kubectl delete pod -n kafka my-kafka-2
kubectl delete pod --force=true --grace-period=0 -n kafka my-kafka-2
kubectl -n kafka exec -ti testclient -- ./bin/kafka-topics.sh --zookeeper my-kafka-zookeeper:2181 --create --topic biptest --partitions 10 --replication-factor 2
kubectl -n kafka exec -ti testclient -- ./bin/kafka-topics.sh --zookeeper my-kafka-zookeeper:2181 --list # where "my-kafka-zookeeper" comes from "kubectl get service -n kafka"
while :; do echo "$(date) $HOSTNAME $0 bip test"; sleep 1; done | kubectl -n kafka exec -ti testclient -- ./bin/kafka-console-producer.sh --broker-list my-kafka:9092 --request-required-acks -1 --topic biptest
kubectl -n kafka exec -ti testclient -- ./bin/kafka-console-consumer.sh --new-consumer --bootstrap-server my-kafka:9092 --from-beginning --topic biptest

kubectl run mrgolang2 -n kafka --image minikube:consumer --command tailf /dev/null # creates an deployment + pod
kubectl run nettools -n mrdbg --image ianneub/network-tools -o yaml --command -- tail -f /dev/null
kubectl run stdenv --generator=run-pod/v1 --image shk3bq4d/stdenv:stdenv -o yaml --command -- tail -f /dev/null
kubectl run mysql-client --generator=run-pod/v1 --image arey/mysql-client --command -- mysql -h
kubectl exec -it stdenv zsh

kubectl config view # Show Merged kubeconfig settings.

kubectl patch configmaps -n kube-system kube-dns --patch '{"data":{"upstreamNameservers": "[\"10.19.29.1\"]"}}' # microk8s

# use multiple kubeconfig files at the same time and view merged config
KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 kubectl config view --raw
# Get the password for the e2e user
kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'
kubectl config current-context              # Display the current-context
kubectl config use-context my-cluster-name  # set the default context to my-cluster-name
# add a new cluster to your kubeconf that supports basic auth
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword
# set a context utilizing a specific username and namespace.
kubectl config set-context gce --user=cluster-admin --namespace=foo \
  && kubectl config use-context gce

echo "
apiVersion: v1
kind: Pod
metadata:
  name: mrgolang
  namespace: kafka
spec:
  containers:
  - name: containernname
    image: consumer
    imagePullPolicy: Never
    args:
    - go
    - run
    - consumer.go
    - my-kafka
" | kubectl create -f -

@begin=yaml@
echo '
apiVersion: v1
kind: Pod
metadata:
  name: testclient
  namespace: kafka
spec:
  containers:
  - name: kafka
    image: solsson/kafka:0.11.0.0
    command:
      - sh
      - -c
      - "exec tail -f /dev/null"
' | kubectl create -f -
@end=yaml@

@begin=yaml@
Echo '
apiVersion: v1
kind: Pod
metadata:
  name: fabdeployer
  namespace: rumotest
spec:
  containers:
  - name: mrname
    image: registry.gitlab.com/greytoken/chaincode/fabric-deployer
    command:
      - sh
      - -c
      - "exec tail -f /dev/null"
' | kubectl create -f -
@end=yaml@
@begin=yaml@
echo "
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  labels:
    app: wordpress
spec:
  ports:
    - port: 80
  selector:
    app: wordpress
    tier: frontend
  type: LoadBalancer
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: wp-pv-claim
  labels:
    app: wordpress
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
---
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: wordpress
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: frontend
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: wordpress
        tier: frontend
    spec:
      containers:
      - image: wordpress:4.8-apache
        name: wordpress
        env:
        - name: WORDPRESS_DB_HOST
          value: wordpress-mysql
        - name: WORDPRESS_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        ports:
        - containerPort: 80
          name: wordpress
        volumeMounts:
        - name: wordpress-persistent-storage
          mountPath: /var/www/html
      volumes:
      - name: wordpress-persistent-storage
        persistentVolumeClaim:
          claimName: wp-pv-claim
" | kubectl create -n rumotest -f -
@end=yaml@

# julien debug my minikube ~JUL18
kubectl describe deployment -n kafka
kubectl get pvc --all-namespaces
kubectl get deployment -n kafka
kubectl describe deployment -n kafka my-kafka
kubectl describe statefulset -n kafka
kubectl describe statefulset -n kafka G -A9 init
kubectl describe pod -n kafka my-kafka-0
kubectl get pod -n kafka my-kafka-0 -o yaml
kubectl logs -n kafka my-kafka-0 init-ext
kubectl get pod -n kafka my-kafka-0 -w # watch

# julien debug EBS
kubectl taint node ip-172-18-10-9.us-east-2.compute.internal NodeWithImpairedVolumes- # remove taint (notice the dash after NodeWithImpairedVolumes-)
kubectl get node -o yaml | grep -C 10 taint

export KUBECONFIG=$(echo ~/git/g*n/infra/K8s/kubectl_config) #* markdown sucks adding star in comment
heptio-authenticator-aws token -i dev.clusters.greypay.net -r arn:aws:iam::855885086634:role/KubernetesAdmin |jq -r .status.token
# heptio-authenticator-aws cache idea # https://github.com/kubernetes-sigs/aws-iam-authenticator/issues/99

# ci-cd
docker run -it registry.gitlab.com/greytoken/chaincode/fabric-deployer:build-fabric-deployer.latest /bin/bash
docker run -it registry.gitlab.com/greytoken/chaincode/fabric-deployer:build-fabric-deployer.latest /gopath/bin/kubectl

# tiller
helm init # installs  tiller on kubernetes cluster

# helm
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install --name my-kafka --namespace kafka incubator/kafka  --set external.enabled=true
helm install --name my-kafka --namespace kafka incubator/kafka  --set external.enabled=true --set rbac.enabled=true --wait --timeout 1800
helm upgrade my-kafka incubator/kafka --set external.enabled=true
helm del --purge my-kafka
helm ls --all my-kafka
helm get  my-kafka # retrieves used parameters / values

helm list --kube-context bravo.clusters.greypay.net
helm list --kube-context minikube
helm repo list
helm install --kube-context minikube incubator/prometheus --name prometheus --namespace monitoring -f prometheus-jst/values.yaml

# proxy
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy


# jargon
PV   PersistentVolume
PVC  PersistentVolumeClaim
CRD  customer ressource definition


--all-namespaces to get all
/var/log/messages


# PVC yaml
@begin=yaml@
---
apiVersion: v1
kind: Service
metadata:
 name: dumb-headless
spec:
 clusterIP: None
 ports:
 - name: requests
   port: 7051
   protocol: TCP
 - name: events
   port: 7053
   protocol: TCP
 selector:
   app: dumb
 type: ClusterIP
---
apiVersion: apps/v1beta1
kind: StatefulSet
metadata:
 name: dumb
spec:
 replicas: 1
 serviceName: dumb-headless
 selector:
   matchLabels:
     app: dumb
 template:
   metadata:
     labels:
       app: dumb
   spec:
     containers:
     - name: dumb-container
       image: busybox
       command:
       - tail
       - -f
       - "/dev/null"
#        ports:
#        - containerPort: 7051
#        - containerPort: 7053
#        workingDir: /opt/gopath/src/github.com/hyperledger/fabric
#        env:
#        - name: GODEBUG
#          value: netdns=go+1
#        - name: CORE_LOGGING_LEVEL
#          value: debug
#        - name: CORE_PEER_NAME
#          valueFrom:
#            fieldRef:
#              fieldPath: metadata.name
#        - name: CORE_PEER_ID
#          value: $(CORE_PEER_NAME).{{ .Values.fabricPeer.org.domain }} # matching certificate from cryptogen
#        - name: CORE_PEER_ADDRESS
#          value: $(CORE_PEER_NAME).fabric-peer-headless.{{ .Release.Namespace }}.svc.cluster.local:7051
#        - name: CORE_VM_ENDPOINT
#          value: tcp://localhost:2375 # exposed by DinD
#        - name: CORE_PEER_MSPCONFIGPATH
#          value: /etc/hyperledger/config/msp
#        - name: CORE_PEER_LOCALMSPID
#          value: {{ .Values.fabricPeer.org.msp }}
       volumeMounts:
       - mountPath: /dumb-volume
         name: dumb-volume
 volumeClaimTemplates:
 - metadata:
     name: dumb-volume
     labels:
       app: dumb
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
@end=yaml@

#fluentd
https://github.com/fluent/fluentd-kubernetes-daemonset/issues/46
https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch
https://github.com/fluent/fluentd-kubernetes-daemonset/blob/master/templates/conf/fluent.conf.erb
https://github.com/coreos/tectonic-docs/blob/master/Documentation/files/logging/fluentd-configmap.yaml

# training
https://github.com/sebgoa/oreilly-kubernetes/blob/master/scripts/k8s.sh
## static pods (must always run)
located in /etc/kubernetes/manifests/
##
kubectl run game --image runseb/2048
kubectl expose deployment game --port 80 --type NodePort
kubectl get services
curl http://192.168.99.100:31395

# create deployment
@begin=yaml@
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kud
spec:
  replicas: 2
  selector:
    matchLabels:
      app: kud
  template:
    metadata:
      labels:
        app: kud
    spec:
      containers:
      - name: kud
        image: nginx
@end=yaml@
kubectl create -f ~/tmp/dep.yaml
kubectl scale --replicas=3 deployment/kud
kubectl get pods -Lapp
kubectl get pods -Lapp -l app=kud
# create deployment
@begin=sh@
@begin=yaml@
apiVersion: v1
kind: Service
metadata:
  name: kud-svc
spec:
  ports:
  - port: 80
    name: foo
  type: NodePort
  selector:
    app: kud
@end=yaml@
kubectl get endpoints
watch 'kubectl get endpoints | grep kud-svc' # same number of endpoints as number of replicas
kubectl scale --replicas=4 deployment/kud
kubectl delete pod kud-85ffdf5b5-pbzbl # the replicaset of the service will recreate one
kubectl label pod kud-85ffdf5b5-chqlj --overwrite app=kud-relabeled # the pod gets taken out of the service, the service will provios a new pod so the scaling works

kubectl replace -f bip.yaml # create apply. replace is not good

kubectl api-versions
kubectl proxy
curl http://127.0.0.1:8001
curl http://127.0.0.1:8001/apis/apps/v1
curl http://127.0.0.1:8001/api/v1/namespaces/default/pods
curl http://127.0.0.1:8001/api/v1/namespaces/default/pods | jq -r '.items[].spec'
curl -XDELETE http://127.0.0.1:8001/api/v1/namespaces/default/pods/kud-85ffdf5b5-chqlj # delete the pod

kubectl get pod --v=9 # --v=9 list the CURL command todo

kubectl run game --image game --dry-run -o json # creates the json to be sent

docker run -d --name busy busybox sleep 3600
docker exec -ti busy ps -ef

docker run -d --name box --pid=container:busy busybox sleep 3000
docker exec -ti busy ps -ef

docker run -d --name toto --pid=host busybox sleep 3000
docker exec -ti toto ps -ef

docker run --rm --net=none -it busybox sh
ip a # no interfaces except lo

docker run --rm --net=host -it busybox sh
ip a # interfaces of the host

docker run --rm -d --name foo  busybox sleep 7357 # starts container 1
docker exec -it foo ifconfig # show network of container 1
docker run --rm -it --net=container:foo busybox ifconfig # start container 2 interactively with network of container 1, showing the ip. We see it's the same one

ip netns list
https://github.com/p8952/bocker # Bocker Docker implemented in around 100 lines of bash.

# https://github.com/containernetworking/cni/blob/master/scripts/docker-run.sh

https://ahmet.im/blog/kubernetes-network-policy/
https://github.com/ahmetb/kubernetes-networkpolicy-tutorial


kubectl label node minikube app=kude

# sysdig guide monitoring
backup heptio ark
@end=sh@

kubectl rollout undo deployments MYDEP --to-revision 1

#  CLI
kubectl controls the Kubernetes cluster manager.

Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create         Create a resource from a file or from stdin.
  expose         Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run            Run a particular image on the cluster
  set            Set specific features on objects

Basic Commands (Intermediate):
  explain        Documentation of resources
  get            Display one or many resources
  edit           Edit a resource on the server
  delete         Delete resources by filenames, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout        Manage the rollout of a resource
  scale          Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job
  autoscale      Auto-scale a Deployment, ReplicaSet, or ReplicationController

Cluster Management Commands:
  certificate    Modify certificate resources.
  cluster-info   Display cluster info
  top            Display Resource (CPU/Memory/Storage) usage.
  cordon         Mark node as unschedulable
  uncordon       Mark node as schedulable
  drain          Drain node in preparation for maintenance
  taint          Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe       Show details of a specific resource or group of resources
  logs           Print the logs for a container in a pod
  attach         Attach to a running container
  exec           Execute a command in a container
  port-forward   Forward one or more local ports to a pod
  proxy          Run a proxy to the Kubernetes API server
  cp             Copy files and directories to and from containers.
  auth           Inspect authorization

Advanced Commands:
  apply          Apply a configuration to a resource by filename or stdin
  patch          Update field(s) of a resource using strategic merge patch
  replace        Replace a resource by filename or stdin
  wait           Experimental: Wait for one condition on one or many resources
  convert        Convert config files between different API versions

Settings Commands:
  label          Update the labels on a resource
  annotate       Update the annotations on a resource
  completion     Output shell completion code for the specified shell (bash or zsh)

Other Commands:
  alpha          Commands for features in alpha
  api-resources  Print the supported API resources on the server
  api-versions   Print the supported API versions on the server, in the form of "group/version"
  config         Modify kubeconfig files
  plugin         Runs a command-line plugin
  version        Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).


kubectl get pods www -o json | jq -r .status.podIP


# Configure Probes
Liveness  probe to know when to restart a container
Readiness probe to know when pod is set to running/when to send traffice to it # readyness
probe: TCP, HTTP, EXEC

Probes have a number of fields that you can use to more precisely control the behavior of liveness and readiness checks:
initialDelaySeconds: Number of seconds after the container has started before liveness or readiness probes are initiated.
periodSeconds: How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
timeoutSeconds: Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1.
successThreshold: Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness. Minimum value is 1.
failureThreshold: When a Pod starts and the probe fails, Kubernetes will try failureThreshold times before giving up. Giving up in case of liveness probe means restarting the Pod. In case of readiness probe the Pod will be marked Unready. Defaults to 3. Minimum value is 1.
```yaml
          livenessProbe:
            initialDelaySeconds: 5
            periodSeconds: 1
            failureThreshold: 40
            timeout: 5
            httpGet:
              path: /metrics
              port: http
              httpHeaders:
                - name: Host
                  value: KubernetesLivenessProbe
          readinessProbe:
            initialDelaySeconds: 1
            periodSeconds: 4
            timeout: 5
            successThreshold: 5
            failureThreshold: 32
            httpGet:
              path: /metrics
              port: http
              httpHeaders:
                - name: Host
                  value: KubernetesReadinessProbe
```
Note: both probes are started at the same time as can be seen by those events coming from the readiness: initialDelaySeconds: 1 periodSeconds: 4, liveness delay: 5: period 1:
T                  NAMESPACE        LAST SEEN   FIRST SEEN  COUNT     NAME                                               KIND      SUBOBJECT                         TYPE      REASON      SOURCE                                               MESSAGE
0 Jan 23 09:42:54
 1R Jan 23 09:42:55 fabric-ci-1512   <invalid>   <invalid>   1         api-controller-75bcb95555-82m57.157c6db4002c3626   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Readiness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 5L Jan 23 09:42:57 fabric-ci-1512   <invalid>   <invalid>   1         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 6L Jan 23 09:42:58 fabric-ci-1512   <invalid>   <invalid>   2         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 7R Jan 23 09:42:59 fabric-ci-1512   <invalid>   <invalid>   2         api-controller-75bcb95555-82m57.157c6db4002c3626   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Readiness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 7L Jan 23 09:42:59 fabric-ci-1512   <invalid>   <invalid>   3         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 8L Jan 23 09:43:00 fabric-ci-1512   <invalid>   <invalid>   4         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
 9L Jan 23 09:43:01 fabric-ci-1512   <invalid>   <invalid>   5         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
10L Jan 23 09:43:02 fabric-ci-1512   <invalid>   <invalid>   6         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
11R Jan 23 09:43:03 fabric-ci-1512   <invalid>   <invalid>   3         api-controller-75bcb95555-82m57.157c6db4002c3626   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Readiness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused
11L Jan 23 09:43:03 fabric-ci-1512   <invalid>   <invalid>   7         api-controller-75bcb95555-82m57.157c6db49ce4f8e2   Pod       spec.containers{api-controller}   Warning   Unhealthy   kubelet, ip-172-29-9-57.us-east-2.compute.internal   Liveness probe failed: Get http://100.96.6.131:8080/metrics: dial tcp 100.96.6.131:8080: getsockopt: connection refused




lifecycle: init_container, postStart, preStop

pod:
  securityContext:
    runAsNonRoot: true # securityContext

pod security policy

sebastiengoasguen # training author


pod has one or more containers
replicasets scales pods
deployments handles (rolling) updates with the creation of new replicasets so we can create rollouts
service points to pod with matching labels
ingress improves nodeport (and make clusterip sufficient)
DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.
https://kubernetes.io/docs/tasks/administer-cluster/static-pod/


kubectl run --rm -it --image=busybox:1.28 mydebugpod /bin/sh # creates a deployment that will be deleted thanks to the --rm flag.

kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c kubedns
kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c dnsmasq
kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c sidecar

# memory
https://grafana.bravo.k8s.greypay.net/d/-MIZIi1mk/systemd-slice-memory-usage?refresh=10s&panelId=28&orgId=1&from=now-24h&to=now&var-Node=All&tab=metrics
https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/
https://github.com/kubernetes/kops/blob/master/docs/node_resource_handling.md

crane: add tarball file on top existing image
ko:

kubectl run game --image runseb/2048 -o yaml
kubectl expose deployment game --port 80 --type NodePort
kubectl get svc game --export -o yaml > game-svc.yml
{{ .Values.replicaCount }}
helm package MYNAME # creates the tgz
helm install ./MYNAME.tgz
helm ls
helm upgrade --set replicaCount=2

https://kubernetes.io/docs/tutorials/object-management-kubectl/imperative-object-management-command/
https://kubernetes.io/docs/tutorials/object-management-kubectl/imperative-object-management-configuration/
https://kubernetes.io/docs/tutorials/object-management-kubectl/imperative-object-management-configuration/
https://kubernetes.io/docs/tutorials/object-management-kubectl/imperative-object-management-configuration/o

https://github.com/kubernetes-sigs/kustomize/releases

kompose
kustomize
https://github.com/sebgoa/kkcd

# crane
cd $(mktemp -d);
mkdir hehe;
date > hehe/hihi;
tar cf bip.tar hehe/;
crane append -b busybox -f ./bip.tar -t babar -o babar.tar;
docker load -i babar.tar;
docker run --rm -it babar cat /hehe/hihi;
-> my date

# kaniko

# ko

# labels
kubectl get pod -n kube-system --selector k8s-app=fluentd-logging # labels
kgp -Al app=sfw-cron # labels
kgp -Al app=stp # labels

# rolloute
kubectl rollout status -n kube-system daemonset/fluentd
```yaml
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
```

https://microk8s.io/ # minikube replacement native ubuntu (snap) installer

# links
* https://medium.com/coryodaniel/encrypting-secret-data-at-rest-with-kops-cad1ea94c9d8
* https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/
* https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#podspec-v1-core
* https://kubernetes.io/docs/concepts/storage/storage-classes/#provisioner

kubectl get events -n mynamespace get events -w
kubectl get event --namespace abc-namespace --field-selector involvedObject.name=my-pod-zl6m6


# jsonpath
```sh
kgp -n fabric-ci-665 --no-headers -o jsonpath='{.items[*].metadata.name}'
kgp -n fabric-ci-665 --no-headers -o jsonpath='{.items[*].metadata.name}' | xargs -n1 echo
kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' # list containers by pod
kubectl --kubeconfig admin.conf get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.status.startTime}{" "}{.metadata.name}{end}' | sort
kubectl get po --all-namespaces -o custom-columns=NAME:.metadata.name,NS:.metadata.namespace,IP:.status.podIP
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
kops get ig -o json | jq -r '.[]| .metadata.name + ": " + .spec.machineType'

kubectl --kubeconfig ~root/admin.conf get namespaces # file config context
kubectl get pods -n fabric-ci-1194 fabric-peers-0 -o jsonpath='{.spec.containers[*].name}' # list containers in pod
kubectl get pods -n fabric-ci-1194 fabric-peers-0 -o jsonpath='{range .items[*]}{"\n"}{.spec.containers[*].name}{end}' # list containers in pod
kubectl get namespace --no-headers -o custom-columns=name:.metadata.name
kubectl get pod -n sfw-production -o json sfw-cron-5df5bf7dff-qgd7x | jq '.metadata.labels'
```

kubectl get limitranges
kubectl describe limitranges cpu-mem-limit-range --namespace cfc-prod-cri

# skip API server SSL TLS validation
```yaml
clusters:
- name: ubuntu
  cluster:
    insecure-skip-tls-verify: true
    server: https://master:6443
```


kubectl create secret generic tls kubernetes-dashboard-certs \
  --from-file=tls.crt=/path/to/dashboard.crt \
  --from-file=tls.key=/path/to/dashboard.key --namespace kube-system

kubectl wait --for=condition=Ready pod/busybox1 # experimental
kubectl wait --for=delete pod/busybox1 --timeout=60s


# fluentd
https://github.com/splunk/fluent-plugin-kubernetes-objects

# ingress controller
https://kubernetes.github.io/ingress-nginx/user-guide/tls/#default-tls-version-and-ciphers
https://testssl.sh
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#ssl-protocols
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: nginx-config
data:
  ssl-ciphers: "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA"
  ssl-protocols: "TLSv1.3 TLSv1.2"
```


kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --no-headers --ignore-not-found=true -A
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --no-headers --ignore-not-found=true -A G -E 'nginx|ingress' | awk '{ print $1 " " $2 }' | while read a b; do kubectl delete -n $a $b; done
