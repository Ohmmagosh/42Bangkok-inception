#!/bin/sh

service mysql restart;

cat > mysql_secure_installation.sql << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '1234';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF
mysql -uroot -p1234 << EOF
CREATE DATABASE wordpress_db;
CREATE USER 'hello'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON * . * TO 'hello'@'%';
CREATE USER 'hello2'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON  wordpress_db. * TO 'hello2'@'%';
FLUSH PRIVILEGES;
EOF

rm -rf ./conf;
rm -rf ./run.sh;
