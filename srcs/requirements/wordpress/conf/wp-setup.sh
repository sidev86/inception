#!/bin/bash

# wp-cli installation (wordpress commands)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/wordpress

# Give permissions (-R -> all files in directory)
chmod -R 755 /var/www/wordpress/
# Change owner of wordpress directory to www-data (default user name and group nginx)
chown -R www-data:www-data /var/www/wordpress


# WORDPRESS INSTALLATION

wp core download --allow-root
# Create wp-config.php file with database settings
wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --allow-root
# Install wordpress with custom settings
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_MAIL" --allow-root
# Create User
wp user create "$WP_USER_NAME" "$WP_USER_MAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE" --allow-root


# PHP SETTINGS

# Change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# Create php-fpm directory
mkdir -p /run/php
# Start php-fpm in foreground
/usr/sbin/php-fpm7.4 -F
