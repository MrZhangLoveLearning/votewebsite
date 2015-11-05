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
	
	