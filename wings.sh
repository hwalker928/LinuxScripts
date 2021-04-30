output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ $(whoami) = 'root' ]; then
    output "Running as root.."
    output "Downloading new wings.."
    curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64 > /dev/null 2>&1
    output "Applying permissions.."
    chmod u+x /usr/local/bin/wings > /dev/null 2>&1
    output "Restarting wings.."
    systemctl restart wings > /dev/null 2>&1
    output "Done!"
else
	output "Please run this command as root."
fi


