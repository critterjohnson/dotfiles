.PHONY: move
move:
	sudo cp ./vim/.vimrc ~/.vimrc
	sudo cp -r ./vim/.vim ~

# installs everything
.PHONY: install
install: install-vim install-vim-plugins

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
install-vim-plugins: move
	cd ~/.vim/pack/plugins/start/YouCompleteMe && python3 install.py --all
