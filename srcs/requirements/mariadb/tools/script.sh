#!/bin/bash

mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

if ! [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	mysqld --skip-networking &
	MYSQL_PID=$!

	while ! mysqladmin ping -h localhost --silent; do
		sleep 1
		echo "Waiting.."
	done

	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > ./db1.sql
	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> ./db1.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> ./db1.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> ./db1.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> ./db1.sql
	echo "FLUSH PRIVILEGES;" >> ./db1.sql

	echo "Setting up mariadb..."
	mysql -u root -p$MYSQL_ROOT_PASSWORD < ./db1.sql
	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
	rm ./db1.sql
	wait $MYSQL_PID
fi

echo "Starting mariadb!"
exec mysqld
