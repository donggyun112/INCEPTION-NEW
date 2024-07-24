all:
	make up

build:
	docker-compose build -f ./srcs/docker-compose.yml

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose down -f ./srcs/docker-compose.yml

clean:
	docker-compose -f ./srcs/docker-compose.yml down
	docker volume rm $$(docker volume ls -q) || true

fclean:
	docker-compose -f ./srcs/docker-compose.yml down
	docker volume rm $$(docker volume ls -q) || true
	docker image rm $$(docker images -aq) || true

re:
	make fclean
	make all

.PHONY : all build up down clean fclean re


