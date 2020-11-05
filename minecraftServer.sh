output(){
    echo -e '\e[36m'$1'\e[0m';
}

warn(){
    echo -e '\e[31m'$1'\e[0m';
}

output "Welcome to hwalker928's Minecraft Server Script!"
output "Time to begin!"
output ""
output "What should we call this server?"
warn "Please note: it must be ONE word!"
read servername
output "Making server folder!"
mkdir $servername &> /dev/null
cd $servername
output "Created server folder!"
output "Installing Java!"
apt install openjdk-8-jre-headless -y
output "Java was installed!"

output "Downloading tuinity-paperclip.jar!"
wget https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/artifact/tuinity-paperclip.jar &> /dev/null
output "tuinity-paperclip.jar was downloaded!"

