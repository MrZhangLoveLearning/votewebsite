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
sudo chmod -R 777 $1
sudo chown -R www-data:www-data $1

}
create_file /var/www
create_file /var/www/votewebsite
create_file /var/www/env
change_own_mod /var/www/votewebsite
change_own_mod /var/www/env
# cd /var/www
# if [ ! -f "~/.ssh/id_rsa.pub"]
# ssh-keygen -t rsa -C "2529450174@qq.com" # Creates a new ssh key using the provided email
# # Generating public/private rsa key pair...
# git clone https://github.com/MrZhangLoveLearning/votewebsite.git
# sudo rm -rf /var/www/votewebsite
# sudo mkdir /var/www/votewebsite
# sudo chmod  777 /var/www/votewebsite
# cd /var/www/
# git clone https://github.com/MrZhangLoveLearning/votewebsite.git
# chmod  777 /var/www/votewebsite/deploy.sh
# ./var/www/votewebsite/deploy.sh

if [ ! -f "/var/www/env/bin/activate" ]
then
	virtualenv env
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
# pip install ConfigParser

# for pillow jepg work
sudo apt-get install libjpeg-dev
pip uninstall pillow
pip install --no-cache-dir -I pillow

# add to nginx config to run the website
sudo cp -f /var/www/votewebsite/vote_system_nginx /etc/nginx/sites-available/vote_system_nginx
sudo ln -sf /etc/nginx/sites-available/vote_system_nginx /etc/nginx/sites-enabled/vote_system_nginx

# change the log to  everyone
change_own_mod /var/log

# run the website
sudo /etc/init.d/nginx restart
if [ ! -d "/var/log/uwsgi" ]
then
	sudo mkdir /var/log/uwsgi
fi
change_own_mod /var/log/uwsgi

sudo  uwsgi --uid www-data --gid www-data --ini /var/www/votewebsite/vote_system_uwsgi.ini




