INFO='\033[0;36m'
WARN='\033[0;31m'
BRACKETS='\033[0;30m'
info(){
    echo -e "${BRACKETS}[${INFO}INFO${BRACKETS}]${1}";
}
warn(){
    echo -e "${BRACKETS}[${WARN}WARN${BRACKETS}]${1}";
}

info "Please note, this only works for harrydev!"

if [ $(whoami) = 'root' ]; then
    info "Running as root.."
    warn "Make sure the latest panel.tar.gz file is in /var/www/pterodactyl before continuing!"
    read -p "Press enter to continue or CTRL+C to abort"
    export COMPOSER_ALLOW_SUPERUSER=1
    cd /var/www/pterodactyl
    php artisan down
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache
    composer require laravel/socialite
    composer install --no-dev --optimize-autoloader
    php artisan view:clear
    php artisan config:clear
    php artisan migrate --seed --force
    chown -R www-data:www-data /var/www/pterodactyl/*
    php artisan queue:restart
    php artisan up
    rm panel.tar.gz
    info "Update finished."
else
    info "Please run this command as root."
fi
