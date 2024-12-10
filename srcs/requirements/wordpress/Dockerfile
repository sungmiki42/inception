# Start from a minimal Debian image
FROM debian:bullseye

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y  php-fpm php-mysql php curl unzip tini wget vim openssl && \
    apt-get clean

# Copy conf file and init-wp.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/init-wp.sh /usr/local/bin/init-wp.sh
RUN chmod +x /usr/local/bin/init-wp.sh

# Make directory
RUN mkdir -p /var/www/html && \
    chmod -R 755 /var/www/html/

# Run download wordpress initial pages
RUN cd /tmp && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xvf latest.tar.gz && \
    cp -r wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/

# wp-cli inistall
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Make directory
RUN mkdir /run/php && \
    chown -R www-data:www-data /run/php

# Entrypoint setting
ENTRYPOINT [ "/usr/bin/tini", "--", "init-wp.sh" ]
CMD ["php-fpm7.4", "-F"]

