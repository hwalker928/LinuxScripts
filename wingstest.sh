output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ $(wings version) = 'wings v1.4.1\nCopyright © 2018 - 2021 Dane Everitt & Contributors' ]; then
    output "Latest wings"
else
    output "Please run this command as root."
fi
