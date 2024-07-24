
mkdir -p /data/mysql/mysql-data

service mariadb start >> /data/mysql/log.txt

if [ $? -ne 0 ]; then
	echo "MariaDB is not running." >> /data/mysql/log.txt
	rm -rf /data/mysql/*
	exit 1
fi

# if [ cat /data/mysql/log.txt | grep -q "ERROR" ]; then
# 	echo "MariaDB is not running." >> /data/mysql/log.txt
# fi

if ! mysql -u"root" -p"$DB_PASSWORD" -e "SHOW DATABASES;" | grep -q "wordpress"; then


	
	echo "MariaDB create Data" >> /data/mysql/log.txt

	mysql -u root -p$DB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';"
	mysql -u root -p$DB_ROOT_PASSWORD -e 'CREATE DATABASE IF NOT EXISTS '$DB_NAME' CHARACTER SET utf8 COLLATE utf8_general_ci;'
	mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -p$DB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
	mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

	mysqladmin -u root -p6071 shutdown


	mysqld_safe

else
	mysqladmin -u root -p6071 shutdown
  	echo "MariaDB is running." >> /data/mysql/log.txt
	mysqld_safe
fi