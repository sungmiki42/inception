
# Start from a minimal Debian image
FROM debian:bullseye

# # set ARGS (use only on building image)
# ARG ROOT_PASSWORD
# ARG DB_NAME
# ARG DB_USER
# ARG DB_PASSWORD

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y mariadb-server tini vim &&\
    apt-get clean

# Copy custom MariaDB configuration if needed (optional)
# COPY my.cnf /etc/mysql/my.cnf
# COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Expose the default MariaDB port
EXPOSE 3306

# Run initial setup commands
RUN service mariadb start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS wordpress_db;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'sungmiki'@'%' IDENTIFIED BY 'sungmiki';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'sungmiki'@'%';" && \
    mysql -e "FLUSH PRIVILEGES;"

# Set the entrypoint to run MariaDB in the foreground
# ENTRYPOINT [ "/usr/bin/tini", "--", "init-db.sh" ]
CMD ["mysqld", "--bind-address=0.0.0.0"]