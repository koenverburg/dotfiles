clean:
	bash ./clean.sh

bake:
	docker buildx bake -f ./docker-bake.hcl --push ubuntu

bake-wsl:
	docker buildx bake -f ./docker-bake.hcl --push helios


push:
	export DOCKER_META_IMAGES="ghcr.io/koenverburg/dotfiles/ubuntu-dotfiles" 
	docker buildx bake -f ./docker-bake.hcl --push build --print
