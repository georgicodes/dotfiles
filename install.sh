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

install_app unzip
install_app git
cp .gitconfig ~/.gitconfig
install_app zsh

# install oh-my-zsh + plugins
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "oh-my-zsh already installed."
else
    echo "Installing oh-my-zsh..."
    # Use RUNZSH=no to prevent the installer from changing shell and exiting
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install zsh plugins
echo "Installing zsh plugins..."
if [[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    echo "zsh-autosuggestions already installed."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search" ]]; then
    echo "zsh-history-substring-search already installed."
else
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

if [[ $os == "Darwin" ]]; then
    install_app nvm
    install_app tsc
    install_app jq
    install_app tree
    install_app coreutils
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

echo "installing oh-my-posh theme + os configs"
# Set ZSH_CUSTOM based on OS
if [[ $os == "Darwin" ]]; then
    ZSH_CUSTOM=/Users/gknox/.oh-my-zsh/custom
    cp macos.zsh "$ZSH_CUSTOM"
    echo "Copied macos.zsh to $ZSH_CUSTOM"
    # Install oh-my-posh on macOS using brew
    if ! brew list jandedobbeleer/oh-my-posh/oh-my-posh &>/dev/null; then
        echo "Installing oh-my-posh..."
        brew install jandedobbeleer/oh-my-posh/oh-my-posh
    fi
else
    ZSH_CUSTOM=/home/gknox/.oh-my-zsh/custom
    cp kube-beach.zsh "$ZSH_CUSTOM"
    echo "Copied kube-beach.zsh to $ZSH_CUSTOM"
    # Install oh-my-posh on Linux
    if [ ! -f ~/bin/oh-my-posh ]; then
        echo "Installing oh-my-posh..."
        mkdir -p ~/bin
        curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
    fi
    # Add ~/bin to PATH in .zshrc if not already present
    if ! grep -q 'export PATH="$HOME/bin:$PATH"' ~/.zshrc; then
        echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
    fi
    # Add ~/bin to current PATH
    export PATH="$HOME/bin:$PATH"
fi

# Install oh-my-posh font and theme
echo "Installing oh-my-posh font..."
# Ensure oh-my-posh is in PATH
if ! command -v oh-my-posh &>/dev/null; then
    if [[ $os == "Darwin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        export PATH="$HOME/bin:$PATH"
    fi
fi
oh-my-posh font install meslo

echo "Installing oh-my-posh theme..."
cp theme-atomic.omp.json "$ZSH_CUSTOM"
echo "copying .zshrc to ~"
cp .zshrc ~
echo "finished installing oh-my-posh theme + os configs"

echo "finished installing georgi's favourite things..."
echo -n "Would you like to restart your shell now to apply changes? (y/n) "
read answer
if [[ $answer == "y" ]]; then
    exec zsh -l
else
    echo "Remember to run 'source ~/.zshrc' or restart your terminal to apply changes"
fi
