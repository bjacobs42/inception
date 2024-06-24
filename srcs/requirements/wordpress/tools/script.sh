#!/bin/bash

until mariadb -h mariadb -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"; do
	echo Waiting...
	sleep 2;
done 2>/dev/null

rm -rf ./*

if ! [ -f "./wp-config.php" ]; then
	wp core download --allow-root

	wp config create						\
		--dbname=$MYSQL_DATABASE			\
		--dbuser=$MYSQL_USER				\
		--dbpass=$MYSQL_PASSWORD			\
		--dbhost=mariadb:3306				\
		--allow-root

	wp core install							\
		--url=$DOMAIN_NAME					\
		--title=insception					\
		--admin_user=$WP_ADMIN_USER			\
		--admin_password=$WP_ADMIN_PASSWORD	\
		--admin_email=$WP_ADMIN_EMAIL		\
		--skip-email						\
		--allow-root

	wp user create							\
		$WP_USER							\
		$WP_USER_EMAIL						\
		--role=author						\
		--user_pass=$WP_USER_PASSWORD		\
		--allow-root

	mkdir -p /run/php
fi

echo "Starting php!"
/usr/sbin/php-fpm7.4 -F
