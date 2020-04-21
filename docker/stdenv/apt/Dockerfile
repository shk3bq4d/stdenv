FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN \
	true \
	&& apt update -y \
	&& apt dist-upgrade -y \
	&& apt install -y \
		apt-file \
		apt-transport-https \
		ascii \
		bash \
		build-essential \
		ca-certificates \
		cmake \
		curl \
		dnsutils \
		dos2unix \
		gawk \
		git \
		htop \
		iftop \
		ipcalc \
		iputils-ping \
		less \
		locales-all \
		locate \
		moreutils \
		nethogs \
		net-tools \
		netcat \
		nmap \
		p7zip-full \
		p7zip-rar \
		puppet-lint \
		pylint \
		pylint3 \
		python-pip \
		python2.7 \
		python3-pip \
		software-properties-common \
		sudo \
		sysstat \
		tree \
		util-linux \
		vim \
		virtualenv \
		virtualenvwrapper \
		wget \
		zsh \
	&& true

RUN true \
	&& useradd -u 1000 -d /home/user             -m     user \
	&& useradd -u 1001 -d /home/sudouser -G sudo -m sudouser \
	&& sed -i -r -e "s,^%sudo\\s.*,%sudo ALL=(ALL) NOPASSWD: ALL," /etc/sudoers \
	&& true

ENV DEBIAN_FRONTEND ""

CMD zsh
