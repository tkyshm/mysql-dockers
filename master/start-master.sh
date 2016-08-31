#!/bin/bash
set -ue

work_dir=$(readlink -f $(dirname $0))
master_host=127.0.0.1

cd $work_dir

docker run --name mysql-master -e MYSQL_ALLOW_EMPTY_PASSWORD=true -p 13306:3306 -d mysql-master:0.1
sleep 10

# master setup
mysql -u root -h 127.0.0.1 -P 13306 -e "GRANT REPLICATION SLAVE ON *.* TO 'repli'@'172.17.0.%' IDENTIFIED BY 'repli';"
mysql -u root -h 127.0.0.1 -P 13306 -e "flush privileges;"


