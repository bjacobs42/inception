ARG DEBIAN_VERSION
FROM debian:$DEBIAN_VERSION

RUN apt update -y
RUN apt upgrade -y

RUN apt install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh /

CMD ["/script.sh"]
