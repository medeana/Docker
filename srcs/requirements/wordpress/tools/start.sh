#!/bin/bash

chmod -R 775 /var/www/html/wordpress;

chown -R www-data /var/www/html/wordpress;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;


if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;

chmod +x wp-cli.phar;

mv wp-cli.phar /usr/local/bin/wp;
cd /var/www/html/wordpress;

	mkdir -p /var/www/html/wordpress/mysite;
    mv /var/www/index.html /var/www/html/wordpress/mysite/index.html;

wp core download --allow-root;

mv /var/www/wp-config.php /var/www/html/wordpress;

wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};

wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;

wp theme install zeever --activate --allow-root

fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7.3 -F