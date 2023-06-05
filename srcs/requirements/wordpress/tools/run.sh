#!/bin/bash

wp-cli --allow-root core download;
wp-cli --allow-root config create --dbname=wordpress_db --dbuser=$MYSQL_USER_DB --dbpass=$MYSQL_USER_DB_PASSWORD --locale=en_DB --dbhost=mariadb;
wp-cli --allow-root core install --url=$DOMAIN_NAME --title=Hello_42 --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN@hotmail.com;
service php7.3-fpm start
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
chown -R www-data:www-data .
if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi
/usr/sbin/php-fpm7.3 -F -R

