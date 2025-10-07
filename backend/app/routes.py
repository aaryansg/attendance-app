from flask import Blueprint, request, jsonify, session
from flask_login import login_required
from flask_sqlalchemy import SQLAlchemy
from . import db
from .models import User, Student, Professor, Course, Role, Attendance, Timetable, SCP, SC, PC
from datetime import datetime


bp = Blueprint('api', __name__, url_prefix='/api')

@bp.route('/login', methods = ['POST'])
def login():
    try:
        #json: {"email": abc@gmail.com, "password" : 1234}
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')
        user = User.query.filter_by(email = email).first()
        if user and user.password == password:
            session['user_id'] = user.user_id
            session['role'] = user.role.role_name
            return jsonify(
                {
                    "message" : "login successful",
                    "user_id" : user.user_id,
                    "role" : user.role.role_name
                }
            ), 200
        return jsonify(
            {
                "message" : "invalid credentials"
            }
        ), 401
    except Exception as e:
        return jsonify({"error" : str(e)}), 400
    
@bp.route('/home', methods = ['GET'])
@login_required
def home():
    try:
        prof_id_tup = Professor.query.with_entities(Professor.prof_id).filter_by(user_id = session['user_id']).first()
        prof_id = prof_id_tup[0]
        timetable = Timetable.query.join(PC, Timetable.pc_id == PC.pc_id).filter(PC.prof_id == prof_id).order_by(Timetable.time.asc()).all()
        return jsonify(
            {
                "timetable" : timetable
            }
        ), 200

    except Exception as e:
        return jsonify(
            {
                "error": str(e)
            }
        ), 400
    

@bp.route('/attendance/add', methods = ['POST'])
@login_required
def addAttendance():
    try:
        pc_id = request.args.get('pc_id')
        currDate = request.args.get('date')
        currTime = request.args.get('time')
        scp_list = SCP.query.with_entities(SCP.scp_id).filter(SCP.pc_id == pc_id).all()
        attendance_data = []
        for scpid_tup in scp_list:
            scpid = scpid_tup[0]
            attendance_data.append(
                Attendance(
                    attendance_date = currDate,
                    scp_id = scpid,
                    attendance_time = currTime,
                    status = True
                )
            )
        db.session.add_all(attendance_data)
        db.session.commit()

    except Exception as e:
        return jsonify(
            {
                "error" : str(e)
            }
        ), 400



@bp.route('/attendance', methods = ['GET','PUT'])
@login_required
def attendance():
    if request.method == 'PUT':
        try:
            #json: {date: 1212, time:1300, scp_id: 1, status: False}
            data = request.get_json()
            currDate = data.get('date')
            currTime = data.get('time')
            scp_id = data.get('scp_id')
            status = data.get('status')
            aid = Attendance.query.filter(Attendance.attendance_date == currDate).filter(Attendance.attendance_time == currTime).filter(Attendance.scp_id == scp_id).first()
            student = Attendance.query.get(aid)
            student.status = status
            db.session.commit()

        except Exception as e:
            return jsonify(
                {
                    "error" : str(e)
                }
            ), 400
    else:
        try:
            pc_id = request.args.get('pc_id')
            currDate = request.args.get('date')
            currTime = request.args.get('time')
            students = Student.query.with_entities(Student.student_fname, Student.student_lname, Student.student_usn, Attendance.status).join(SCP, SCP.student_id == Student.student_id).join(Attendance, Attendance.scp_id == SCP.scp_id).join(PC, SCP.pc_id == PC.pc_id).filter(Attendance.attendance_date == currDate).filter(Attendance.attendance_time == currTime).filter(SCP.pc_id == pc_id).all()
            students_data = []
            for record in students:

                students_data.append(
                    {
                        "fname": record[0],
                        "lname": record[1],
                        "usn" : record[2],
                        "status" : record[3]
                    }
                )
            return jsonify(
                {
                    "students" : students_data
                }
            ), 200

        except Exception as e:
            return jsonify(
                {
                    "error" : str(e)
                }
            ), 400