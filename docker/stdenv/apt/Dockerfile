FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN \
	true \
	&& apt update -y \
	&& apt install -y \
		apt-file \
		apt-transport-https \
		ascii \
		bash \
		build-essential \
		ca-certificates \
		cmake \
		curl \
		dos2unix \
		gawk \
		git \
		ipcalc \
		iputils-ping \
		less \
		locales-all \
		locate \
		moreutils \
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
		sysstat \
		tree \
		util-linux \
		vim \
		virtualenv \
		virtualenvwrapper \
		wget \
		zsh \
	&& true

ENV DEBIAN_FRONTEND ""

CMD zsh
