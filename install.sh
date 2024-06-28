#!/bin/bash

os=$(uname) # Linux|Darwin

# install homebrew
if [[ $os == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing..."
        # Use curl to download the installation script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew already installed."
    fi
fi

# install zsh
if command -v zsh &>/dev/null; then
    echo "zsh already installed."
else
    echo "zsh is not installed, fixing that now"
    if [[ $os == "Darwin" ]]; then
        brew install zsh
    else
        sudo apt install -y zsh
    fi
    source ~/.zshrc
    zsh
fi

# install oh-my-zsh + plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

export ZSH_CUSTOM=~/.oh-my-zsh/custom
echo "copying os specific zsh configs to $ZSH_CUSTOM folder"
if [[ $os == "Darwin" ]]; then
    cp macos.zsh "$ZSH_CUSTOM"
    echo "Copied macos.zsh to $ZSH_CUSTOM"
else
    cp linux.zsh "$ZSH_CUSTOM"
    echo "Copied linux.zsh to $ZSH_CUSTOM"
fi

if [[ $os == "Darwin" ]]; then

    if ! brew list nvm &>/dev/null; then
        echo "nvm is not installed. Installing..."
        # Install nvm using Homebrew
        echo "installing nvm + node"
        brew install nvm
        nvm install node

        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_com
    else
        echo "zsh already installed."
    fi
else
    echo "not installing nvm + node on Linux rn"
fi

if [[ $os == "Darwin" ]]; then
    if ! brew list git &>/dev/null; then
        echo "git is not installed. Installing..."
        brew install git
        cp .gitconfig ~/.gitconfig
    else
        echo "git already installed."
    fi
else
    sudo apt install git
    cp .gitconfig ~/.gitconfig
fi
