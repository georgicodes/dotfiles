#!/bin/bash

os=$(uname) # Linux|Darwin

install_app() {
    app_name=$1
    if [[ $os == "Darwin" ]]; then
        if ! brew list $app_name &>/dev/null; then
            echo "$app_name is not installed. Installing..."
            brew install $app_name

            if [[ $app_name == "nvm" ]]; then
                echo 'NVM_DIR="$HOME/.nvm"' >>~/.zshrc
                [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
                [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_com

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
        brew update
    else
        echo "Homebrew already installed."
        brew update
    fi
fi

install_app zsh
echo "export ZSH_CUSTOM=~/.oh-my-zsh/custom" >>~/.zshrc

# install oh-my-zsh + plugins
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "oh-my-zsh already installed."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install zsh-autosuggestions plugin
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "zsh-autosuggestions already installed."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "zsh-history-substring-search already installed."
else
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

# echo "copying os specific zsh configs to $ZSH_CUSTOM folder"
if [[ $os == "Darwin" ]]; then
    cp macos.zsh "$ZSH_CUSTOM"
    echo "Copied macos.zsh to $ZSH_CUSTOM"
else
    cp linux.zsh "$ZSH_CUSTOM"
    echo "Copied linux.zsh to $ZSH_CUSTOM"
fi

install_app git
cp .gitconfig ~/.gitconfig

install_app nvm
install_app tsc
if command -v yarn &>/dev/null; then
    echo "yarn already installed."
else
    echo "yarn is not installed. Installing..."
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    echo 'export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"' >>~/.zshrc
fi

echo "finished installing georgi's favourite things..."
