clean:
	bash ./clean.sh

bake:
	docker buildx bake -f ./docker-bake.hcl --push ubuntu

bake-wsl:
	docker buildx bake -f ./docker-bake.hcl --push helios

export-tar:
	docker run --detach --name helios-runner ghcr.io/koenverburg/dotfiles/helios
	docker export --output=helios-wsl-install.tar helios-runner
	# docker stop $ancestorId
	# docker rm $ancestorId
	# docker rmi ghcr.io/koenverburg/dotfiles/helios
