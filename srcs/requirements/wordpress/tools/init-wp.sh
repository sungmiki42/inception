#!/bin/bash

# WordPress 설치 여부 확인
if [ ! -f /var/www/html/index.php ]; then
    echo "WordPress가 설치되어 있지 않습니다. 설치를 시작합니다."

    # 1. /tmp 디렉토리로 이동
    cd /tmp

    # 2. WordPress 최신 버전 다운로드
    wget https://wordpress.org/latest.tar.gz

    # 3. 다운로드한 tar 파일을 추출
    tar -xvf latest.tar.gz

    # 4. 추출한 WordPress 파일을 /var/www/html/로 복사
    cp -r wordpress/* /var/www/html/

    cp /tmp/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf
    # mv /tmp/wp-config.php /var/www/html/wp-config.php
    
    # 5. /var/www/html/의 소유자와 그룹을 www-data로 변경
    chown -R www-data:www-data /var/www/html/

    # 6. /var/www/html/의 권한을 755로 설정
    chmod -R 755 /var/www/html/

    echo "WordPress 설치가 완료되었습니다."
else
    echo "WordPress가 이미 설치되어 있습니다. 설치를 건너뜁니다."
fi

# 7. PHP 런타임에 필요한 디렉토리 생성
mkdir -p /run/php

# 전달받은 명령어 실행
exec "$@"
