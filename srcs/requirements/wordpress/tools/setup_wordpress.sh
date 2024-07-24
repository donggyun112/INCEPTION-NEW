#!bin/bash


until mysql -h"mariadb" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" | grep -q "wordpress"; do
  echo "Waiting for WordPress database creation..." > /var/www/html/wordpress/error/log.txt
  sleep 3
done

echo "connect to WordPress database" >> /var/www/html/wordpress/error/log.txt

sleep 3

if [ ! -f /var/www/html/wordpress/wp-config.php ] || ! mysql -h"mariadb" -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "SHOW TABLES;" | grep -q -E "(wp_posts|wp_users|wp_options)"; then
	echo "Create wordpress Data" >> /var/www/html/wordpress/error/log.txt
	cd /var/www/html/wordpress && \
	sudo -u www-data wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --path=/var/www/html/wordpress --skip-check >> /var/www/html/wordpress/error/log.txt
	cd /var/www/html/wordpress && \
	sudo -u www-data -s wp core install --url=$WORDPRESS_URL --title="My WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --locale=ko_KR >> /var/www/html/wordpress/error/log.txt
	cd /var/www/html/WordPress && \
	sudo -u www-data -s wp user create $WORDPRESS_USER dongkseo@example.com --user_pass=$WORDPRESS_USER_PASSWORD >> /var/www/html/wordpress/error/log.txt
fi

mkdir -p /var/www/html/wordpress/error

# WordPress 구성 파일 경로
WP_CONFIG_FILE="/var/www/html/wordpress/wp-config.php"

# 환경 변수 확인 함수
check_env_variable() {
  local var_name=$1
  local expected_value=$2
  local name=$3

  if [ -z $var_name ]; then
    echo "Error: Environment variable $name is not set." >> /var/www/html/wordpress/error/log.txt
	echo "Delete wp-config.php" >> /var/www/html/wordpress/error/log.txt
    rm -rf /var/www/html/wordpress/wp-config.php
    exit 1
  fi

  if [ "$var_name" != "$expected_value" ]; then
    echo "Error: Environment variable $name has a different value than expected." >> /var/www/html/wordpress/error/log.txt
	echo "Delete wp-config.php" >> /var/www/html/wordpress/error/log.txt
    rm -rf /var/www/html/wordpress/wp-config.php
    exit 1
  fi

  echo "Environment variable $name matches the expected value." >> /var/www/html/wordpress/error/log.txt
}

# WordPress 구성 파일에서 값 추출
db_name_value=$(grep -oP "define\(\s*'DB_NAME',\s*'\K[^']*" "$WP_CONFIG_FILE")
db_user_value=$(grep -oP "define\(\s*'DB_USER',\s*'\K[^']*" "$WP_CONFIG_FILE")
db_password_value=$(grep -oP "define\(\s*'DB_PASSWORD',\s*'\K[^']*" "$WP_CONFIG_FILE")
db_host_value=$(grep -oP "define\(\s*'DB_HOST',\s*'\K[^']*" "$WP_CONFIG_FILE")

# 환경 변수 확인
check_env_variable "$DB_NAME" "$db_name_value" "DB_NAME"
check_env_variable "$DB_USER" "$db_user_value" "DB_USER"
check_env_variable "$DB_PASSWORD" "$db_password_value" "DB_PASSWORD"
check_env_variable "mariadb" "$db_host_value" "DB_HOST"

echo "All environment variables match the WordPress configuration." >> /var/www/html/wordpress/error/log.txt

php-fpm7.4 -F
