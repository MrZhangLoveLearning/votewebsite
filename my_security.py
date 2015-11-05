# coding=utf-8
from sqlalchemy import Table, Column, ForeignKey
from sqlalchemy.types import CHAR, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from werkzeug.security import generate_password_hash, check_password_hash
class User(object):
	password_hash = Column(String(128))
	@property
	def password(self):
		raise AttributeError('password is not a readable attribute')
	@password.setter
	def password(self, password):
		self.password_hash = generate_password_hash(password)
	def verify_password(self, password):
		return check_password_hash(self.password_hash, password)
def create_hash(code):
	li=generate_password_hash(code).split('$')
	return li[1]+li[2]
def verify_hash(code,password):
	encode1=code[0:8]
	encode2=code[8:].split('.')[0]
	encode='pbkdf2:sha1:1000$'+encode1+'$'+encode2
	return check_password_hash(encode,password)
	

# code=create_hash('zhang')
# print verify_hash(code,'zhang')

# print check_password_hash(generate_password_hash('zhang'),'zhang')
# u = User()
# u.password='zhanglun'
# # print u.password_hash
# # print u.password
# print u.verify_password('zhanglun')
# u2=User()
# u2.password='shit'
# # for i in range(1000):
# # 	print generate_password_hash(str(i))
# print generate_password_hash("张伦").split('$')[2]
# help(generate_password_hash)			
