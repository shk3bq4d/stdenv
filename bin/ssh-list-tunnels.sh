#!/usr/bin/env python

#echo 'type ~# for direct info from SSH console'
#sudo netstat -ntlpe | grep -E "(\S+\s+){6}$UID\s+"

import subprocess

s = subprocess.Popen('sudo netstat -tlnpe'.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
out = '\n'.join(map(str.strip, s.communicate()))
#out = str(s.stdout)
print(out)

print('coucou')
