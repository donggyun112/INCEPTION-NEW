#!/bin/bash

# Prepare directories and permissions


mkdir -p /home/mysql/log/binary/mysql-bin
mkdir -p /home/mysql/log/error/error.log
mkdir -p /home/mysql/log/relay/relay-log
mkdir -p /home/mysql/log/slow/slow.log
mkdir -p /home/mysql/log/general/mysql_general.log
mkdir -p /home/mysql/tmpdir
chown -R mysql:mysql /home/mysql

mkdir -p /data/mysql/mysql-data
chown -R mysql:mysql /data/mysql
chmod 700 /data/mysql/mysql-data

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chmod 755  /run/mysqld

cp -R /var/lib/mysql/* /data/mysql/mysql-data/
chown -R mysql:mysql /data/mysql



# chown -R www-data:www-data /var/www/html/wordpress/

sed -i 's/^\(syslog\)/#\1/' /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf


# cp /var/www/wordpress/wp-config-sample.php  /var/www/wordpress/wp-config.php
# sed -i "s/database_name_here/wordpress/" /var/www/wordpress/wp-config.php
# sed -i "s/username_here/wordpress/" /var/www/wordpress/wp-config.php
# sed -i "s/password_here/wordpress/" /var/www/wordpress/wp-config.php
# sed -i "s/localhost/localhost/" /var/www/wordpress/wp-config.php

# Start MariaDB
# mysqld_safe &
service php7.4-fpm start
service mariadb start

sleep 1
mysql -u root -p6071 -e "source /init.sql"
# sudo usermod -s /bin/bash www-data
cd /var/www/html/wordpress && sudo -u www-data -s wp core install --url="https://dongkseo.42.fr:8000" --title="My WordPress Site" --admin_user="admin" --admin_password="admin" --admin_email="ssddgg99@daum.net" --locale=ko_KR
cd /var/www/html/wordpress && sudo -u www-data -s wp user create dongkseo dongkseo@example.com --user_pass=password --path="/var/www/html/wordpress"


# Start Nginx
nginx -g 'daemon off;'