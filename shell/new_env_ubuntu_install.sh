#!/bin/sh

# update system
echo "change vi /etc/apt/sources.list  http://mirrors.163.com"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

# install git
sudo apt-get install curl
sudo apt-get install git-core

git config --global user.name "***"
git config --global user.email "***@gmail.com"

git config --global alias.st status
git config --global alias.ci "commit -a"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.onelog "log -p -1"
git config --global alias.df diff
git config --global alias.undo "reset --hard"

git config --global color.status auto
git config --global color.branch auto
git config --global color.ui auto


# install rails env
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm update && rvm reload
echo 'source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
sudo apt-get install build-essential bison libreadline5 libreadline-dev zlib1g zlib1g-dev libssl-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev autoconf
~/.rvm/scripts/rvm install ree
~/.rvm/scripts/rvm ree
gem install rails

# install mysql
sudo apt-get install mysql mysql-server mysql-client libmysql-ruby libmysqlclient-dev
gem install mysql

# insatll vim
sudo apt-get install ctags
sudo apt-get install vim-gnome
git clone git@github.com:RobinWu/vim-dev-env.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
