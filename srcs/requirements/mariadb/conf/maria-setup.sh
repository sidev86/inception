#!/bin/bash

service mariadb start

# Wait for mariadb to start
sleep 5 

# MARIADB CONFIGURATION
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO \`${DB_USER}\`@'%';"

# Update users permissions
mariadb -e "FLUSH PRIVILEGES;"


# Shutdown mariadb
mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

# Restart mariadb with new config in background and keep container running
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
