# coding=utf-8
from sqlalchemy import func, or_, not_
import connection
import VoteModel
import my_security

def exit_design(designer_name):
	session=connection.init_db()
	query=session.query(VoteModel.Design)
	print 'i '
	for li in query.all():
		print li.work_name
		if my_security.verify_hash(li.work_name,designer_name):
			return 1
	return 0
def exit_designer(designer):
	session=connection.init_db()
	query=session.query(VoteModel.Designer)
	
	if li is None :
		return 1
	return 0


def save_design(filename,designer):
	work=VoteModel.Design(work_name=filename)
	designer_database=None
	session=connection.init_db()
	query=session.query(VoteModel.Designer)
	li=query.filter(VoteModel.Designer.name==designer).scalar()
	if li is None:
		designer_database=VoteModel.Designer(name=designer)
		designer_database.designs.append(work)
	else:
		designer_database=li
		print designer_database.name
		print designer_database.id 
	designer_database.designs.append(work)
	session.add(work)
	session.add(designer_database)
	session.commit()


def addVoter(username,desingn_id):
	session=connection.init_db()
	query=session.query(VoteModel.Voter)
	voter=query.filter(VoteModel.Voter.name==username).scalar()
	if voter is None:
		voter=VoteModel.Voter(name=username,design_id=desingn_id)
		session.add(voter)
		session.commit()

def get_designs():
	session=connection.init_db()
	query=session.query(VoteModel.Design)
	lis=[]
	for q in query.all():
		design={}
		design['id']=q.id
		design['path']=q.work_name
		design['voters']=session.query(func.count('*')).filter(VoteModel.Voter.design_id ==q.id).scalar()
		lis.append(design)
	# print lis	
	return lis
	 # filter()
def delete_design(id):
	session=connection.init_db()
	query=session.query(VoteModel.Design)
	design=query.filter(VoteModel.Design.id==id).scalar()
	if not design is None :
		print design.id 
		print design.work_name 
		session.delete(design)
		session.commit()


# get_designs()


	