ARG DEBIAN_VERSION
FROM debian:$DEBIAN_VERSION

#update system and install nginx
RUN apt update -y
RUN apt upgrade -y

RUN apt install -y	\
	nginx			\
	openssl

ARG CERTIFICATE
ARG CERTIFICATE_KEY
RUN openssl req -x509 -nodes -out $CERTIFICATE -keyout $CERTIFICATE_KEY -subj "/C=NL/ST=NH/L=Amsterdam/O=Codam/OU=Student/CN=bjacobs.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./tools/script.sh /

EXPOSE 433

ENTRYPOINT ["/script.sh"]
