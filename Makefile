.PHONY: move
move: move-vim move-zsh move-kitty

.PHONY: move-vim
move-vim:
	sudo cp ./vim/.vimrc ~/.vimrc
	sudo cp -r ./vim/.vim ~

.PHONY: move-zsh
move-zsh:
	sudo cp ./zsh/.zshrc ~/.zshrc
	sudo cp -r ./zsh/.oh-my-zsh ~
	sudo cp -r ./zsh/.zsh ~

.PHONY: move-kitty
move-kitty:
	sudo cp -r kitty/ ~/.config/kitty

# installs everything
.PHONY: install
install: clone-submodules install-vim install-vim-plugins install-misc-tools install-kitty move

.PHONY: install-kitty
install-kitty:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# install vim from source (https://github.com/vim/vim)
ifndef VIMDIR
VIMDIR := ~ # default vim install directory is ~, clones vim to ~/vim
endif
.PHONY: install-vim
install-vim: move
	cd $(VIMDIR) && (git clone https://github.com/vim/vim.git || (cd vim && git pull && cd ..)) \
	&& cd vim \
	&& make distclean \
	&& ./configure --with-features=huge \
            	--enable-multibyte \
            	--enable-python3interp=yes \
            	--with-python3-config-dir=$(shell python3-config --configdir) \
            	--enable-perlinterp=yes \
            	--enable-gui=gtk2 \
            	--enable-cscope \
            	--prefix=/usr/local \
	&& make \
	&& make install

# installs vim plugins that require external installation / compilation
.PHONY: install-vim-plugins
install-vim-plugins: install-misc-tools move
	cd ~/.vim/pack/plugins/start/YouCompleteMe && sudo python3 install.py --all

.PHONY: clone-submodules
clone-submodules:
	git submodule update --init --recursive

ifndef TOOLSDIR
TOOLSDIR := ~ # default vim install directory is ~, clones vim to ~/vim
endif
.PHONY: install-misc-tools
install-misc-tools:
	cd $(TOOLSDIR) && (git clone --depth 1 https://github.com/junegunn/fzf.git || (cd fzf && git pull && cd ..)) && \
	./fzf/install

# `go get` things that can be (requires go so not part of general install)
.PHONY: go-gets
go-gets:
	go get github.com/google/go-jsonnet/cmd/jsonnet
	go get github.com/google/go-jsonnet/cmd/jsonnetfmt
	go get github.com/google/go-jsonnet/cmd/jsonnet-lint
	go get github.com/google/go-jsonnet/cmd/jsonnet-deps
