#!/usr/bin/bash


### install zsh
sudo yum -y install zsh

### set login shell
chsh -s /bin/zsh

### download setting files
wget https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.tigrc
wget https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.vimrc
wget https://raw.githubusercontent.com/murawakimitsuhiro/shell-config/master/.zshrc

### install tig
rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
yum install -y tig
