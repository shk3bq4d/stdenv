https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/
https://docs.docker.com/engine/reference/builder/
man dockerfile # apt install docker-doc
/var/lib/docker/volumes/
docker export adoring_kowalevski > contents.tar
c=bb6bf; d=$(mktemp -d); cd $d && docker export $c | tar x

$ find $PWD | grep 57b823f5669f
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/hostname
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/hostconfig.json
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38-json.log
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/config.v2.json
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/shm
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/resolv.conf.hash
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/hosts
/var/lib/docker/containers/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/resolv.conf
/var/lib/docker/image/aufs/layerdb/mounts/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38
/var/lib/docker/image/aufs/layerdb/mounts/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/parent
/var/lib/docker/image/aufs/layerdb/mounts/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/init-id
/var/lib/docker/image/aufs/layerdb/mounts/57b823f5669fde281ee7878adfc5624789a6fd4423e15d4efa265cf3b3b76e38/mount-id

#network
http://stackoverflow.com/questions/22111060/difference-between-expose-and-publish-in-docker

docker port $CONTAINER_ID 22 # getting the contain's  external ssh port

172.17.0.1 # default network host ip


@begin=sh@
apt-get install net-tools #netstat
apt-get install nmap #nc
apt-get install less #less
apt-get install locate #locate
apt-get install vim #less


docker build -t name .
docker build -t $(basename $(realpath .)) .

# test if running inside a container:
[[ -d /.dockerenv ]] && echo yes # http://stackoverflow.com/questions/23513045/how-to-check-if-a-process-is-running-inside-docker-container

# straight from git
docker build -t rogaha/docker-desktop git://github.com/rogaha/docker-desktop.git

# run new container in background
docker run -dt mr/testimage:version2

docker run --name squid -d --restart=always --publish 127.0.0.1:3128:3128 --volume /srv/docker/squid/cache:/var/spool/squid3 sameersbn/squid:3.3.8-19

# run new container in interactive 
docker run -it --rm mr/testimage:version2

# add new shell to existing
docker exec -it 824d2ac1981e2c17c6e4b3595286d41d929ccba0f91c14127c335a891d1ec60b /bin/bash

# start container and execute bash
docker exec -t $(basename $(realpath .)) /bin/bash

# commit container change to new image
docker commit 3237c5a6802edc1f50e594988d40f63d1e0780787b13156fd1fc3b27a4672141 mr/testimage:version2


docker ps -a | grep 'Exited' | awk '{print $1}' | xargs --no-run-if-empty docker rm
docker rm $(docker ps -q -f status=exited)


export http_proxy=http://6.1.0.159:3142 && apt-get -y install python 
docker ps -a | while read a b; do docker stop $a; docker rm -v $a; done


DID=da82cbc63a14;tar cPhzpf - --transform "s,^$HOME,sshrc," ~/.sshrc ~/.sshrc.d/ | docker cp - $DID:/tmp; docker exec -it $DID /bin/bash --rcfile /tmp/sshrc/.sshrc
@end=sh@

@begin=docker@
FROM docker/whalesay:latest
RUN apt-get -y update && apt-get install -y fortunes
CMD /usr/games/fortune -a | cowsay
@end=docker@
@begin=docker@
# keywords
FROM       # https://docs.docker.com/engine/reference/builder/#from
MAINTAINER # https://docs.docker.com/engine/reference/builder/#maintainer
RUN        # https://docs.docker.com/engine/reference/builder/#run
CMD        # https://docs.docker.com/engine/reference/builder/#cmd
LABEL      # https://docs.docker.com/engine/reference/builder/#label
EXPOSE     # https://docs.docker.com/engine/reference/builder/#expose
ENV        # https://docs.docker.com/engine/reference/builder/#env
ADD        # https://docs.docker.com/engine/reference/builder/#add
COPY       # https://docs.docker.com/engine/reference/builder/#copy
ENTRYPOINT # https://docs.docker.com/engine/reference/builder/#entrypoint
VOLUME     # https://docs.docker.com/engine/reference/builder/#volume
USER       # https://docs.docker.com/engine/reference/builder/#user
WORKDIR    # https://docs.docker.com/engine/reference/builder/#workdir
ARG        # https://docs.docker.com/engine/reference/builder/#arg
ONBUILD    # https://docs.docker.com/engine/reference/builder/#onbuild
STOPSIGNAL # https://docs.docker.com/engine/reference/builder/#stopsignal
HEALTHCHECK# https://docs.docker.com/engine/reference/builder/#healthcheck
SHELL      # https://docs.docker.com/engine/reference/builder/#shell
@end=docker@


detach the tty without exiting the shell, use the escape sequence Ctrl+p + Ctrl+q.

# nice but old version
http://crosbymichael.com/advanced-docker-volumes.html

# copy files using system cp (rsync, ...)
1) docker ps
2) docker inspect -f   '{{.Id}}'  SHORT_CONTAINER_ID-or-CONTAINER_NAME
3) sudo cp path-file-host /var/lib/docker/aufs/mnt/FULL_CONTAINER_ID/PATH-NEW-FILE
# copy files using docker cp
docker cp foo.txt mycontainer:/foo.txt
docker cp mycontainer:/foo.txt foo.txt

# running container metadata
docker inspect apt-cacher-run  | less
@begin=json@
[
    {
        "Id": "5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930",
        "Created": "2016-07-12T13:33:52.621954703Z",
        "Path": "/bin/sh",
        "Args": [
            "-c",
            "chmod 777 /var/cache/apt-cacher-ng \u0026\u0026 /etc/init.d/apt-cacher-ng start \u0026\u0026 tail -f /var/log/apt-cacher-ng/*"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 6302,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2016-07-12T13:33:52.884026856Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:67626d49e982cf1f06cf79cd7f892b36670c8cac50f210b4ed08f3801ba37830",
        "ResolvConfPath": "/var/lib/docker/containers/5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930/hostname",
        "HostsPath": "/var/lib/docker/containers/5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930/hosts",
        "LogPath": "/var/lib/docker/containers/5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930/5e2b4dced1dc7414ef7ec1350266a2716f59b238323fb5649447b66d48deb930-json.log",
        "Name": "/apt-cacher-run",
        "RestartCount": 0,
        "Driver": "aufs",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": [
                "/mnt/local/00-1to/docker/apt-cacher-ng/vol00:/var/cache/apt-cacher-ng"
            ],
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "3142/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "3142"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [
                "6.1.0.33",
                "6.1.0.34"
            ],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "StorageOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": null,
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": -1,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "BlkioIOps": 0,
            "BlkioBps": 0,
            "SandboxSize": 0
        },
        "GraphDriver": {
            "Name": "aufs",
            "Data": null
        },
        "Mounts": [
            {
                "Source": "/mnt/local/00-1to/docker/apt-cacher-ng/vol00",
                "Destination": "/var/cache/apt-cacher-ng",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],
        "Config": {
            "Hostname": "5e2b4dced1dc",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "3142/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "chmod 777 /var/cache/apt-cacher-ng \u0026\u0026 /etc/init.d/apt-cacher-ng start \u0026\u0026 tail -f /var/log/apt-cacher-ng/*"
            ],
            "Image": "apt-cacher",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "ab175774852477ceb68a81e7d7df0ab588e3d82de0ff28b59120ca004a879311",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "3142/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "3142"
                    }
                ]
            },
            "SandboxKey": "/var/run/docker/netns/ab1757748524",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "3114b146eb68a9d0d0dbd306de279ca23df28a8ded601401895243f8ae5909a4",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "d8d8f27237d21677580bdf7bada01d2b8b8d6a574379cbace793bc0dd6febc55",
                    "EndpointID": "3114b146eb68a9d0d0dbd306de279ca23df28a8ded601401895243f8ae5909a4",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02"
                }
            }
        }
    }
]
@end=json@

https://github.com/jessfraz/dockerfiles/blob/master/mutt/Dockerfile

https://github.com/tianon/gosu/
https://github.com/ncopa/su-exec # (in alpine)

# x11
docker build -t xeyes - << __EOF__
FROM debian
RUN apt-get update
RUN apt-get install -qqy x11-apps
ENV DISPLAY :0
CMD xeyes
__EOF__
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 0755 $XAUTH # optional if running as different and non-priviledged UID
docker run -ti -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH xeyes

docker cp 2017-04-16.v0.7.4 database:/tmp/hehe


docker run --cap-add SYS_PTRACE --security-opt seccomp:unconfined #strace 
strace python -c "from zabbix_api import ZabbixAPI; ZabbixAPI('https://zabbix.url').login('ha', 'e');"

docker run --rm -it mausch/docker-groovysh


# centos  # https://docs.docker.com/engine/installation/linux/docker-ce/centos/#install-using-the-repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo usermod -a -G docker $(id -un)
sudo systemctl enable docker
sudo systemctl start docker

# centos config
either 
/etc/sysconfig/docker 
or 
/usr/lib/systemd/system/docker.service
echo '{ "storage-driver": "btrfs" } > /etc/docker/daemon.json


echo "
FROM ubuntu
RUN apt-get update
PRN apt-get install -y xeyes
" | docker build -f - .
