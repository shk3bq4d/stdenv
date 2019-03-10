export SNAP=/snap/microk8s/current
export SNAP_DATA=/snap/microk8s/current
export SNAP_DATA=/snap/microk8s/current/microk8s-resources

# storage

/var/snap/microk8s/common/default-storage/
sed -r -i -e 's/--pod-cidr=.*/--pod-cidr=10.199.1.0\/24/' current/microk8s-resources/default-args/kubelet
sudo snap install microk8s --classic --channel=1.12/stable
vi /snap/microk8s/current/microk8s-resources/default-args/kubelet
vi /snap/microk8s/current/microk8s-resources/kubelet.config
sudo iptables -P FORWARD ACCEPT


# dockerd
export DOCKER_HOST="unix:///var/snap/microk8s/current/docker.sock"
microk8s.docker
