SRC_DIR := ./srcs
REQUIREMENTS_DIR := $(SRC_DIR)/requirements
COMPOSE_FILE := $(SRC_DIR)/docker-compose.yml
SERVICES := mariadb wordpress nginx
IMAGES := $(addsuffix _img, $(SERVICES))

# build each image
# build-%:
# 	@echo "Building image for service: $*"
# 	docker build -t $* $(REQUIREMENTS_DIR)/$*

# # build every images
# build: $(SERVICES:%=build-%)
# 	@echo "All images built successfully."

# Docker Compose up
up:
	@echo "Starting all services with Docker Compose..."
	docker-compose -f $(COMPOSE_FILE) up -d

# Docker Compose down
down:
	@echo "Stopping all services..."
	docker-compose -f $(COMPOSE_FILE) down

# Docker Compose down and remove volumes, containers and images
clean:
	@echo "Stopping all services and cleaning up..."
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker image rm $(IMAGES) 

# build every images and run containers
all: up

# print makefile cmds
help:
	@echo "Makefile targets:"
	@echo "  build         Build Docker images for all services"
	@echo "  build-<name>  Build Docker image for a specific service (e.g., make build-mariadb)"
	@echo "  up            Start all services using Docker Compose"
	@echo "  down          Stop all services"
	@echo "  clean         Stop all services and remove volumes, networks, etc."
	@echo "  all           Build all images and start services"
	@echo "  help          Display this help message"
