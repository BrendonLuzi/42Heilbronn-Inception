FROM alpine:3.18

# Install nginx and openssl
RUN apk update && apk add nginx openssl

# Create directory for certificates 
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate
RUN openssl req -new -newkey rsa:2048 -x509 -nodes -days 365 \
	-subj "/C=DE/ST=BW/L=HN/O=42Heilbronn/OU=student/CN=bluzi.42.fr" \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

# Copy nginx config file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

# Start nginx on the foreground
CMD ["nginx", "-g", "daemon off;"]
