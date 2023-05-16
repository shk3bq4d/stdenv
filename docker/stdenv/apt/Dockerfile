FROM ubuntu:22.04

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
		jq \
		less \
		locales-all \
		locate \
		moreutils \
		ncurses-term \
		nethogs \
		net-tools \
		netcat \
		nmap \
		p7zip-full \
		p7zip-rar \
		puppet-lint \
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

COPY stdenv-image-build-time.sh /usr/local/bin
COPY sudoers /etc/sudoers
WORKDIR /root
COPY entrypoint.sh .
ENTRYPOINT ["/root/entrypoint.sh"]

# U6aMy0wojraho is hash of empty password
RUN true \
	&& mkdir -p /stdenv/root /stdenv/user \
	&& useradd -u 1000 -d /home/user             -m     user -s /usr/bin/zsh \
	&& echo user:U6aMy0wojraho | sudo chpasswd -e \
	&& touch /root/.zshrc /home/user/.zshrc \
	&& mkdir -p /root/.tmp/log /stdenv/user/.tmp/log \
	&& chown user: /home/user/.zshrc /stdenv/user/ \
	&& date > /.dockerenv-apt \
	&& chmod 0755 /usr/local/bin/stdenv-image-build-time.sh \
	&& true

# && sed -i -r -e "s,^%sudo\\s.*,%sudo ALL=(ALL) NOPASSWD: ALL," /etc/sudoers \

ENV DEBIAN_FRONTEND ""

#CMD zsh
