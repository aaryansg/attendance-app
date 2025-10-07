PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE role (
	role_id INTEGER NOT NULL, 
	role_name VARCHAR, 
	PRIMARY KEY (role_id), 
	UNIQUE (role_name)
);
INSERT INTO role VALUES(1,'student');
INSERT INTO role VALUES(2,'professor');
INSERT INTO role VALUES(3,'admin');
CREATE TABLE course (
	course_id INTEGER NOT NULL, 
	course_name VARCHAR NOT NULL, 
	PRIMARY KEY (course_id)
);
INSERT INTO course VALUES(1,'Mathematics');
INSERT INTO course VALUES(2,'Physics');
INSERT INTO course VALUES(3,'Computer Science');
INSERT INTO course VALUES(4,'Chemistry');
INSERT INTO course VALUES(5,'English');
CREATE TABLE user (
	user_id INTEGER NOT NULL, 
	email VARCHAR NOT NULL, 
	password VARCHAR NOT NULL, 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id), 
	UNIQUE (email), 
	FOREIGN KEY(role_id) REFERENCES role (role_id)
);
INSERT INTO user VALUES(1,'admin@college.edu','admin123',3);
INSERT INTO user VALUES(2,'raj.sharma@college.edu','prof123',2);
INSERT INTO user VALUES(3,'priya.patil@college.edu','prof456',2);
INSERT INTO user VALUES(4,'vikram.singh@college.edu','prof789',2);
INSERT INTO user VALUES(5,'anita.reddy@college.edu','prof101',2);
INSERT INTO user VALUES(6,'arjun.kumar@student.college.edu','stu123',1);
INSERT INTO user VALUES(7,'sneha.gupta@student.college.edu','stu456',1);
INSERT INTO user VALUES(8,'rahul.verma@student.college.edu','stu789',1);
INSERT INTO user VALUES(9,'pooja.shah@student.college.edu','stu101',1);
INSERT INTO user VALUES(10,'kiran.naik@student.college.edu','stu112',1);
CREATE TABLE student (
	student_id INTEGER NOT NULL, 
	student_fname VARCHAR NOT NULL, 
	student_lname VARCHAR NOT NULL, 
	student_gender VARCHAR NOT NULL, 
	student_email VARCHAR NOT NULL, 
	student_usn VARCHAR NOT NULL, 
	student_class VARCHAR NOT NULL, 
	user_id INTEGER NOT NULL, 
	PRIMARY KEY (student_id), 
	UNIQUE (student_email), 
	UNIQUE (student_usn), 
	FOREIGN KEY(user_id) REFERENCES user (user_id)
);
INSERT INTO student VALUES(1,'Arjun','Kumar','Male','arjun.kumar@student.college.edu','1RV20CS001','CS-A',6);
INSERT INTO student VALUES(2,'Sneha','Gupta','Female','sneha.gupta@student.college.edu','1RV20CS002','CS-A',7);
INSERT INTO student VALUES(3,'Rahul','Verma','Male','rahul.verma@student.college.edu','1RV20CS003','CS-A',8);
INSERT INTO student VALUES(4,'Pooja','Shah','Female','pooja.shah@student.college.edu','1RV20CS004','CS-A',9);
INSERT INTO student VALUES(5,'Kiran','Naik','Male','kiran.naik@student.college.edu','1RV20CS005','CS-A',10);
CREATE TABLE professor (
	prof_id INTEGER NOT NULL, 
	salutation VARCHAR NOT NULL, 
	prof_fname VARCHAR NOT NULL, 
	prof_lname VARCHAR NOT NULL, 
	prof_email VARCHAR NOT NULL, 
	user_id INTEGER NOT NULL, 
	PRIMARY KEY (prof_id), 
	UNIQUE (prof_email), 
	FOREIGN KEY(user_id) REFERENCES user (user_id)
);
INSERT INTO professor VALUES(1,'Dr.','Raj','Sharma','raj.sharma@college.edu',2);
INSERT INTO professor VALUES(2,'Prof.','Priya','Patil','priya.patil@college.edu',3);
INSERT INTO professor VALUES(3,'Dr.','Vikram','Singh','vikram.singh@college.edu',4);
INSERT INTO professor VALUES(4,'Prof.','Anita','Reddy','anita.reddy@college.edu',5);
CREATE TABLE sc (
	sc_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	PRIMARY KEY (sc_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
INSERT INTO sc VALUES(1,1,1);
INSERT INTO sc VALUES(2,1,2);
INSERT INTO sc VALUES(3,1,3);
INSERT INTO sc VALUES(4,1,4);
INSERT INTO sc VALUES(5,1,5);
INSERT INTO sc VALUES(6,2,1);
INSERT INTO sc VALUES(7,2,2);
INSERT INTO sc VALUES(8,2,3);
INSERT INTO sc VALUES(9,2,4);
INSERT INTO sc VALUES(10,2,5);
INSERT INTO sc VALUES(11,3,1);
INSERT INTO sc VALUES(12,3,2);
INSERT INTO sc VALUES(13,3,3);
INSERT INTO sc VALUES(14,3,4);
INSERT INTO sc VALUES(15,3,5);
INSERT INTO sc VALUES(16,4,1);
INSERT INTO sc VALUES(17,4,2);
INSERT INTO sc VALUES(18,4,3);
INSERT INTO sc VALUES(19,4,4);
INSERT INTO sc VALUES(20,4,5);
INSERT INTO sc VALUES(21,5,1);
INSERT INTO sc VALUES(22,5,2);
INSERT INTO sc VALUES(23,5,3);
INSERT INTO sc VALUES(24,5,4);
INSERT INTO sc VALUES(25,5,5);
CREATE TABLE pc (
	pc_id INTEGER NOT NULL, 
	prof_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	prof_class VARCHAR NOT NULL, 
	PRIMARY KEY (pc_id), 
	FOREIGN KEY(prof_id) REFERENCES professor (prof_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
INSERT INTO pc VALUES(1,1,1,'CS-A');
INSERT INTO pc VALUES(2,1,3,'CS-A');
INSERT INTO pc VALUES(3,2,2,'CS-A');
INSERT INTO pc VALUES(4,3,4,'CS-A');
INSERT INTO pc VALUES(5,4,5,'CS-A');
CREATE TABLE scp (
	scp_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	pc_id INTEGER NOT NULL, 
	PRIMARY KEY (scp_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(pc_id) REFERENCES pc (pc_id)
);
INSERT INTO scp VALUES(1,1,1);
INSERT INTO scp VALUES(2,1,2);
INSERT INTO scp VALUES(3,1,3);
INSERT INTO scp VALUES(4,1,4);
INSERT INTO scp VALUES(5,1,5);
INSERT INTO scp VALUES(6,2,1);
INSERT INTO scp VALUES(7,2,2);
INSERT INTO scp VALUES(8,2,3);
INSERT INTO scp VALUES(9,2,4);
INSERT INTO scp VALUES(10,2,5);
INSERT INTO scp VALUES(11,3,1);
INSERT INTO scp VALUES(12,3,2);
INSERT INTO scp VALUES(13,3,3);
INSERT INTO scp VALUES(14,3,4);
INSERT INTO scp VALUES(15,3,5);
INSERT INTO scp VALUES(16,4,1);
INSERT INTO scp VALUES(17,4,2);
INSERT INTO scp VALUES(18,4,3);
INSERT INTO scp VALUES(19,4,4);
INSERT INTO scp VALUES(20,4,5);
INSERT INTO scp VALUES(21,5,1);
INSERT INTO scp VALUES(22,5,2);
INSERT INTO scp VALUES(23,5,3);
INSERT INTO scp VALUES(24,5,4);
INSERT INTO scp VALUES(25,5,5);
CREATE TABLE timetable (
	timetable_id INTEGER NOT NULL, 
	day VARCHAR NOT NULL, 
	time TIME NOT NULL, 
	pc_id INTEGER NOT NULL, 
	PRIMARY KEY (timetable_id), 
	FOREIGN KEY(pc_id) REFERENCES pc (pc_id)
);
INSERT INTO timetable VALUES(1,'Monday','09:00:00',1);
INSERT INTO timetable VALUES(2,'Monday','10:00:00',2);
INSERT INTO timetable VALUES(3,'Monday','11:00:00',3);
INSERT INTO timetable VALUES(4,'Tuesday','09:00:00',4);
INSERT INTO timetable VALUES(5,'Tuesday','10:00:00',5);
INSERT INTO timetable VALUES(6,'Wednesday','09:00:00',1);
INSERT INTO timetable VALUES(7,'Wednesday','10:00:00',2);
INSERT INTO timetable VALUES(8,'Thursday','09:00:00',3);
INSERT INTO timetable VALUES(9,'Thursday','10:00:00',4);
INSERT INTO timetable VALUES(10,'Friday','09:00:00',5);
CREATE TABLE attendance (
	attendance_id INTEGER NOT NULL, 
	attendance_date DATE, 
	attendance_time TIME, 
	status BOOLEAN, 
	scp_id INTEGER NOT NULL, 
	PRIMARY KEY (attendance_id), 
	FOREIGN KEY(scp_id) REFERENCES scp (scp_id)
);
INSERT INTO attendance VALUES(1,'2024-01-15','09:00:00',1,1);
INSERT INTO attendance VALUES(2,'2024-01-15','09:00:00',1,6);
INSERT INTO attendance VALUES(3,'2024-01-15','09:00:00',0,11);
INSERT INTO attendance VALUES(4,'2024-01-15','09:00:00',1,16);
INSERT INTO attendance VALUES(5,'2024-01-15','09:00:00',1,21);
INSERT INTO attendance VALUES(6,'2024-01-15','10:00:00',1,2);
INSERT INTO attendance VALUES(7,'2024-01-15','10:00:00',0,7);
INSERT INTO attendance VALUES(8,'2024-01-15','10:00:00',1,12);
INSERT INTO attendance VALUES(9,'2024-01-15','10:00:00',1,17);
INSERT INTO attendance VALUES(10,'2024-01-15','10:00:00',1,22);
INSERT INTO attendance VALUES(11,'2024-01-15','11:00:00',1,3);
INSERT INTO attendance VALUES(12,'2024-01-15','11:00:00',1,8);
INSERT INTO attendance VALUES(13,'2024-01-15','11:00:00',1,13);
INSERT INTO attendance VALUES(14,'2024-01-15','11:00:00',0,18);
INSERT INTO attendance VALUES(15,'2024-01-15','11:00:00',1,23);
INSERT INTO attendance VALUES(16,'2024-01-16','09:00:00',1,4);
INSERT INTO attendance VALUES(17,'2024-01-16','09:00:00',1,9);
INSERT INTO attendance VALUES(18,'2024-01-16','09:00:00',1,14);
INSERT INTO attendance VALUES(19,'2024-01-16','09:00:00',1,19);
INSERT INTO attendance VALUES(20,'2024-01-16','09:00:00',0,24);
INSERT INTO attendance VALUES(21,'2024-01-16','10:00:00',0,5);
INSERT INTO attendance VALUES(22,'2024-01-16','10:00:00',1,10);
INSERT INTO attendance VALUES(23,'2024-01-16','10:00:00',1,15);
INSERT INTO attendance VALUES(24,'2024-01-16','10:00:00',1,20);
INSERT INTO attendance VALUES(25,'2024-01-16','10:00:00',1,25);
COMMIT;
