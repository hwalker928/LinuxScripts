if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Command 1 - Downloading binaries"
curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64
echo "Command 2 - Modifying permissions"
chmod u+x /usr/local/bin/wings
echo "Command 3 - Restarting wings"
systemctl restart wings
