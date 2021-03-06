output(){
    echo -e '\e[36m'$1'\e[0m';
}

warn(){
    echo -e '\e[31m'$1'\e[0m';
}

if [ "$EUID" -ne 0 ]
  then warn "Please run as root! (sudo su)"
  exit
fi
output "Please reply with exactly what you want to update:"
output "- panel"
output "- wings"
output "- both"
read what_to_update

if [ ${what_to_update} == 'panel' ]; then
  cd /var/www/pterodactyl
  php -v > /tmp/php.ver
  if [ ! grep -q "v7" "php.ver" ]; then
      if [ ! grep -q "v8" "php.ver" ]; then
        warn "You have an unsupported version of PHP."
        exit
      fi
  fi
  
  export COMPOSER_ALLOW_SUPERUSER=1;
  composer --version > /tmp/comp.ver
  if [ ! grep -q "2" "comp.ver" ]; then
    output "Updating composer.."
    composer self-update --2
  fi
  
  php artisan down
  curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
  chmod -R 755 storage/* bootstrap/cache
  composer install --no-dev --optimize-autoloader
  php artisan view:clear
  php artisan config:clear
  php artisan migrate --seed --force
  cd /var/www/pterodactyl && curl -L https://raw.githubusercontent.com/pterodactyl/panel/develop/database/Seeders/eggs/rust/egg-rust.json | cat > /var/www/pterodactyl/database/Seeders/eggs/rust/egg-rust.json
  chown -R www-data:www-data /var/www/pterodactyl/*
  php artisan queue:restart
  php artisan up
  output "Updated panel to v1.3.0!"
  fi
  exit
elif [ ${what_to_update} == 'wings' ]; then
  curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64
  chmod u+x /usr/local/bin/wings
  systemctl restart wings
  output "Updated wings to v1.3.0!"
fi
