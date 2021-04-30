output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ $(whoami) = 'root' ]; then
    output "Running as root.."
    output "Enter domain to generate SSL certificate for:"
    read domain
    systemctl stop nginx
    certbot certonly --standalone -d ${domain}
    systemctl start nginx
    output "Finished script."
else
    output "Please run this command as root."
fi
