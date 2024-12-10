# Start from a minimal Debian image
FROM debian:bullseye

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y mariadb-server tini vim &&\
    apt-get clean

# Copy init-db.sh to image and change mod
COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Set the entrypoint to run MariaDB in the foreground
ENTRYPOINT [ "/usr/bin/tini", "--", "init-db.sh" ]
CMD ["mysqld", "--bind-address=0.0.0.0"]
