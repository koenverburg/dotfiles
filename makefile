# vim:vim: set tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab

clean:
	bash ./clean.sh

bake-ubuntu:
	docker buildx bake -f ./docker-bake.hcl ubuntu

bake-wsl:
	docker buildx bake -f ./docker-bake.hcl --push helios

snapshot-macos:
	brew bundle dump

neovim-linux:
	git clone https://github.com/neovim/neovim.git ~/code/tools/neovim
	cd ~/code/tools/neovim
	sudo make
	sudo make install
	# sudo make distclean
	# sudo make CMAKE_BUILD_TYPE=release
	# sudo make install
	cd -
