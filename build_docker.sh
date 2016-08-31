#!/bin/bash
set -ue
work_dir=$(readlink -f $(dirname $0))

# masterのdockerイメージ作成
cd master
docker build -t mysql-master .

cd $work_dir
# slave1のdockerイメージ作成
cd slave1
docker build -t mysql-slave1 .

cd $work_dir
