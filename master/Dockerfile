# Docker mysql
FROM mysql:5.5
MAINTAINER tkyshm

ADD my-master.cnf /etc/mysql/conf.d
RUN mkdir -p /var/log/mysql
RUN touch /var/log/mysql/mysql-bin.log
RUN chown -R mysql:mysql /var/log/mysql

EXPOSE 3306
CMD ["mysqld"]
