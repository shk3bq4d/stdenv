# scan sr network to find out vpn ips
nmap -sn 10.11.12.0/24

yum install -y nmap


nmap -p1-65535 canon
sudo nmap -Pn ly158 # skip ping and start heavier scan
sudo nmap -sn ly158 # Ping Scan - disable port scan
sudo nmap -O ly158  # Enable OS detection
sudo nmap -sV cam1w

sudo nmap -oN - --open -p22,80,443,3389,4100,4109,4300,5061,5222,8080,8443
sudo nmap -oN - --open -p22,80,443,3389,4100,4109,4300,5061,5222,8080,8443
sudo nmap -oN - --open -p443 172.31.11.0/24


https://github.com/vulnersCom/nmap-vulners

mkdir -p ~/.nmap/nselib/data
cd ~/.nmap
git clone https://github.com/vulnersCom/nmap-vulners scripts
mv scripts/http-vulners-regex.json nselib/data/
nmap -d -p443,7443,7444,80 --script http-vulners-regex MYDOMAIN --script-args 'paths={"/"}'

sudo nmap -Pn 10.102.10.91 10.102.10.92 10.102.10.93
for i in 10.102.10.91 10.102.10.92 10.102.10.93 10.102.10.91 10.102.10.92 10.102.10.93; do
	echo $i
	sudo nmap -O $i
	dig +short -x $i || echo no default dns
	for dns in 10.{102,103}.1.{1,8}; do
		dig +short -x $i @$ns || echo no dns @$dns
	done
done
