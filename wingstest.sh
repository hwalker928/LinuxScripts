output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ $(wings version) =~ "v1.4.1" ]; then
    output "Latest wings"
else
    output "Please run this command as root."
fi
