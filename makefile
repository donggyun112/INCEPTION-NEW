all:
	make up

build:
	docker-compose build -f ./srcs/docker-compose.yml

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose down -f ./srcs/docker-compose.yml

clean:
	@echo "Stopping containers and removing volumes..."
	docker-compose -f ./srcs/docker-compose.yml down --volumes
	@echo "Basic cleanup completed."

# 완전 정리: 컨테이너, 볼륨, 이미지, 네트워크 모두 삭제
fclean: clean
	@echo "Performing full cleanup..."
	@echo "Removing all Docker images..."
	@docker image rm $$(docker image ls -aq) 2>/dev/null || echo "No images to remove."
	@echo "Removing all Docker networks..."
	@docker network rm $$(docker network ls -q --filter type=custom) 2>/dev/null || echo "No custom networks to remove."
	@echo "Removing all Docker volumes..."
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || echo "No volumes to remove."
	@echo "Full cleanup completed."

prune:
	@echo "WARNING: This will remove all unused Docker resources."
	@read -p "Are you sure you want to continue? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "Pruning all unused Docker resources..."; \
		docker system prune -af --volumes; \
		rm -rf ./srcs/requirements/Data/*; \
		rm -rf ./srcs/requirements/srcs/*; \
		echo "System prune completed."; \
	else \
		echo "Operation cancelled."; \
	fi


re:
	make fclean
	make all

.PHONY : all build up down clean fclean re


