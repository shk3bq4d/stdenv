stat -c "%u" myfile # owner of file
stat -c "%g" myfile # group of file
stat -c "%a" myfile # permissions in octal format (0644)
echo $(( $(stat -c "%a" /tmp/coucou) / 100     )) user permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 100) & 1    )) user execute permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 100) & 2    )) user write permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 100) & 4    )) user read permission
echo $(( $(stat -c "%a" /tmp/coucou) / 10 % 10 )) group permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 10 % 10) & 1 )) group execute permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 10 % 10) & 2 )) group write permission
echo $(( ($(stat -c "%a" /tmp/coucou) / 10 % 10) & 4 )) group read permission
echo $(( $(stat -c "%a" /tmp/coucou)      % 10 )) other permission
echo $(( $(stat -c "%a" /tmp/coucou) % 10 & 1 )) other execute permission
echo $(( $(stat -c "%a" /tmp/coucou) % 10 & 2 )) other write permission
echo $(( $(stat -c "%a" /tmp/coucou) % 10 & 4 )) other read permission
