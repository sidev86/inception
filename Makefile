# Data paths
WP_DATA = /home/sibrahim/data/wordpress
DB_DATA = /home/sibrahim/data/mariadb 

all: up

# Build and run containers in background (detach mode)
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

# Stop and remove containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# Stop containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# Start containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# Build containers
build:
	docker-compose -f ./srcs/docker-compose.yml build


# Stop and remove all running containers
# Remove all associated images, volumes, networks
# Remove mariadb and wordpress directories
# (|| true) -> ignore command error if it doesn't find a running container
clean:
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true	

# Clean + start container -> Restart containers
re: clean up

# Full clean
prune: clean
	@docker system prune -a --volumes -f
