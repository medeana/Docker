all:	up

up:
		@mkdir -p /home/${USER}/data/db
		@mkdir -p /home/${USER}/data/wp
		@docker-compose -f srcs/docker-compose.yml up -d

down:
		@docker-compose -f srcs/docker-compose.yml down

ps:
		@docker-compose -f srcs/docker-compose.yml ps

dblogs:
		@docker logs mariadb

nginxlogs:
		@docker logs nginx

wplogs:
		@docker logs wordpress

fclean:	down
		@docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker system prune -a --force
		sudo rm -Rf /home/${USER}/data/db
		sudo rm -Rf /home/${USER}/data/wp
		mkdir /home/${USER}/data/db
		mkdir /home/${USER}/data/wp

re:
		@mkdir -p ../data/wp
		@mkdir -p ../data/db
		@docker-compose -f srcs/docker-compose.yml build
		docker-compose -f srcs/docker-compose.yml up

.PHONY:	all up down dblogs nginxlogs wplogs ps fclean re 