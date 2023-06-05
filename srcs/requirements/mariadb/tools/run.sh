#!/bin/sh

service mysql restart;

cat > mysql_secure_installation.sql << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF
mysql -uroot -p$MYSQL_ROOT_PASSWORD << EOF
CREATE DATABASE wordpress_db;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER'@'%';
CREATE USER '$MYSQL_USER_DB'@'%' IDENTIFIED BY '$MYSQL_USER_DB_PASSWORD';
GRANT ALL PRIVILEGES ON  wordpress_db. * TO '$MYSQL_USER_DB'@'%';
FLUSH PRIVILEGES;
EOF

rm -rf ./conf;
rm -rf ./run.sh;
