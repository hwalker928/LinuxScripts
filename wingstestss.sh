output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [[ $(wings version) =~ $(curl -s https://cdn.pterodactyl.io/releases/latest.json | jq -r '.wings') ]]; then
    output "Latest wings"
else
    curl -s https://cdn.pterodactyl.io/releases/latest.json | jq -r '.wings'
fi
