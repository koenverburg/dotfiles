clean:
	bash ./clean.sh

pull-ubuntu:
	docker-compose pull

build-ubuntu:
	docker-compose up --build

bake:
	docker buildx bake -f ./docker-compose.yml
