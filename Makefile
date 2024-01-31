.SILENT:

COMPOSE_FILE = ./srcs/docker-compose.yml

DB_VOLUME = /home/bluzi/data/mariadb
WP_VOLUME = /home/bluzi/data/wordpress

all: run

run: mkdir-volume up

up:
	docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	docker-compose -f $(COMPOSE_FILE) down

mkdir-volume:
	mkdir -p $(DB_VOLUME)
	mkdir -p $(WP_VOLUME)

rm-volume:
	sudo rm -rf $(DB_VOLUME)
	sudo rm -rf $(WP_VOLUME)

prune:
	docker container prune --force
	docker image prune -a --force
	docker volume prune --force

fclean: down prune rm-volume

re: fclean run
	
.PHONY: all run rm-volume prune fclean re up down