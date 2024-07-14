FROM debian:bullseye

# Update package list and eventually update packets installed to new version
RUN apt-get update && apt-get upgrade -y

# Install the required packages
RUN apt-get install -y mariadb-server

# Copy mariadb script from local to container dir
COPY /conf/maria-setup.sh /maria-setup.sh

# Give exec permissions to script
RUN chmod +x /maria-setup.sh

ENTRYPOINT ["./maria-setup.sh"]
