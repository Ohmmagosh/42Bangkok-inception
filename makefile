

LINE="------------------"

upd:
	cd srcs && docker compose up -d

up:
	cd srcs && docker compose up

down:
	cd srcs && docker compose -f docker-compose.yml down --rmi local

system:
	docker system prune

list:
	@echo $(LINE) container $(LINE)
	@docker ps -a
	@echo $(LINE) images $(LINE)
	@docker images
	@echo $(LINE) volume $(LINE)
	@docker volume ls
	@echo $(LINE) network $(LINE)
	@docker network ls

clean:
	docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \


fclean: clean


re: fclean clean up down list

.PHONY: upd up down fclean clean re
