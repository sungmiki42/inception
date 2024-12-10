#!/bin/bash

set -e

# `wp-config.php`가 없으면 설치 진행
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "wp-config.php being created..."

    # 데이터베이스 연결 설정
    cp -p /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/username_here/$WORDPRESS_DB_USER/g" /var/www/html/wp-config.php
    sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config.php
    sed -i "s/localhost/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php
    sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
    
    echo "wp-config.php is created successfully."
else
    echo "wp-config.php is already created." 
fi

# wordpress 가 없으면 설치 진행
if ! wp core is-installed --path="/var/www/html" --allow-root; then
    echo "WordPress not installed. Setting up..."

    #wordpress 설치 
    wp core install \
        --url="https://localhost" \
        --title=${WORDPRESS_SITE_TITLE} \
        --admin_user=${WORDPRESS_ADMIN_USER} \
        --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
        --admin_email=${WORDPRESS_ADMIN_EMAIL} \
        --path="/var/www/html" \
        --allow-root
    #wordpress user 생성
    wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
					--user_pass=$WORDPRESS_PASSWORD \
                    --path="/var/www/html" \
					--allow-root

    echo "WordPress installed successfully."
else
    echo "WordPress already installed." 
fi


# exec CMD
exec "$@"