# Critter's .zshrc
# should be edited in the dotfiles repo and moved using `make`, not edited
# directly

# Keyboard shortcuts
# Ctrl-T	fzf search
# Ctrl-R	fzf search in the command history
# Alt-C		cd into fzf search

# Aliases
# vfzf		vim $(fzf)

# aliases
alias vfzf='vim $(fzf)'

# pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:path color white
zstyle :prompt:pure:prompt:success color green

# oh-my-zsh
export ZSH="$(echo $HOME)/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-nvm)
source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type 'fd' > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git' # requires https://github.com/sharkdp/fd
else
  export FZF_DEFAULT_COMMAD='find -L'
fi
export FZF_DEFAULT_OPTS='--height 40% --reverse'

# environment variables
export BW_CLIENTID='user.16df2d79-8045-4a5f-a0b4-ac9d00012ba8'
export BW_CLIENTSECRET='XxXSE2SYx2BBlVWUspI1mLVn4n0zw6'
