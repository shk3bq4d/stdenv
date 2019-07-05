export SNAP=/snap/microk8s/current
export SNAP_DATA=/snap/microk8s/current
export SNAP_DATA=/snap/microk8s/current/microk8s-resources

# storage

/var/snap/microk8s/common/default-storage/
sed -r -i -e 's/--pod-cidr=.*/--pod-cidr=10.199.1.0\/24/' /var/snap/microk8s/current/args/kubelet
sed -r -i -e 's/("subnet": *")[^"]+/\110.199.1.0\/24/'    /var/snap/microk8s/current/args/cni-network/cni.conf
sudo snap install microk8s --classic --channel=1.12/stable
sudo snap install microk8s --classic --channel=1.14/stable
vi /snap/microk8s/current/microk8s-resources/default-args/kubelet
vi /snap/microk8s/current/microk8s-resources/kubelet.config
sudo iptables -P FORWARD ACCEPT
Adding --iptables=false to /var/snap/microk8s/current/args/dockerd fixes it.


# dockerd
export DOCKER_HOST="unix:///var/snap/microk8s/current/docker.sock"
microk8s.docker
## two hosts directives in to have gitlab runner build docker images /var/snap/microk8s/current/args/dockerd
-H tcp://10.199.1.1:2375
-H unix://${SNAP_DATA}/docker.sock


# upgrade
sudo snap refresh microk8s --classic --channel=1.14/stable
sudo snap info microk8s 
