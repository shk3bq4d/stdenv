# scan sr network to find out vpn ips
nmap -sn 10.11.12.0/24

yum install -y nmap


nmap -p1-65535 canon
sudo nmap -PN ly158
sudo nmap -sn ly158
sudo nmap -O ly158
sudo nmap -sV cam1w

sudo nmap -oN - --open -p22,80,443,3389,4100,4109,4300,5061,5222,8080,8443
sudo nmap -oN - --open -p22,80,443,3389,4100,4109,4300,5061,5222,8080,8443


https://github.com/vulnersCom/nmap-vulners

mkdir -p ~/.nmap/nselib/data
cd ~/.nmap
git clone https://github.com/vulnersCom/nmap-vulners scripts
mv scripts/http-vulners-regex.json nselib/data/
nmap -d -p443,7443,7444,80 --script http-vulners-regex MYDOMAIN --script-args 'paths={"/"}'
