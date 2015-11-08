#!/bin/bash
echo "deploy the votewebsite !"
#!/bin/bash

# Author : mozhiyan
# Copyright (c) http://see.xidian.edu.cn/cpp/linux/
# Script follows here:

# echo "What is your name?"
# read PERSON
# echo "Hello, $PERSON"

base_dir=/var/www/vote
cd $base_dir

# uwsgi_log=/var/www/log/
# create_file(){
# 	if [ -d "$1" ]
# 	then 
# 		echo "$1 has already exit"
# 	else
# 		sudo mkdir $1
# 		echo "create $1"
# 	fi
# }
# change_own_mod(){
# sudo chmod -R 755 $1
# sudo chown -R www-data:www-data $1

# }

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

# create the virtualenv of project
# create_file $project_env

if [ ! -f "$base_dir/env/bin/activate" ]
then
	# cd $project_env
	sudo virtualenv env
	# load the virtualenv 
	# for pillow jepg work
	# sudo pip uninstall pillow
	# sudo pip install --no-cache-dir -I pillow
fi

sudo source  $base_dir/env/bin/activate
sudo apt-get install libjpeg-dev
sudo pip install -r votewebsite/requirements.txt
# delete the old nginx config
# if [ -f "/etc/nginx/sites-enabled/default" ]
# then
# 	sudo rm /etc/nginx/sites-enabled/default
# fi


# pip install ConfigParser



# add to nginx config to run the website
sudo cp -f votewebsite/vote_system_nginx /etc/nginx/sites-available/vote_system_nginx
sudo ln -sf /etc/nginx/sites-available/vote_system_nginx /etc/nginx/sites-enabled/vote_system_nginx

sudo chown www-data:www-data votewebsite
sudo uwsgi --ini $base_dir/votewebsite/vote_system_uwsgi.ini
# run the website
sudo /etc/init.d/nginx reload


# build the uwsgi log 
# if [ ! -d $uwsgi_log ]
# then
# 	sudo mkdir $uwsgi_log
# fi
# change_own_mod $uwsgi_log

# delete the other's write right of vote
# change_own_mod $project_dict

# delete the whole uwsgi work and restart
# ps -ef |grep uwsgi|grep -v grep|cut -c 9-15|xargs sudo kill -s 9
# sudo setsid  uwsgi --uid www-data --gid www-data --ini $project_path/vote_system_uwsgi.ini





