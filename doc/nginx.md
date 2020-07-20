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
