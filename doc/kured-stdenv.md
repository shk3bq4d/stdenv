* https://github.com/kubereboot/kured
* https://github.com/kubereboot/charts
* https://github.com/kubereboot/kured/releases
* https://github.com/weaveworks/kured # legacy repo, currently forwarding to kubereboot
* https://kured.dev/docs/installation/ # version compatibility

# reboot
```sh
echo b | keti -n kured kured-6brpw tee /proc/sysrq-trigger # rough  force reboot
```

# official install
```sh
latest=$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')
kubectl apply -f "https://github.com/kubereboot/kured/releases/download/$latest/kured-$latest-dockerhub.yaml"
```

# vi manifest
```sh
vi "https://github.com/kubereboot/kured/releases/download/$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')/kured-$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')-dockerhub.yaml"
```

# stdout stderr
stderr: WARNING: ignoring DaemonSet-managed Pods: filebeat/filebeat-kb9wg, kube-system/azure-ip-masq-agent-jtssr, kube-system/cloud-node-manager-thxxs, kube-system/csi-azuredisk-node-qxd5f, kube-system/csi-azurefile-node-7dt8q, kube-system/kube-proxy-lm5c5, kured/kured-z6v4l, prometheus/prometheus-node-exporter-2pp8t
stdout: evicting pod prometheus/prometheus-pushgateway-587c8dc779-q9pzn
stderr: error when evicting pod "metrics-server-db666f966-xm6ns" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
stdout: time="2023-06-20T07:01:07Z" level=info msg="Acquired reboot lock"

# 1.13.1 manifest
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: kured
rules:
# Allow kured to read spec.unschedulable
# Allow kubectl to drain/uncordon
#
# NB: These permissions are tightly coupled to the bundled version of kubectl; the ones below
# match https://github.com/kubernetes/kubernetes/blob/v1.19.4/staging/src/k8s.io/kubectl/pkg/cmd/drain/drain.go
#
- apiGroups: [""]
  resources: ["nodes"]
  verbs:     ["get", "patch"]
- apiGroups: [""]
  resources: ["pods"]
  verbs:     ["list","delete","get"]
- apiGroups: ["apps"]
  resources: ["daemonsets"]
  verbs:     ["get"]
- apiGroups: [""]
  resources: ["pods/eviction"]
  verbs:     ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: kured
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: kured
subjects:
- kind: ServiceAccount
  name: kured
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: kube-system
  name: kured
rules:
# Allow kured to lock/unlock itself
- apiGroups:     ["apps"]
  resources:     ["daemonsets"]
  resourceNames: ["kured"]
  verbs:         ["update"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: kube-system
  name: kured
subjects:
- kind: ServiceAccount
  namespace: kube-system
  name: kured
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: kured
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kured
  namespace: kube-system
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: kured # Must match `--ds-name`
  namespace: kube-system # Must match `--ds-namespace`
spec:
  selector:
    matchLabels:
      name: kured
  updateStrategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        name: kured
    spec:
      serviceAccountName: kured
      tolerations:
        - key: node-role.kubernetes.io/control-plane
          effect: NoSchedule
        - key: node-role.kubernetes.io/master
          effect: NoSchedule
      hostPID: true # Facilitate entering the host mount namespace via init
      restartPolicy: Always
      containers:
        - name: kured
          # If you find yourself here wondering why there is no
          # :latest tag on Docker Hub,see the FAQ in the README
          image: ghcr.io/kubereboot/kured:1.13.1
          imagePullPolicy: IfNotPresent
          securityContext:
            privileged: true # Give permission to nsenter /proc/1/ns/mnt
          ports:
            - containerPort: 8080
              name: metrics
          env:
            # Pass in the name of the node on which this pod is scheduled
            # for use with drain/uncordon operations and lock acquisition
            - name: KURED_NODE_ID
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
          command:
            - /usr/bin/kured
#            - --force-reboot=false
#            - --drain-grace-period=-1
#            - --skip-wait-for-delete-timeout=0
#            - --drain-timeout=0
#            - --period=1h
#            - --ds-namespace=kube-system
#            - --ds-name=kured
#            - --lock-annotation=weave.works/kured-node-lock
#            - --lock-ttl=0
#            - --prometheus-url=http://prometheus.monitoring.svc.cluster.local
#            - --alert-filter-regexp=^RebootRequired$
#            - --alert-firing-only=false
#            - --reboot-sentinel=/var/run/reboot-required
#            - --prefer-no-schedule-taint=""
#            - --reboot-sentinel-command=""
#            - --slack-hook-url=https://hooks.slack.com/...
#            - --slack-username=prod
#            - --slack-channel=alerting
#            - --notify-url="" # See also shoutrrr url format
#            - --message-template-drain=Draining node %s
#            - --message-template-reboot=Rebooting node %s
#            - --message-template-uncordon=Node %s rebooted & uncordoned successfully!
#            - --blocking-pod-selector=runtime=long,cost=expensive
#            - --blocking-pod-selector=name=temperamental
#            - --blocking-pod-selector=...
#            - --reboot-days=sun,mon,tue,wed,thu,fri,sat
#            - --reboot-delay=90s
#            - --start-time=0:00
#            - --end-time=23:59:59
#            - --time-zone=UTC
#            - --annotate-nodes=false
#            - --lock-release-delay=30m
#            - --log-format=text
