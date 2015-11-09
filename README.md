#VoteProject
## build 
## to start your project
#### if you don't git clone the project do this

		cd /var/www/
		sudo mkdir vote
		cd vote
		sudo git clone https://github.com/MrZhangLoveLearning/votewebsite.git
		sudo chmod +x votewebsite/deploy.sh
		sudo ./votewebsite/deploy.sh


#### if you have clone it to local do that

		cd /var/vote/votewebsite
		git pull
		./deploy.sh

#### if you want to set this in your website you can add ssh to your project

		ssh-keygen -t rsa -C "2529450174@qq.com"



##API

####1 投票
url=/vote

args=id(ps:作品的id)

methods=GET or POST


####2 获取列表

url=/list

methods=GET or POST


return 
{
  "vote": 
  [{"id":1
    "path": "Ln22gnCe175492b35887dc2fb61e549bb8a0597512510089.png", 
    "voters": 1
    }
  ]
}

"1"-----作品id

"path"----作品的位置

"voters"----投票人数





