FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN \
	true \
	&& apt update -y \
	&& apt install -y \
		bash \
		p7zip-full \
		p7zip-rar \
		apt-transport-https \
		ascii \
		apt-file \
		build-essential \
		ca-certificates \
		cmake \
		curl \
		dos2unix \
		moreutils \
		gawk \
		git \
		ipcalc \
		less \
		locate \
		net-tools \
		nmap \
		python-pip \
		python3-pip \
		python2.7 \
		pylint \
		pylint3 \
		locales-all \
		puppet-lint \
		software-properties-common \
		sysstat \
		util-linux \
		vim \
		tree \
		virtualenv \
		virtualenvwrapper \
		zsh \
		apt-transport-https \
		ca-certificates \
		software-properties-common

ENV DEBIAN_FRONTEND ""

CMD zsh
