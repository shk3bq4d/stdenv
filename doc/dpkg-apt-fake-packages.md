
```sh
i=libqt5webkit5
mkdir -p   /tmp/$i/DEBIAN
chmod 0755 /tmp/$i/DEBIAN
cat <<EOF | tee /tmp/$i/DEBIAN/control
Package: $i
Version: 11
Section: misc
Priority: optional
Architecture: all
Maintainer: Dummy <dummy@example.com>
Provides: $i
Conflicts:
Replaces:
Description: Dummy empty package
EOF

dpkg-deb --build /tmp/$i
sudo dpkg -i /tmp/$i.deb
sudo apt list --installed | grep $i
```
