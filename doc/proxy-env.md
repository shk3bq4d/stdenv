@begin=sh@
curl --socks5 127.0.0.1:65013 https://bip.com # to be used with ssh -D 65013 jump.com


@begin=python@
proxies = {'http': 'http://mitmproxy.burp.local:8080', 'https': 'http://mitmproxy.burp.local:8080' }
requests.get(url, params=None, proxies=proxies, verify=True)
@end=python@


http://spys.one/free-proxy-list/FR/ # proxy by country
https://www.google.com/search?gfe_rd=cr&gws_rd=cr&q=%22http%22%20%22proxy%22%20%22france%22 # http proxy france
