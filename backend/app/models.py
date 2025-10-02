from sqlalchemy import Column, Integer, String, DateTime, Boolean, Text, ForeignKey, JSON, Date, Time
from sqlalchemy.sql import func
from .database import Base
from datetime import date

class User(Base):
    __tablename__ = "user"
    user_id = Column(Integer, primary_key = True, autoincrement = True)
    email = Column(String, unique = True, nullable = False)
    password = Column(String, nullable = False)
    role_id = Column(Integer, ForeignKey("role.role_id"), nullable = False)

class Role(Base):
    __tablename__ = "role"
    role_id = Column(Integer, primary_key = True, autoincrement = True)
    role_name = Column(String, unique = True)

class Student(Base):
    __tablename__ = "student"
    student_id = Column(Integer, primary_key = True, autoincrement = True)
    student_fname = Column(String, nullable = False)
    student_lname = Column(String, nullable = False)
    student_gender = Column(String, nullable = False)
    student_email = Column(String, nullable = False, unique = True)
    student_usn = Column(String, nullable = False, unique = True)
    user_id = Column(Integer, ForeignKey("user.user_id"), nullable = False)
    
class Course(Base):
    __tablename__ = "course"
    course_id = Column(Integer, primary_key = True, autoincrement = True)
    course_name = Column(String, nullable = False)

class Professor(Base):
    __tablename__ = "professor"
    prof_id = Column(Integer, primary_key = True, autoincrement = True)
    salutation = Column(String, nullable = False)
    prof_fname = Column(String, nullable = False)
    prof_lname = Column(String, nullable = False)
    prof_email = Column(String, nullable = False, unique = True)
    user_id = Column(Integer, ForeignKey("user.user_id"), nullable = False)

class SCP(Base):
    __tablename__ = "scp"
    scp_id = Column(Integer, primary_key=True, autoincrement = True)
    student_id = Column(Integer, ForeignKey("student.student_id"), nullable = False)
    prof_id = Column(Integer, ForeignKey("professor.prof_id"), nullable = False)
    course_id = Column(Integer, ForeignKey("course.course_id"), nullable = False)

class SC(Base):
    __tablename__ = "sc"
    sc_id = Column(Integer, primary_key=True, autoincrement = True)
    student_id = Column(Integer, ForeignKey("student.student_id"), nullable = False)
    course_id = Column(Integer, ForeignKey("course.course_id"), nullable = False)

class PC(Base):
    __tablename__ = "pc"
    pc_id = Column(Integer, primary_key=True, autoincrement = True)
    prof_id = Column(Integer, ForeignKey("professor.prof_id"), nullable = False)
    course_id = Column(Integer, ForeignKey("course.course_id"), nullable = False)

class Attendance(Base):
    __tablename__ = "attendance"
    attendance_id = Column(Integer, primary_key=True, autoincrement = True)
    attendance_date = Column(Date, default = date.today)
    status = Column(Boolean, default = True)
    scp_id = Column(Integer, ForeignKey("scp.scp_id"), nullable = False)

class Timetable(Base):
    __tablename__ = "timetable"
    timetable_id = Column(Integer, primary_key = True, autoincrement = True)
    day = Column(String, nullable = False)
    time = Column(Time, nullable = False)
    pc_id = Column(Integer, ForeignKey("pc.pc_id"), nullable = False)
    
