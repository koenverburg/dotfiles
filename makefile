# vim:vim: set tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab

# bake-ubuntu:
# 	docker buildx bake -f ./docker-bake.hcl ubuntu

# bake-wsl:
# 	docker buildx bake -f ./docker-bake.hcl --push helios

snapshot-macos:
	rm brewfile
	brew bundle dump

bootstrap-macos:
	pip3 install ansible
	bash ansible/macos.sh

build-macos:
	docker build --file macos.dockerfile --tag regression-macos .

build-workspace:
	docker build --file workspace.dockerfile --tag wksp .

lint-nvim:
	cd .config/nvim && stylua **/**/**/*.lua
# run-wksp:
# 	docker container run wksp --attach
