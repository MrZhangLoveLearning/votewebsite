#!/bin/bash
echo "deploy the votewebsite !"
#!/bin/bash

# Author : mozhiyan
# Copyright (c) http://see.xidian.edu.cn/cpp/linux/
# Script follows here:

# echo "What is your name?"
# read PERSON
# echo "Hello, $PERSON"
project_path="/var/www/votewebsite"

create_file(){
	if [ -d "$1" ]
	then 
		echo "$1 has already exit"
	else
		sudo mkdir $1
		echo "create $1"
	fi
}
change_own_mod(){
sudo chmod -R 666 $1
sudo chown -R www-data:www-data $1

}
create_file /var/www
create_file /var/www/votewebsite
create_file /var/www/env
# cd /var/www
# if [ ! -f "~/.ssh/id_rsa.pub"]
# ssh-keygen -t rsa -C "2529450174@qq.com" # Creates a new ssh key using the provided email
# # Generating public/private rsa key pair...
# sudo git clone git@git.oschina.net:NCUHomeGit/votewebsite.git
if [ ! -f "/var/www/env/bin/activate" ]
then
	sudo virtualenv env
fi
# change_own_mod /var/www/votewebsite

# delete the old nginx config
if [ -f "/etc/nginx/sites-enabled/default" ]
then
	sudo rm /etc/nginx/sites-enabled/default
fi

source  /var/www/env/bin/activate
cd /var/www/votewebsite
pip install -r requirements.txt

# add to nginx config to run the website
sudo cp -f /var/www/votewebsite/Config/vote_system_nginx /etc/nginx/sites-available/vote_system_nginx
sudo ln -sf /etc/nginx/sites-available/vote_system_nginx /etc/nginx/sites-enabled/vote_system_nginx

# change the log to  everyone
change_own_mod /var/log

# run the website
sudo /etc/init.d/nginx restart
uwsgi --ini /var/www/votewebsite/Config/vote_system_uwsgi.ini



