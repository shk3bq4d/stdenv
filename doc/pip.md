pip show requests # display version

pip install virtualenv virtualenvwrapper

# ignore https validation
1) pip install --index-url=http://pypi.python.org/simple/ --trusted-host pypi.python.org  pythonPackage
2) pip --cert /etc/ssl/certs/FOO_Root_CA.pem install linkchecker
3) find /usr/lib/python2.7/site-packages -type f -name cacert.pem | \
	while read f; do cat /workdir/firewall.hq.k.grp.crt >> $f; done && \
	pip install blabla
4) cat ~/.pip/pip.conf 
   $HOME/.config/pip/pip.conf
[global]
cert = /home/fblaise/Downloads/kg_cabundle.pem

#ne

pip list # list installed packages existing
