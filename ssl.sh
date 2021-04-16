echo "enter domain"
read domain
systemctl stop nginx
certbot certonly --standalone -d ${domain}
systemctl start nginx
