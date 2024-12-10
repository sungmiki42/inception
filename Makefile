SRC_DIR := ./srcs
REQUIREMENTS_DIR := $(SRC_DIR)/requirements
COMPOSE_FILE := $(SRC_DIR)/docker-compose.yml
SERVICES := mariadb wordpress nginx
TAG := sungmiki
IMAGES := $(addsuffix :$(TAG), $(SERVICES))

# Docker Compose up
up:
	@echo "Starting all services with Docker Compose..."
	docker-compose -f $(COMPOSE_FILE) up -d --build

forward:
	@echo "Starting all services with Docker Compose..."
	docker-compose -f $(COMPOSE_FILE) up --build

# Docker Compose down
down:
	@echo "Stopping all services..."
	docker-compose -f $(COMPOSE_FILE) down

# Docker Compose down and remove volumes, containers and images
clean:
	@echo "Stopping all services and cleaning up..."
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans

clean-img:	
	docker image rm $(IMAGES)

clean-data:
	sudo rm -rf /home/sungmiki/data/mariadb/*
	sudo rm -rf /home/sungmiki/data/wordpress/*

fclean: clean clean-img clean-data

# build every images and run containers
all: up

re: clean clean-img
	make up

# print makefile cmds
help:
	@echo "Makefile targets:"
	@echo "  up            Start all services using Docker Compose"
	@echo "  forward       Start all services using Docker Compose in forward mode"
	@echo "  down          Stop all services"
	@echo "  clean         Stop all services and remove volumes, networks, imgs."
	@echo "  clean-img     Remove Docker images."
	@echo "  clean-data    Remove database and wordpress data"
	@echo "  fclean        Stop all services and remove volumes, networks, imgs and all data."
	@echo "  all           Build all images and start services"
	@echo "  re            Make clean and make clean-img, then make up"
	@echo "  help          Display this help message"
