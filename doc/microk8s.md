# storage

/var/snap/microk8s/common/default-storage/
sed -r -i -e 's/--pod-cidr=.*/--pod-cidr=10.199.1.0\/24/' current/microk8s-resources/default-args/kubelet
sudo snap install microk8s --classic --channel=1.12/stable
vi /snap/microk8s/current/microk8s-resources/default-args/kubelet
vi /snap/microk8s/current/microk8s-resources/kubelet.config
sudo iptables -P FORWARD ACCEPT
