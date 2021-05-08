output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please note, this only works for harrydev!"

if [ $(whoami) = 'root' ]; then
    output "Running as root.."
    echo "Make sure the latest panel.tar.gz file is in /var/www/pterodactyl before continuing!"
    read -p "Press enter to continue or CTRL+C to abort"
    cd /var/www/pterodactyl
    php artisan down
    tar -xzvf panel.tar.gz
    read -p "Press enter to continue or CTRL+C to abort"
    chmod -R 755 storage/* bootstrap/cache
    read -p "Press enter to continue or CTRL+C to abort"
    composer require laravel/socialite
    read -p "Press enter to continue or CTRL+C to abort"
    composer install --no-dev --optimize-autoloader
    read -p "Press enter to continue or CTRL+C to abort"
    php artisan view:clear
    php artisan config:clear
    read -p "Press enter to continue or CTRL+C to abort"
    php artisan migrate --seed --force
    read -p "Press enter to continue or CTRL+C to abort"
    chown -R www-data:www-data /var/www/pterodactyl/*
    php artisan queue:restart
    php artisan up
    output "Update finished."
else
    output "Please run this command as root."
fi
