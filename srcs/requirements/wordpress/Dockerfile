FROM alpine:3.18

# Expose port 9000
EXPOSE 9000

# Install packages for wordpress and php-fpm
RUN apk update \
	&& apk add wget \
	php82 \
	php82-fpm \
	php82-phar \
	php82-mysqli \
	php82-mbstring \
	mariadb-client \
	bash

# Create directory for wordpress
RUN mkdir -p /var/www/html/wordpress

# Download wordpress
RUN cd /usr/local/bin/ \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& mv wp-cli.phar wp \
	&& mv /usr/bin/php82 /usr/bin/php \
	&& chmod +x wp \
	&& mkdir -p /run/php

# Copy script to configure wordpress and make it executable
COPY ./tools/wp-config.sh /wp-config.sh
RUN chmod +x /wp-config.sh

# Modify php-fpm config file to listen on port 9000
RUN sed -i 's/listen = .*/listen = wordpress:9000/' /etc/php82/php-fpm.d/www.conf

# Run script to configure wordpress and start php-fpm
ENTRYPOINT [ "/wp-config.sh", "/usr/sbin/php-fpm82", "-F"  ]
