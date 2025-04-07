#!/bin/bash

os=$(uname) # Linux|Darwin

install_app() {
    app_name=$1
    if [[ $os == "Darwin" ]]; then
        if ! brew list $app_name &>/dev/null; then
            echo "$app_name is not installed. Installing..."
            brew install $app_name

            if [[ $app_name == "nvm" ]]; then
                nvm install node
            fi
        else
            echo "$app_name already installed."
        fi
    else
        sudo apt install $app_name
    fi
}

echo "installing georgi's favourite things..."

# install homebrew
if [[ $os == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing..."
        # Use curl to download the installation script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo "Adding brew to PATH"
        echo >> /Users/gknox/.zprofile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gknox/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"

        brew update
    else
        echo "Homebrew already installed."
        brew update
    fi
fi

install_app zsh

# install oh-my-zsh + plugins
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "oh-my-zsh already installed."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install zsh-autosuggestions plugin
if [[ -d "$HOME/.oh-my-zsh/zsh-autosuggestions" ]]; then
    echo "zsh-autosuggestions already installed."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ -d "$HOME/.oh-my-zsh/zsh-history-substring-search" ]]; then
    echo "zsh-history-substring-search already installed."
else
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

ZSH_CUSTOM=/Users/gknox/.oh-my-zsh/custom
# echo "copying os specific zsh configs to $ZSH_CUSTOM folder"
if [[ $os == "Darwin" ]]; then
    cp macos.zsh "$ZSH_CUSTOM"
    echo "Copied macos.zsh to $ZSH_CUSTOM"
else
    cp kube-beach.zsh "$ZSH_CUSTOM"
    echo "Copied kube-beach.zsh to $ZSH_CUSTOM"
    if [ ! -f ~/bin/oh-my-posh ]; then
        install_app unzip
        mkdir ~/bin
        curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
    fi
fi

install_app git
cp .gitconfig ~/.gitconfig

if [[ $os == "Darwin" ]]; then
    install_app nvm
    install_app tsc
    install_app jq
    install_app tree
    install_app coreutils
    install_app jandedobbeleer/oh-my-posh/oh-my-posh
fi

if command -v yarn &>/dev/null; then
    echo "yarn already installed."
else
    echo "yarn is not installed. Installing..."
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    # echo 'export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"' >>~/.zshrc
fi

echo "copying .zshrc to ~"
cp .zshrc ~

oh-my-posh font install meslo
echo "copying themefile to $ZSH_CUSTOM"
cp theme-atomic.omp.json $ZSH_CUSTOM
# eval "$(oh-my-posh init zsh --config ~/.oh-my-zsh/custom/theme-atomic.omp.json)"

echo "finished installing georgi's favourite things..."
echo "make sure to run source ~/.zshrc now"
