#!/bin/bash

mysql_cmd="mysql -u root -h 127.0.0.1 -p 13316 -e"

docker run --name mysql-slave1 -e MYSQL_ALLOW_EMPTY_PASSWORD=true -p 13316:3306 -d mysql-slave1:0.1
sleep 10

mysql -u root -h 127.0.0.1 -P 13316 -e "GRANT REPLICATION SLAVE ON *.* TO 'repli'@'172.17.0.%' IDENTIFIED BY 'repli';"
mysql -u root -h 127.0.0.1 -P 13316 -e "flush privileges;"

# slaveでのmaster設定
master_port=13306
file=$(mysql -u root -h 127.0.0.1 -P $master_port -e "show master status\G" | grep File | awk '{print $2}')
position=$(mysql -u root -h 127.0.0.1 -P $master_port -e "show master status\G" | grep Position | awk '{print $2}')
master_host=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql-master`

mysql -u root -h 127.0.0.1 -P 13316 -e "CHANGE MASTER TO MASTER_HOST='$master_host', MASTER_USER='repli', MASTER_PASSWORD='repli', MASTER_LOG_FILE='$file', MASTER_LOG_POS=$position;"
mysql -u root -h 127.0.0.1 -P 13316 -e "start slave"
