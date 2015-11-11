#!/bin/bash
echo "deploy the votewebsite !"


base_dir=/var/www/vote
log_dir=/var/www/log
config_dir=/var/www/config

uwsgi_config_dir=${config_dir}/uwsgi
nginx_config_dir=${config_dir}/nginx

cd $base_dir







# create the virtualenv of project
# create_file $project_env

if [ ! -f "$base_dir/env/bin/activate" ]
then
	# cd $project_env
	sudo virtualenv env
	
fi

sudo source  $base_dir/env/bin/activate
sudo apt-get install libjpeg-dev
sudo $base_dir/env/bin/pip install -r votewebsite/requirements.txt

#  # if you first use your nginx you can use this

# delete the old nginx config
# if [ -f "/etc/nginx/sites-enabled/default" ]
# then
# 	sudo rm /etc/nginx/sites-enabled/default
# fi

# if you have problem in jepg of IOEF  you may lost this

#    # load the virtualenv 
# for pillow jepg work
# sudo pip uninstall pillow
# sudo pip install --no-cache-dir -I pillow

# pip install ConfigParser



# add to nginx config to run the website
sudo cp -f votewebsite/vote_system_nginx.conf ${nginx_config_dir}/sites-available/vote_system_nginx.conf
sudo ln -sf ${nginx_config_dir}/sites-available/vote_system_nginx.conf ${nginx_config_dir}/sites-enabled/vote_system_nginx.conf

# to make the www-data can save the pic of update
sudo chown -R www-data:www-data votewebsite
# to open the log to let uwsgi can open itself
sudo chown -R www-data:www-data /var/www/log/uwsgi_vote.log

# use the emperor to manage the uwsgi work
echo reload uwsgi
if test $(ps -aux|grep "uwsgi --emperor"|wc -l) -eq 1
then
    uwsgi --emperor ${uwsgi_config_dir} --daemonize ${log_dir}/uwsgi_emperor.log
else
    touch ${uwsgi_config_dir}/vote_system_uwsgi.ini
fi


# run the website
# reload nginx
sudo /etc/init.d/nginx reload






# delete the whole uwsgi work and restart
# ps -ef |grep uwsgi|grep -v grep|cut -c 9-15|xargs sudo kill -s 9
# sudo setsid  uwsgi --uid www-data --gid www-data --ini $project_path/vote_system_uwsgi.ini





