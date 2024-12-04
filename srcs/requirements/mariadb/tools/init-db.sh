#!/bin/bash

# 쉘 스크립트 실행 시 에러 발생 시 종료
set -e

# 환경 변수 확인 및 기본값 설정 (필요에 따라 수정 가능)
DB_NAME=${MYSQL_DATABASE:-"default_db"}
DB_USER=${MYSQL_USER:-"default_user"}
DB_PASSWORD=${MYSQL_PASSWORD:-"default_password"}

# MariaDB 서비스를 시작 (Debian에서 사용되는 명령)
service mariadb start

# MariaDB 초기화 명령 실행
echo "Initializing MariaDB with the following details:"
echo "Database Name: $DB_NAME"
echo "User: $DB_USER"
echo "Password: $DB_PASSWORD"

mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -uroot -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
mysql -uroot -e "FLUSH PRIVILEGES;"

echo "MariaDB initialization completed successfully."

# MariaDB 서비스 중단 (컨테이너 실행 중이라면 제외 가능)
service mariadb stop

exec "$@"
