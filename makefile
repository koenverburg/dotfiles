# vim:vim: set tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab
clean:
	bash ./clean.sh

bake:
	docker buildx bake -f ./docker-bake.hcl --push ubuntu

bake-mars:
	docker buildx bake -f ./docker-bake.hcl mars

bake-wsl:
	docker buildx bake -f ./docker-bake.hcl --push helios

export-tar:
	docker run --detach --name helios-runner ghcr.io/koenverburg/dotfiles/helios
	docker export --output=helios-wsl-install.tar helios-runner
	# docker stop $ancestorId
	# docker rm $ancestorId
	# docker rmi ghcr.io/koenverburg/dotfiles/helios

snapshot-macos:
	brew bundle dump

neovim-linux:
	git clone https://github.com/neovim/neovim.git ~/code/tools/neovim
	cd ~/code/tools/neovim
	sudo make distclean
	sudo make CMAKE_BUILD_TYPE=release
	sudo make install
	cd -
