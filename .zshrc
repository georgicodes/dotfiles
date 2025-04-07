# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

if [ ! -f "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 7

plugins=(
    git
    zsh-autosuggestions
    history-substring-search
)

# added by Georgi
source $ZSH/oh-my-zsh.sh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# START georgi custom

# install script will only copy relevant file based on OS
if [ -f "$ZSH_CUSTOM/kube-beach.zsh" ]; then
    source "$ZSH_CUSTOM/kube-beach.zsh"
fi
if [ -f "$ZSH_CUSTOM/macos.zsh" ]; then
    source "$ZSH_CUSTOM/macos.zsh"
fi

export EDITOR="vim"

alias gcm='git checkout main || git checkout master'
alias gcmp="'git checkout main || git checkout master' && git pull"
alias gitflip="echo '(╯°□°）╯︵ ┻━┻' && git reset --hard HEAD"

alias ip="ipconfig getifaddr en0"
alias sshhome="cd ~/.ssh"

alias zshsource="source ~/.zshrc"

if [[ $os == "Darwin" ]]; then
    alias cdsl="cd ~/dev/slack"
    alias cdts="cd ~/dev/tinyspeck"
    alias gitconfig="code ~/.gitconfig"
    alias sshconfig="code ~/.ssh/config"
    alias zshconfig="code ~/.zshrc"

    alias opsbeach="slack-beach --role ops"              # SSH into your ops-lite beach
    alias opsbeachhost="slack-beach --print ops"         # print the hostname of you kube-beach
    alias kubebeach="slack-beach --role kube-beach"      # SSH into your ops-lite beach
    alias kubebeachhost="slack-beach --print kube-beach" # print the hostname of you kube-beach

    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_com
fi

export OKTA_USERNAME=gknox
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export ZSH_CUSTOM=~/.oh-my-zsh/custom
PATH=$PATH:~/bin
