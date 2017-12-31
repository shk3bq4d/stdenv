# installation
cd /tmp
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
apt update
apt install i3

# https://i3wm.org/docs/userguide.html


file explorer: thunar

Mod+a select all

i3 '[id="94475176160464"] focus'
i3 '[id="127926281"] fullscreen'
i3 '[id="127926281"] floating enable'
~/bin/i3-get-window-criteria.sh
