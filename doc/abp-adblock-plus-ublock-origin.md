
# for :has() and :has-text() a hostname has to be entered
zabbix.host.net##table.list-table > tbody > tr:has-text(VPN-CUS)
zabbix.host.net###filter-space

# remove class
https://stackoverflow.com/questions/67850933/remove-class-from-body-dynamically-using-ublock-origin
www.example.com##body:remove-class(xyz)
www.example.com##body:watch-attr(class):remove-class(xyz)


! http://127.0.0.1:57155/www/stdenv/adblock-ublock-origin.list


