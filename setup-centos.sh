#!/usr/bin/bash

### install zsh
sudo yum -y install zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

### install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

### set login shell
chsh -s /bin/zsh

### download setting files
cd ~/
wget -r https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.tigrc
wget -r https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.vimrc
wget -r https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.zshrc
wget -r https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.dein.toml
wget -r https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.dein_lazy.toml
source ~/.zshrc
source ~/.tigrc
source ~/.vimrc

### install tig
sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
sudo yum install -y tig

