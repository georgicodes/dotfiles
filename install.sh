# git
git config --global user.name "Georgi Knox"
git config --global user.email "georgicodes@github.com"
git config --global core.editor vim
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

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