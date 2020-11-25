# version history
## https://www.nginx.com/blog/nginx-1-18-1-19-released/
At NGINX, we maintain two branches in the NGINX Open Source code repository,
   named mainline and stable:

Mainline is the active development branch where the latest features and bug
fixes get added. It is denoted by an odd number in the second part of the
version number, for example 1.19.0.  Stable receives fixes for high‑severity
bugs, but is not updated with new features. It is denoted by an even number in
the second part of the version number, for example 1.18.0.
```sh
curl -s https://nginx.org/en/CHANGES-1.18 | sed -n -r -e '/^Changes with nginx/s/(.*nginx )(.*)/\2/ p'
```
* https://nginx.org/en/CHANGES-1.14
  1.14.0                                        17 Apr 2018
  1.14.1                                        06 Nov 2018
  1.14.2                                        04 Dec 2018
* https://nginx.org/en/CHANGES-1.16
  1.16.1                                        13 Aug 2019
  1.16.0                                        23 Apr 2019
  1.15.12                                       16 Apr 2019
  1.15.11                                       09 Apr 2019
  1.15.10                                       26 Mar 2019
  1.15.9                                        26 Feb 2019
  1.15.8                                        25 Dec 2018
  1.15.7                                        27 Nov 2018
  1.15.6                                        06 Nov 2018
  1.15.5                                        02 Oct 2018
  1.15.4                                        25 Sep 2018
  1.15.3                                        28 Aug 2018
  1.15.2                                        24 Jul 2018
  1.15.1                                        03 Jul 2018
  1.15.0                                        05 Jun 2018
* https://nginx.org/en/CHANGES-1.18
  1.18.0                                        21 Apr 2020
  1.17.10                                       14 Apr 2020
  1.17.9                                        03 Mar 2020
  1.17.8                                        21 Jan 2020
  1.17.7                                        24 Dec 2019
  1.17.6                                        19 Nov 2019
  1.17.5                                        22 Oct 2019
  1.17.4                                        24 Sep 2019
  1.17.3                                        13 Aug 2019
  1.17.2                                        23 Jul 2019
  1.17.1                                        25 Jun 2019
  1.17.0                                        21 May 2019

https://nginx.org/en/security_advisories.html # CVE

http://nginx.org/en/docs/http/ngx_http_headers_module.html


yum install http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install nginx


# Permission denied) while connecting to upstream
# http://stackoverflow.com/questions/23948527/13-permission-denied-while-connecting-to-upstreamnginx
setsebool httpd_can_network_connect on -P


# reverse proxy
http{
    server{
           location ~* ^/nginx/(.*)$ {
                     proxy_pass http://127.0.0.1:8080/$1;
                           proxy_redirect off;
                              }
            }
}
# almost same but support query string
http{
    server{
           location ~* ^/ {
                     rewrite ^\/(.*) /$1 break;
                           proxy_pass http://127.0.0.1:8080;
                              }
            }
}


# log post data
### https://stackoverflow.com/a/14034744
apt install libnginx-mod-http-echo
### before server
log_format post_logs '[$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" [$request_body]';
### in the desired location
    location /r/d/ct/ {
       echo_read_request_body;
       access_log  /var/log/nginx/expect-ct.log  post_logs;
    }


/usr/sbin/nginx -s reload # hot re-read configuration
/sbin/nginx     -s reload # hot re-read configuration

ssl_protocols SSLv2 SSLv3 TLSv1.1 TLSv1.2 TLSv1.3;

/usr/sbin/nginx -v # version
/sbin/nginx     -v # version


     proxy_set_header  Host             oos.collab.local;
     proxy_pass https://oos;
     proxy_pass_request_headers on;
     proxy_redirect https://oos.collab.local https://oos.io.burp.com;
