
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
    apt-get install -y mariadb-server mariadb-client && \
    apt-get clean

# Copy custom MariaDB configuration if needed (optional)
# COPY my.cnf /etc/mysql/my.cnf
# COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Expose the default MariaDB port
EXPOSE 3306

# Run initial setup commands
# RUN service mariadb start && \
#     mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" && \
#     mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" && \
#     mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" && \
#     mysql -e "FLUSH PRIVILEGES;"

# Set the entrypoint to run MariaDB in the foreground
ENTRYPOINT [ "/usr/bin/dumb-init", "--", "init-db.sh" ]
CMD ["mysqld", "--bind-address=0.0.0.0"]
