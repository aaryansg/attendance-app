from sqlalchemy import Column, Integer, String, DateTime, Boolean, Text, ForeignKey, JSON, Date, Time
from sqlalchemy.sql import func
from datetime import date,time
from . import db

class User(db.Model):
    __tablename__ = "user"
    user_id = db.Column(Integer, primary_key = True, autoincrement = True)
    email = db.Column(String, unique = True, nullable = False)
    password = db.Column(String, nullable = False)
    role_id = db.Column(Integer, ForeignKey("role.role_id"), nullable = False)

class Role(db.Model):
    __tablename__ = "role"
    role_id = db.Column(Integer, primary_key = True, autoincrement = True)
    role_name = db.Column(String, unique = True)

class Student(db.Model):
    __tablename__ = "student"
    student_id = db.Column(Integer, primary_key = True, autoincrement = True)
    student_fname = db.Column(String, nullable = False)
    student_lname = db.Column(String, nullable = False)
    student_gender = db.Column(String, nullable = False)
    student_email = db.Column(String, nullable = False, unique = True)
    student_usn = db.Column(String, nullable = False, unique = True)
    student_class = db.Column(String, nullable = False)
    user_id = db.Column(Integer, ForeignKey("user.user_id"), nullable = False)
    
class Course(db.Model):
    __tablename__ = "course"
    course_id = db.Column(Integer, primary_key = True, autoincrement = True)
    course_name = db.Column(String, nullable = False)

class Professor(db.Model):
    __tablename__ = "professor"
    prof_id = db.Column(Integer, primary_key = True, autoincrement = True)
    salutation = db.Column(String, nullable = False)
    prof_fname = db.Column(String, nullable = False)
    prof_lname = db.Column(String, nullable = False)
    prof_email = db.Column(String, nullable = False, unique = True)
    user_id = db.Column(Integer, ForeignKey("user.user_id"), nullable = False)

class SCP(db.Model):
    __tablename__ = "scp"
    scp_id = db.Column(Integer, primary_key=True, autoincrement = True)
    student_id = db.Column(Integer, ForeignKey("student.student_id"), nullable = False)
    pc_id = db.Column(Integer, ForeignKey("pc.pc_id"), nullable = False)
    
class SC(db.Model):
    __tablename__ = "sc"
    sc_id = db.Column(Integer, primary_key=True, autoincrement = True)
    student_id = db.Column(Integer, ForeignKey("student.student_id"), nullable = False)
    course_id = db.Column(Integer, ForeignKey("course.course_id"), nullable = False)

class PC(db.Model):
    __tablename__ = "pc"
    pc_id = db.Column(Integer, primary_key=True, autoincrement = True)
    prof_id = db.Column(Integer, ForeignKey("professor.prof_id"), nullable = False)
    course_id = db.Column(Integer, ForeignKey("course.course_id"), nullable = False)
    prof_class = db.Column(String, nullable = False)

class Attendance(db.Model):
    __tablename__ = "attendance"
    attendance_id = db.Column(Integer, primary_key=True, autoincrement = True)
    attendance_date = db.Column(Date, default = date.today)
    attendance_time = db.Column(Time, default = time.hour)
    status = db.Column(Boolean, default = True)
    scp_id = db.Column(Integer, ForeignKey("scp.scp_id"), nullable = False)

class Timetable(db.Model):
    __tablename__ = "timetable"
    timetable_id = db.Column(Integer, primary_key = True, autoincrement = True)
    day = db.Column(String, nullable = False)
    time = db.Column(Time, nullable = False)
    pc_id = db.Column(Integer, ForeignKey("pc.pc_id"), nullable = False)
    
