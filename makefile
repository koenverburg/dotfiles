# vim:vim: set tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab

bake-ubuntu:
	docker buildx bake -f ./docker-bake.hcl ubuntu

bake-wsl:
	docker buildx bake -f ./docker-bake.hcl --push helios

snapshot-macos:
	rm brewfile
	brew bundle dump

build-workspace:
	docker build --file workspace.dockerfile --tag wksp .

bootstrap-mac:
	bash ansible/macos.sh
