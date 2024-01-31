#!/bin/sh

# Create MariaDB data directory
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

# Initialize MariaDB data directory
mysql_install_db --user=mysql --datadir=/var/lib/mysql/

# Start MariaDB service in the background for the setup
mysqld --user=mysql &

# Wait until MariaDB is up
until mysqladmin ping >/dev/null 2>&1; do
    echo -n "."; sleep 1
done

# Create WordPress database and user, then grant all privileges on the database to the user
if ! mysql -u root -e "USE $DB_NAME" > /dev/null 2>&1;
then
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    mysql -u root -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"
    echo "Database '$DB_NAME' created with user '$DB_USER' (password: '$DB_PASSWORD')"
else
    echo "WARNING: Database '$DB_NAME' already exists"
fi

# Stop MariaDB
mysqladmin -u root shutdown

# Execute any command provided to the script
exec "$@"
