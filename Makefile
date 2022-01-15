include .env

# MakeFile for Laravel Crash Course

laravel_install: #Create new Laravel project
	@docker exec -it $(CONTAINER_PHP) composer create-project --prefer-dist laravel/laravel .

vue_install: #Create new vue project
	@docker exec -it $(CONTAINER_VUE) vue create .

clear: #Clear cache and config
    @docker exec -it  $(CONTAINER_PHP) php artisan config:cache

key: #generate APP key
	@docker exec -it  $(CONTAINER_PHP) php artisan key:generate

ownership: #Set ownership
	@sudo chown $(USER):$(USER) . -R

# Work in containers

up: #start docker containers @docker-compose up -d
	@docker-compose up -d

build: #build docker container @docker-compose build
	@docker-compose build

down: #stop docker containers
	@docker-compose down

start: #start docker containers @docker-compose start
	@docker-compose start

stop: #stop docker containers @docker-compose stop
	@docker-compose stop

restart: #restart docker containers @docker-compose restart
	@docker-compose restart

show: #show docker's containers
	@sudo docker ps

connect_php: #Connect to APP container
	@docker exec -it $(CONTAINER_PHP) $(SHELL)

connect_db: #Connect to DB container
	@docker exec -it $(CONTAINER_POSTGRES) $(SHELL)

connect_rmq: #Connect to rabbitmq container
	@docker exec -it $(CONTAINER_RMQ) $(SHELL)

connect_server: #Connect to server container
	@docker exec -it $(CONTAINER_SERVER) $(SHELL)

connect_go: #Connect to golang container
	@docker exec -it $(CONTAINER_GOLANG) $(SHELL)

connect_vue: #Connect to node container
	@docker exec -it $(CONTAINER_VUE) $(SHELL)

npm_install: #Install dependency
	@docker exec -it $(CONTAINER_VUE) npm install

npm_build: #build file project --development
	@docker exec -it $(CONTAINER_VUE) npm run build

npm_run_dev: #build file project --production
	@docker exec -it $(CONTAINER_VUE) npm run serve

.PHONY: build_go
build_go:
	@docker exec -it ${CONTAINER_GOLANG} go build -v ./cmd/main.go

.PHONY: test_go
test_go:
	@docker exec -it ${CONTAINER_GOLANG} go test -v -race -timeout 30s ./...

.PHONY: run_go
run_go:
	@docker exec -it ${CONTAINER_GOLANG} ./main