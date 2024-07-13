FROM debian:bullseye

# Update package list and eventually update packets installed to new version
RUN apt-get update && apt-get upgrade -y

# Install the required packages
RUN apt-get install -y nginx openssl

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate and key
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=IT/ST=FL/L=Florence/O=42/OU=42Firenze/CN=sibrahim.42.fr/UID=sibrahim"

# Copy from local into container
COPY /conf/nginx.conf /etc/nginx/nginx.conf

# Create wordpress directory
RUN mkdir -p /var/www/wordpress

# Change owner of the wordpress directory (www-data -> nginx user default)
RUN chown -R www-data:www-data /var/www/wordpress

# Command to run when the container starts (in background)
CMD ["nginx", "-g", "daemon off;"]
