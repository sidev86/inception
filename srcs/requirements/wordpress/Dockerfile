FROM debian:bullseye

# Update package list and eventually update packets installed to new version
RUN apt-get update && apt-get upgrade -y

# Install the required packages
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client iputils-ping

# Copy wordpress script from local to container dir
COPY /conf/wp-setup.sh /

# Give exec permissions to script
RUN  chmod +x wp-setup.sh

# Command to execute when container starts
ENTRYPOINT ["./wp-setup.sh"]
