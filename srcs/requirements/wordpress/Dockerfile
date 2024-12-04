# Start from a minimal Debian image
FROM debian:bullseye

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y  wordpress \
                        php7.4-fpm \
                        php7.4-mysql \
                        mariadb-client \
                        curl \
                        unzip \
                        wget && \
    apt-get clean 
    # && rm -rf /var/lib/apt/lists/*

# Copy custom WordPress configuration if needed (optional)
COPY wp-config.php /var/www/html/wp-config.php
# COPY dir.conf /etc/apache2/mods-available/dir.conf
COPY www.conf /etc/php/7.4/fpm/pool.d

# Expose the default php-fpm port
EXPOSE 9000

# Run initial setup commands
RUN cd /tmp && \
    wget https://wordpress.org/latest.tar.gz &&\
    tar -xvf latest.tar.gz && \
    cp -r wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/ && \
    mkdir /run/php

# PHP-FPM 실행
CMD ["php-fpm7.4", "-F"]

