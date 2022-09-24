FROM debian:buster

RUN apt update
RUN apt install -y mariadb-server

RUN sed -i 's/^bind-address/#&/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i "s/#port/port/"      /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools /var/www/

EXPOSE 3306

RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

CMD /usr/bin/mysqld_safe