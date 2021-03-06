if [ "$EUID" -ne 0 ]
  then echo "Please run as root (sudo su)"
  exit
fi
curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64 >> /tmp/wings.log
chmod u+x /usr/local/bin/wings >> /tmp/wings.log
systemctl restart wings >> /tmp/wings.log
echo "Updated wings to v1.3.0"
