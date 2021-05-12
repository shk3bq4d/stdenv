FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN \
	true \
	&& apt update -y \
	&& apt dist-upgrade -y \
	&& apt install -y \
		ack \
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
		gettext-base \
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
		pylint3 \
		python3-pip \
		rename \
		rsync \
		screen \
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
	&& mkdir -p /stdenv/root /stdenv/user \
	&& useradd -u 1000 -d /home/user             -m     user -s /usr/bin/zsh \
	&& touch /root/.zshrc /home/user/.zshrc \
	&& mkdir -p /root/.tmp/log /stdenv/user/.tmp/log \
	&& chown user: /home/user/.zshrc /stdenv/user/ \
	&& true

# && sed -i -r -e "s,^%sudo\\s.*,%sudo ALL=(ALL) NOPASSWD: ALL," /etc/sudoers \
COPY sudoers /etc/sudoers

ENV DEBIAN_FRONTEND ""

WORKDIR /root
COPY entrypoint.sh .
ENTRYPOINT ["/root/entrypoint.sh"]
#CMD zsh
