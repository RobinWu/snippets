#!/bin/bash

### BEGIN REFERENCE INFO
# Author:       Tom
# URL:          https://gist.github.com/raw/716174
# Description:  install softwares on ubuntu by gruide
### END REFERENCE INFO

### BEGIN MY INFO
# Author:       Robin
# Email:        robin.wu.cn@gmail.com
# Blog:         http://robinwu.javaeye.com
# github:       http://github.com/RobinWu
# mini-blog:    http://t.sina.com.cn/robin2wu
### END REFERENCE INFO

### BEGIN USING INFO
# http://mirrors.163.com
# replace /etc/apt/sources.list
# sudo curl *** | bash
### END USING INFO

sudo apt-get install dialog

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "请选择您要安装的选项" \
    --title "专业系统安装" --clear \
    --checklist "请选择您要安装的选项" 20 70 13 \
    1 "升级系统 apt-get update & upgrade & dist-upgrade" off \
    2 "更改系统时区" off \
    3 "安装 Curl" off \
    4 "安装 git-core" off \
    5 "安装 vim" off \
    6 "安装 RVM & REE" off \
    7 "安装 Nginx & Passenger" off \
    8 "安装 mysql" off \
    9 "安装 sqlite3" off \
    0 "All" ON \
    2> $tempfile

choice=`cat $tempfile`
# if_install_git="no"
# if_install_nginx="no"

upgrade_system() {
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get dist-upgrade
}
update_timezone() {
  sudo dpkg-reconfigure tzdata
}
install_curl() {
  sudo apt-get install curl
}
install_git() {
  sudo apt-get install git-core
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
  # if_install_git="yes"
}
install_vim() {
  sudo apt-get install ctags install vim-gnome
  git clone git@github.com:RobinWu/vim-dev-env.git ~/.vim
  ln -s ~/.vim/vimrc ~/.vimrc
}
install_rvm_and_ree() {
  bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head)
  ~/.rvm/scripts/rvm update && ~/.rvm/scripts/rvm reload
  echo 'source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
  sudo apt-get install build-essential bison libreadline5 libreadline-dev zlib1g zlib1g-dev libssl-devlibxml2-dev autoconf
  ~/.rvm/scripts/rvm install ree
  ~/.rvm/scripts/rvm ree
}
install_nginx_and_passenger() {
  ~/.rvm/scripts/rvm ree
  gem install passenger
  rvmsudo passenger-install-nginx-module
  sudo wget https://github.com/RobinWu/snippets/raw/master/shell/nginx /etc/init.d/nginx
  sudo chmod +x /etc/init.d/nginx
  sudo /usr/sbin/update-rc.d -f nginx defaults
  # if_install_nginx='yes'
}
install_mysql() {
  sudo apt-get install mysql-server mysql-client libmysql-ruby libmysqlclient-dev
  gem install mysql
}
install_sqlite3() {
  sudo apt-get install sqlite3 swig libsqlite3-ruby libsqlite3-dev
  gem install sqlite3-ruby
}
install_all(){
  upgrade_system
  update_timezone
  install_curl
  install_git
  install_vim
  install_rvm_and_ree
  install_nginx_and_passenger
  install_mysql
  install_sqlite3
  install_all
}
echo_hand_config_info() {
  echo "请手动配置:"
  # if ["$if_install_git" == "yes"]; then
    echo "-------------------git-------------------"
    echo "git config --global user.name ***"
    echo "git config --global user.email ***@gmail.com"
  # fi

  # if ["$if_install_nginx" == "yes"]; then
    echo "-------------------nginx-------------------"
    echo "sudo vi /opt/nginx/conf/nginx.conf"
    echo "pid /var/run/nginx.pid;"
  # fi
}

if [ "$choice" != '' ]; then
  for line in $choice; do
    echo "执行命令 $line ..."
    case "$line" in
      "\"1\"") upgrade_system;;
      "\"2\"") update_timezone;;
      "\"3\"") install_curl;;
      "\"4\"") install_git;;
      "\"5\"") install_vim;;
      "\"6\"") install_rvm_and_ree;;
      "\"7\"") install_nginx_and_passenger;;
      "\"8\"") install_mysql;;
      "\"9\"") install_sqlite3;;
      "\"0\"") install_all;;
    esac
  done

  echo_hand_config_info
fi
