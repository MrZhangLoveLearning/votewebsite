#VoteProject
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
  "1": {
    "path": "Ln22gnCe175492b35887dc2fb61e549bb8a0597512510089.png", 
    "voters": 1
  }
}

"1"-----作品id

"path"----作品的位置

"voters"----投票人数

Creating a new branch is quick AND simple.


