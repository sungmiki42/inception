#!/bin/bash

# 쉘 스크립트 실행 시 에러 발생 시 종료
set -e

# MariaDB 서비스를 시작
service mariadb start

# MariaDB 초기화 명령 실행
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

echo "MariaDB initialization completed successfully."

# MariaDB 서비스 중단
service mariadb stop

exec "$@"
