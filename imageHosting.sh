output(){
    echo -e '\e[36m'$1'\e[0m';
}

warn(){
    echo -e '\e[31m'$1'\e[0m';
}

yum update -y
yum install epel-release -y
yum install nginx -y
yum install firewalld -y
yum -y install bind-utils
systemctl start nginx
systemctl enable nginx
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --reload
output "Please enter your FQDN (img.example.com):"
read domain
output "Resolving DNS..."
SERVER_IP=$(curl -s http://checkip.amazonaws.com)
DOMAIN_RECORD=$(dig +short ${domain})
if [ "${SERVER_IP}" != "${DOMAIN_RECORD}" ]; then
    output ""
    output "The entered domain does not resolve to the primary public IP of this server."
    output "Please make an A record pointing to your server's IP. For example, if you make an A record called 'img' pointing to your server's IP, your FQDN is img.example.com"
    output "If you are using Cloudflare, please disable the orange cloud."
    output "If you do not have a domain, you can get a free one at https://freenom.com"
else
    output "Domain resolved correctly. Good to go..."
fi

bash -c 'cat > /etc/nginx/conf.d/$domain.conf' <<-'EOF'
server {
    listen          80;
    server_name     $domain;
    root            /var/www/$domain/;
    index           index.php index.html;
}
EOF

systemctl reload nginx

output "Would you like to enable SSL? (y/n)"
read ssloption

if [ ${ssloption} == 'y' ]; then
    yum-config-manager --enable cr
    yum install snapd -y
    systemctl enable --now snapd.socket
    ln -s /var/lib/snapd/snap /snap
    snap install core
    snap install core; snap refresh core
    yum remove certbot -y
    snap install --classic certbot
    ln -s /snap/bin/certbot /usr/bin/certbot
    output "Please enter an email address:"
    read emailadd
    certbot certonly --standalone --email "$emailadd" --agree-tos -d "$domain" --non-interactive
    certbot renew --dry-run
    output "Script finished."
else
    output "Script finished."
    exit 0
fi