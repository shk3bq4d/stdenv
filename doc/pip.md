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

# broken pip10 upgrade 20180423
Traceback (most recent call last):
  File "/usr/local/bin/pip", line 7, in <module>
    from pip import main
ImportError: cannot import name main
https://github.com/pypa/pip/issues/5240
~/.local/bin/pip install --upgrade pip==9.0.3


uninstall # remove delete
--force-reinstall
python -m pip install burp

pip install --user ldap3=2.5.1 # https://github.com/cannatag/ldap3/issues/639 File "/home/bip/.local/lib/python2.7/site-packages/ldap3/protocol/formatters/formatters.py", line 337, in format_ad_timedelta return format_ad_timestamp(raw_value * -1) - format_ad_timestamp(0) TypeError: unsupported operand type(s) for -: 'str' and 'datetime.datetime'

pip #noop dry-run dryrun simulate noactions: TOUGH LUCK, NO SUCH THING https://stackoverflow.com/questions/29531094/how-to-make-pip-dry-run

# A command line utility to display dependency tree of the installed Python packages https://github.com/naiquevin/pipdeptree


https://www.wheelodex.org/projects/cffi/
https://github.com/montag451/pypi-mirror/issues/16 multiple --platform --abi


pip install --target=/tmp --only-binary=:all: cffi cryptography --abi cp38 --abi cp36 --platform manylinux_2_12_x86_64 --platform manylinux_2_24_x86_64 --python-version 38 --implementation cp
pip install --target=/tmp --only-binary=:all: cffi cryptography --platform manylinux2010_x86_64

error: command 'x86_64-linux-gnu-gcc' failed: No such file or directory # apt install python3-dev build-essential
