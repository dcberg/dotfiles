#!/bin/bash

set -e

if [ ! -d ~/code/dotfiles ]; then
  echo "Cloning dotfiles"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  cd ~/code
  git clone https://github.com/dcberg/dotfiles.git
fi

cd ~/code/dotfiles 
git remote set-url origin git@github.com:dcberg/dotfiles.git

echo "Creating symlinks for dotfiles"
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/tmuxconf ~/.tmux.conf
ln -s $(pwd)/tigrc ~/.tigrc
ln -s $(pwd)/git-prompt.sh ~/.git-prompt.sh
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/agignore ~/.agignore
ln -s $(pwd)/sshconfig ~/.ssh/config

# copy files linked in .zshrc
cd ~/code/dotfiles/workstation
echo "Copying IKS related files"
mkdir ~/.kube 
cp kubeconfig ~/.kube/config

cp iks-merged-config.sh ~/opt/iks-merged-config.sh
cp iks-download-cluster-configs.sh ~/opt/iks-download-cluster-configs.sh
chmod +x ~/opt/iks-merged-config.sh
chmod +x ~/opt/iks-download-cluster-configs.sh

# setup kubectx
ln -s ~/opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s ~/opt/kubectx/kubens /usr/local/bin/kubens
# setup completions
mkdir ~/opt/completion
ln -s ~/opt/kubectx/completion/kubectx.zsh ~/opt/completion/_kubectx.zsh
ln -s ~/opt/kubectx/completion/kubens.zsh ~/opt/completion/_kubens.zsh


/usr/sbin/sshd -D
