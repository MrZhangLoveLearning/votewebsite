# coding=utf-8
from sqlalchemy import Table, Column, ForeignKey
from sqlalchemy.types import CHAR, Integer, String,DateTime, TIMESTAMP
from sqlalchemy.sql.expression import text
from sqlalchemy.orm import sessionmaker,relationship, backref
import connection

# based model 
# every subclass need has a table in datebase
Base = connection.BaseModel

class Design(Base):
	__tablename__='vote_design_project'
	id = Column(Integer,autoincrement=True, primary_key=True)
	work_name=Column(String(100),nullable=False)
	insert_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
	design_id=Column(Integer,ForeignKey('vote_designer.id'),nullable=False)
	voters=relationship('Voter',backref='design',lazy='dynamic')



class Designer(Base):
	__tablename__='vote_designer'
	id = Column(Integer,autoincrement=True, primary_key=True)
	name=Column(String(20),nullable=False)
	insert_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
	designs=relationship('Design',backref='designer',lazy='dynamic')


class Voter(Base):
	__tablename__='vote_voter'
	id = Column(Integer,autoincrement=True, primary_key=True)
	name=Column(String(20),nullable=False)
	insert_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
	design_id=Column(Integer,ForeignKey('vote_design_project.id'),nullable=False)

# print connection.engine
# pop1=Designer()
# d1=Design()
# d1.designer=pop1
# session=connection.init_db()
# session.add(d1)

# session.commit()
# connection.init_db()
# connection.drop_db()

