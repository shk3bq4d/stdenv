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
