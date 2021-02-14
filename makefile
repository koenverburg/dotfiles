clean:
	bash ./clean.sh

pull-ubuntu:
	docker-compose pull

build-ubuntu:
	docker-compose up --build

bake:
	docker buildx bake -f ./docker-bake.hcl

push:
	export DOCKER_META_IMAGES="ghcr.io/koenverburg/dotfiles/ubuntu-dotfiles" 
	docker buildx bake -f ./docker-bake.hcl --push build --print
