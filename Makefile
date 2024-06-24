DOCK_CMP 		:= docker compose
DOCK_CMP_FILE	:= ./srcs/docker-compose.yml

DATA_DIR		:= /home/aithel/data/
DB_DIR			:= $(DATA_DIR)db
WP_DIR			:= $(DATA_DIR)wordpress
REQ_DIRS		:= $(DB_DIR) $(WP_DIR)

# Reset
NC		:= \033[0m# 	Text Reset

# Regular Colors
BLACK	:= \033[0;30m#	Black
RED		:= \033[3;31m#	Red
GREEN	:= \033[3;32m#	Green
BLD_GRN	:= \033[1;32m#	Green but bold
YELLOW	:= \033[3;33m#	Yellow
BLUE	:= \033[1;34m#	Blue
PURPLE	:= \033[3;35m#	Purple
BLD_PUR	:= \033[1;35m#	Purple but bold
CYAN	:= \033[3;36m#	Cyan
WHITE	:= \033[1;37m#	White

up: $(REQ_DIRS)
	@echo "$(BLD_GRN)Starting Docker...$(NC)⏳"
	$(DOCK_CMP) -f $(DOCK_CMP_FILE) up

stop:
	@echo "$(CYAN)Stopping Docker...$(NC)⏳"
	$(DOCK_CMP) -f $(DOCK_CMP_FILE) stop
	@echo "$(CYAN)Docker stopped$(NC)✋"

down:
	@echo "$(RED)Destroying...$(NC)💣"
	$(DOCK_CMP) -f $(DOCK_CMP_FILE) down
	@echo "$(RED)Destroyed!$(NC)💥"

build: $(REQ_DIRS)
	@echo "$(PURPLE)Building images...$(NC)📸"
	$(DOCK_CMP) -f $(DOCK_CMP_FILE) build
	@echo "$(BLD_GRN)Done!$(NC)🖼"

status:
	docker ps

re: down build up

$(REQ_DIRS):
	@echo "$(YELLOW)Creating folder $@ $(NC)🗂"
	@mkdir -p $@

.PHONY: up stop down build status fclean re
