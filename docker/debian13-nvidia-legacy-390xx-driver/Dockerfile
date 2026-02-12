FROM debian:sid

RUN apt-get update && apt-get install -y --no-install-recommends \
    devscripts equivs build-essential fakeroot dpkg-dev \
    ca-certificates gnupg dirmngr \
    && rm -rf /var/lib/apt/lists/*

# Enable sid sources to fetch Debian source packages
RUN printf "deb-src http://deb.debian.org/debian sid main contrib non-free non-free-firmware\n" \
    > /etc/apt/sources.list.d/sid-src.list

WORKDIR /build
