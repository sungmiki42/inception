# Start from a minimal Debian image
FROM debian:bullseye

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y  php7.4-fpm \
                        php7.4-mysql \
                        # mariadb-client \
                        curl \
                        unzip \
                        tini \
                        wget \
                        vim \
                        openssl && \
    apt-get clean 
    # && rm -rf /var/lib/apt/lists/*

# COPY wp-config.php
COPY ./conf/wp-config.php /tmp/wp-config.php
RUN chown -R www-data:www-data /tmp/wp-config.php
# COPY www.conf
COPY ./conf/www.conf /tmp/pool.d/www.conf
# COPY init-wp.sh
COPY ./tools/init-wp.sh /usr/local/bin/init-wp.sh
RUN chmod +x /usr/local/bin/init-wp.sh

# Expose the default php-fpm port
EXPOSE 9000

# Run initial setup commands
# RUN cd /tmp && \
#     wget https://wordpress.org/latest.tar.gz &&\
#     tar -xvf latest.tar.gz && \
#     cp -r wordpress/* /var/www/html/ && \
#     chown -R www-data:www-data /var/www/html/ && \
#     chmod -R 755 /var/www/html/ && \
#     mkdir /run/php

# Entrypoint setting
ENTRYPOINT [ "/usr/bin/tini", "--", "init-wp.sh" ]
CMD ["php-fpm7.4", "-F"]

