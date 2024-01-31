#!/bin/bash

# Wait for MariaDB to be ready
until mysqladmin ping -h $DB_HOST --silent; do
	echo "Waiting for MariaDB to be ready...";
	sleep 1
done

# Create folder for wordpress files and cd into it
mkdir -p /var/www/html/wordpress
cd /var/www/html/wordpress

# Check if wordpress is already configured, if not configure it
if [ -f "/var/www/html/wordpress/wp-config.php" ]
then
	echo "WARNING: wordpress already configured";
else
	# Download wordpress files
	wp --allow-root core download
	# Create wp-config.php, the file that contains the wordpress configuration
	wp --allow-root config create --force --config-file=./wp-config.php --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST
	# Create the wordpress website and setup the admin user
	wp --allow-root core install --url=$DOMAIN --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email
	# Create a user for the website
	wp --allow-root user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD
fi

# Run the command passed as argument
exec $@