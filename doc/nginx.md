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
https://nginx.org/en/CHANGES-1.20
  1.20.2                                        16 Nov 2021
  1.20.1                                        25 May 2021
  1.20.0                                        20 Apr 2021

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

# location match
```sh
(none): If no modifiers are present, the location is interpreted as a prefix match. This means that the location given will be matched against the beginning of the request URI to determine a match.
=: If an equal sign is used, this block will be considered a match if the request URI exactly matches the location given.
~: If a tilde modifier is present, this location will be interpreted as a case-sensitive regular expression match.
~*: If a tilde and asterisk modifier is used, the location block will be interpreted as a case-insensitive regular expression match.
^~: If a carat and tilde modifier is present, and if this block is selected as the best non-regular expression match, regular expression matching will not take place.
```

# location priority
https://stackoverflow.com/questions/5238377/nginx-location-priority
https://nginx.viraptor.info/
https://nginx.org/en/docs/http/ngx_http_core_module.html#location
1. Directives with the "=" prefix that match the query exactly. If found, searching stops.
2. All remaining directives with conventional strings. If this match used the "^~" prefix, searching stops.
3. Regular expressions, in the order they are defined in the configuration file.
4. If #3 yielded a match, that result is used. Otherwise, the match from #2 is used.
```sh
location  = / {
  # matches the query / only.
  [ configuration A ]
}
location  / {
  # matches any query, since all queries begin with /, but regular
  # expressions and any longer conventional blocks will be
  # matched first.
  [ configuration B ]
}
location /documents/ {
  # matches any query beginning with /documents/ and continues searching,
  # so regular expressions will be checked. This will be matched only if
  # regular expressions don't find a match.
  [ configuration C ]
}
location ^~ /images/ {
  # matches any query beginning with /images/ and halts searching,
  # so regular expressions will not be checked.
  [ configuration D ]
}
location ~* \.(gif|jpg|jpeg)$ {
  # matches any request ending in gif, jpg, or jpeg. However, all
  # requests to the /images/ directory will be handled by
  # Configuration D.
  [ configuration E ]
}
```

# log format
```sh
http {
    [..]
    map $http_x_request_id $req_id {
      default   $http_x_request_id;
      ""        $request_id;
    }
    log_format main '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $request_length $request_time [$proxy_upstream_name] [$proxy_alternative_upstream_name] $upstream_addr $upstream_response_length $upstream_response_time $upstream_status $req_id';

    set $proxy_upstream_name "proxy-default-proxy-upstream-name"; # not sure if can be set in there
    server {
        location ~* \.(?:manifest|webmanifest)$ {
            set $proxy_alternative_upstream_name "manifest";
        }

        location ~ /\. {
            set $proxy_alternative_upstream_name "deny-root-dot";
        }

        set $proxy_alternative_upstream_name "greenapp";
        set $proxy_upstream_name "server-default-proxy-upstream-name";
    }
}
```

nginx -t -c /etc/nginx/nginx.conf # test config
nginx -t -c /etc/nginx/nginx.conf && systemctl reload nginx # test config && restart
chcon -Rv -t httpd_sys_content_t /var/www/ # selinux



upstream beats {
#hash '$remote_addr $remote_port';
#hash $remote_addr;
  hash $connection;
  zone beats 64k;
#server 10.81.100.193:5045 weight=3 max_conns=4;
#server 127.0.0.1:5045 weight=5 max_conns=3;
#server 10.81.100.191:5045 weight=1;
  server 10.81.100.193:5045;
  server 127.0.0.1:5045;
# server 10.201.100.101:5045;
}

# tweaking
* https://www.getpagespeed.com/server-setup/nginx/tuning-proxy_buffer_size-in-nginx
* https://www.getpagespeed.com/?s=nginx


* "an upstream response is buffered to a temporary file" https://serverfault.com/questions/587386/an-upstream-response-is-buffered-to-a-temporary-file
