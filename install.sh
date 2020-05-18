# git
git config --global user.name "Georgi Knox"
git config --global user.email "georgicodes@github.com"

# vim
mkdir -p ~/.vim/colors
cp ~/.dotfiles/.vim/colors/heman.vim ~/.vim/colors/
ln -s ~/.dotfiles/.zshrc ~/
ln -s ~/.dotfiles/.vimrc ~/


# zsh 
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    sudo apt install -y zsh
    zsh
fi;