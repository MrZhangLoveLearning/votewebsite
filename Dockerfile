# this is build for nginx+uwsgi+django
# python --2.7
# Author : ZhangLun

From ubuntu:14.04

MAINTAINER zhanglun mrzhanglovinglearning@gmail.com

# update the ubuntu source
echo -e "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse\ndeb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse\ndeb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse\ndeb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse\ndeb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse\ndeb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse\ndeb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse\ndeb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse\ndeb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse\ndeb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" > /etc/apt/sources.list

# install nginx supervisor pip uwsgi
RUN apt-get update & apt-get install  -y nginx supervisor uwsgi python-pip 


RUN service nginx start



