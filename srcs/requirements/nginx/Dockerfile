FROM debian:buster

RUN apt-get update -y && apt install -y nginx openssl

COPY ./conf/default /etc/nginx/sites-enabled/default

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=RU/ST=Moscow/L=Moscow /O=21 School/OU=medeana/CN=medeana.42.fr/emailAddress=unknown";

EXPOSE 443

RUN chown -R www-data /var/www/

VOLUME [ "/var/www/" ]

CMD ["nginx", "-g", "daemon off;"]