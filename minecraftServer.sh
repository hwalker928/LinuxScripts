output(){
    echo -e '\e[36m'$1'\e[0m';
}

warn(){
    echo -e '\e[31m'$1'\e[0m';
}

output "Welcome to hwalker928's Minecraft Server Script"
output ""
output "What should we call this server?"
warn "Please note: It must be ONE word"
read servername
output "Making server folder"
mkdir $servername &> /dev/null
cd $servername
output "Created server folder"

output "Downloading tuinity-paperclip.jar"
wget https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/artifact/tuinity-paperclip.jar &> /dev/null
output "tuinity-paperclip.jar was downloaded"

output "Updating packages"
sudo apt-get update -y
sudo apt-get upgrade -y
output "Finished upgrading packages"

# added systemctl support and more apt packages