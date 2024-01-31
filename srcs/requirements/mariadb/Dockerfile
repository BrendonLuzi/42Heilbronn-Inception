FROM alpine:3.18

# Install mariadb
RUN apk update && apk add mariadb mariadb-client

# Copy mariadb config file
COPY ./conf/maria.cnf /etc/my.cnf

# Copy mariadb setup script and make it executable
COPY ./tools/setup_db.sh /setup_db.sh
RUN chmod +x /setup_db.sh

# Expose port 3306
EXPOSE 3306

# Run mariadb setup script and then start mariadb in the foreground
ENTRYPOINT [ "./setup_db.sh", "mysqld_safe" ]
