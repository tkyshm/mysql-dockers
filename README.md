# 手元でmysqlのmaster slave環境（docker）
## 目的
手元でデータベースのalterなどのレプリケーション等動作を確認するためのもの.

## 前準備
- dockerのインストール
- 初期sqlデータ

## QuickStart

```
$ mkdir sqls
$ cp /path/to/your_sqls sqls
$ build_docker.sh
$ ./docker-mysql start
$ ./docker-mysql slave1 "show slave status\G"
$ ./docker-mysql master "show master status\G"
```

## docker-mysql

- 接続
```
# slave1に接続
$ ./docker-mysql slave1

# masterに接続
$ ./docker-mysql master
```

- コマンド
```
$ ./docker-mysql slave1 "show databases"
```

- alter
```
$ ./docker-mysql alter master /path/to/sql
```

- 停止
```
$ ./docker-mysql stop
```
