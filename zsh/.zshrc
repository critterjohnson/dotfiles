# Critter's .zshrc
# should be edited in the dotfiles repo and moved using `make`, not edited
# directly

# Keyboard shortcuts
# Ctrl-T	fzf search
# Ctrl-R	fzf search in the command history
# Alt-C		cd into fzf search

# Aliases
# vfzf		vim $(fzf)
# kc            kubectl
# gm            greymatter

# oh-my-zsh
export ZSH="$(echo $HOME)/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-nvm docker docker-compose)
source $ZSH/oh-my-zsh.sh

# aliases
alias vfzf='vim $(fzf)'
alias awsume='. awsume'
alias kc='kubectl'
alias gm='greymatter'

# autocompletions
autoload -Uz compinit
compinit
which kubectl &> /dev/null && source <(kubectl completion zsh)
which kops &> /dev/null && source <(kops completion zsh)
which greymatter &> /dev/null && source <(greymatter utils completion zsh)
which cue &> /dev/null && source <(cue completion zsh)

# pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:path color white
zstyle :prompt:pure:prompt:success color green

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type 'fd' > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git' # requires https://github.com/sharkdp/fd
else
  export FZF_DEFAULT_COMMAD='find -L'
fi
export FZF_DEFAULT_OPTS='--height 40% --reverse'

# iTerm2 bindings
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    bindkey "^[^[[C" forward-word
    bindkey "^[^[[D" backward-word
fi

# kitty
if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh="kitty +kitten ssh"
fi

# cool functions
clip () {
    if [[ ! -t 0 ]]
        then
                cat - | kitty +kitten clipboard
        else
                cat $1 | kitty +kitten clipboard
    fi
}

# environment variables
export BW_CLIENTID='user.16df2d79-8045-4a5f-a0b4-ac9d00012ba8'
export BW_CLIENTSECRET='XxXSE2SYx2BBlVWUspI1mLVn4n0zw6'
export PATH="$HOME/go/bin":"$HOME/Library/Python/3.7/bin":"/usr/local/sbin":"/usr/local/opt/curl/bin":"/Users/critterjohnson/.deno/bin":"$HOME/.cargo/bin":$PATH
export KOPS_STATE_STORE=s3://bs-kops-state-store
export EDITOR=vim
