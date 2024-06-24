ARG DEBIAN_VERSION
FROM debian:$DEBIAN_VERSION

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y	\
	php7.4			\
	php7.4-fpm		\
	php7.4-mysqli	\
	php7.4-json		\
	php7.4-xml		\
	php7.4-curl		\
	php7.4-mbstring	\
	mariadb-client	\
	curl

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY ./tools/script.sh /
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www/wordpress
ENTRYPOINT ["/script.sh"]
