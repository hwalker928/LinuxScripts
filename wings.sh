output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ $(whoami) = 'root' ]; then
    output "Running as root.."
    output "Checking if latest wings.."
    if [[ $(wings version) =~ $(curl -s https://cdn.pterodactyl.io/releases/latest.json | jq -r '.wings') ]]; then
        output "Already latest."
    else
        output "Downloading new wings.."
        curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64 > /dev/null 2>&1
        output "Applying permissions.."
        chmod u+x /usr/local/bin/wings > /dev/null 2>&1
        output "Restarting wings.."
        systemctl restart wings > /dev/null 2>&1
        output "Updated to latest wings!"
        if [[ $(wings version) =~ $(curl -s https://cdn.pterodactyl.io/releases/latest.json | jq -r '.wings') ]]; then
            output "Version check successful."
        else
            output "Version check failed."
            output "Try manually updating."
        fi
    fi
else
    output "Please run this command as root."
fi
