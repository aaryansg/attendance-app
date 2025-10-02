PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE role (
	role_id INTEGER NOT NULL, 
	role_name VARCHAR, 
	PRIMARY KEY (role_id), 
	UNIQUE (role_name)
);
INSERT INTO role VALUES(1,'admin');
INSERT INTO role VALUES(2,'professor');
INSERT INTO role VALUES(3,'student');
CREATE TABLE course (
	course_id INTEGER NOT NULL, 
	course_name VARCHAR NOT NULL, 
	PRIMARY KEY (course_id)
);
INSERT INTO course VALUES(1,'Mathematics');
INSERT INTO course VALUES(2,'Physics');
INSERT INTO course VALUES(3,'Computer Science');
INSERT INTO course VALUES(4,'Electrical Engineering');
INSERT INTO course VALUES(5,'Mechanical Engineering');
CREATE TABLE user (
	user_id INTEGER NOT NULL, 
	email VARCHAR NOT NULL, 
	password VARCHAR NOT NULL, 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id), 
	UNIQUE (email), 
	FOREIGN KEY(role_id) REFERENCES role (role_id)
);
INSERT INTO user VALUES(1,'admin@college.edu','admin123',1);
INSERT INTO user VALUES(2,'rajesh.sharma@college.edu','prof123',2);
INSERT INTO user VALUES(3,'priya.patel@college.edu','prof123',2);
INSERT INTO user VALUES(4,'vikram.singh@college.edu','prof123',2);
INSERT INTO user VALUES(5,'anita.reddy@college.edu','prof123',2);
INSERT INTO user VALUES(6,'arjun.kumar@college.edu','student123',3);
INSERT INTO user VALUES(7,'sneha.gupta@college.edu','student123',3);
INSERT INTO user VALUES(8,'rahul.verma@college.edu','student123',3);
INSERT INTO user VALUES(9,'priyanka.mishra@college.edu','student123',3);
INSERT INTO user VALUES(10,'kiran.joshi@college.edu','student123',3);
CREATE TABLE student (
	student_id INTEGER NOT NULL, 
	student_fname VARCHAR NOT NULL, 
	student_lname VARCHAR NOT NULL, 
	student_gender VARCHAR NOT NULL, 
	student_email VARCHAR NOT NULL, 
	student_usn VARCHAR NOT NULL, 
	user_id INTEGER NOT NULL, 
	PRIMARY KEY (student_id), 
	UNIQUE (student_email), 
	UNIQUE (student_usn), 
	FOREIGN KEY(user_id) REFERENCES user (user_id)
);
INSERT INTO student VALUES(1,'Arjun','Kumar','Male','arjun.kumar@college.edu','1RV20CS001',6);
INSERT INTO student VALUES(2,'Sneha','Gupta','Female','sneha.gupta@college.edu','1RV20CS002',7);
INSERT INTO student VALUES(3,'Rahul','Verma','Male','rahul.verma@college.edu','1RV20CS003',8);
INSERT INTO student VALUES(4,'Priyanka','Mishra','Female','priyanka.mishra@college.edu','1RV20CS004',9);
INSERT INTO student VALUES(5,'Kiran','Joshi','Male','kiran.joshi@college.edu','1RV20CS005',10);
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
INSERT INTO professor VALUES(1,'Dr.','Rajesh','Sharma','rajesh.sharma@college.edu',2);
INSERT INTO professor VALUES(2,'Prof.','Priya','Patel','priya.patel@college.edu',3);
INSERT INTO professor VALUES(3,'Dr.','Vikram','Singh','vikram.singh@college.edu',4);
INSERT INTO professor VALUES(4,'Prof.','Anita','Reddy','anita.reddy@college.edu',5);
INSERT INTO professor VALUES(5,'Dr.','Sanjay','Mehta','sanjay.mehta@college.edu',11);
CREATE TABLE scp (
	scp_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	prof_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	PRIMARY KEY (scp_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(prof_id) REFERENCES professor (prof_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
INSERT INTO scp VALUES(1,1,1,1);
INSERT INTO scp VALUES(2,1,1,3);
INSERT INTO scp VALUES(3,2,2,2);
INSERT INTO scp VALUES(4,2,3,3);
INSERT INTO scp VALUES(5,3,1,1);
INSERT INTO scp VALUES(6,3,4,4);
INSERT INTO scp VALUES(7,4,3,3);
INSERT INTO scp VALUES(8,4,5,5);
INSERT INTO scp VALUES(9,5,2,2);
INSERT INTO scp VALUES(10,5,5,5);
CREATE TABLE sc (
	sc_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	PRIMARY KEY (sc_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
INSERT INTO sc VALUES(1,1,1);
INSERT INTO sc VALUES(2,1,3);
INSERT INTO sc VALUES(3,2,2);
INSERT INTO sc VALUES(4,2,3);
INSERT INTO sc VALUES(5,3,1);
INSERT INTO sc VALUES(6,3,4);
INSERT INTO sc VALUES(7,4,3);
INSERT INTO sc VALUES(8,4,5);
INSERT INTO sc VALUES(9,5,2);
INSERT INTO sc VALUES(10,5,5);
CREATE TABLE pc (
	pc_id INTEGER NOT NULL, 
	prof_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	PRIMARY KEY (pc_id), 
	FOREIGN KEY(prof_id) REFERENCES professor (prof_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
INSERT INTO pc VALUES(1,1,1);
INSERT INTO pc VALUES(2,1,3);
INSERT INTO pc VALUES(3,2,2);
INSERT INTO pc VALUES(4,3,3);
INSERT INTO pc VALUES(5,4,4);
INSERT INTO pc VALUES(6,5,5);
CREATE TABLE attendance (
	attendance_id INTEGER NOT NULL, 
	attendance_date DATE, 
	status BOOLEAN, 
	scp_id INTEGER NOT NULL, 
	PRIMARY KEY (attendance_id), 
	FOREIGN KEY(scp_id) REFERENCES scp (scp_id)
);
INSERT INTO attendance VALUES(1,'2024-01-15',1,1);
INSERT INTO attendance VALUES(2,'2024-01-15',0,2);
INSERT INTO attendance VALUES(3,'2024-01-15',1,3);
INSERT INTO attendance VALUES(4,'2024-01-15',1,4);
INSERT INTO attendance VALUES(5,'2024-01-15',0,5);
INSERT INTO attendance VALUES(6,'2024-01-16',1,1);
INSERT INTO attendance VALUES(7,'2024-01-16',1,2);
INSERT INTO attendance VALUES(8,'2024-01-16',0,3);
INSERT INTO attendance VALUES(9,'2024-01-16',1,4);
INSERT INTO attendance VALUES(10,'2024-01-16',1,5);
CREATE TABLE timetable (
	timetable_id INTEGER NOT NULL, 
	day VARCHAR NOT NULL, 
	time TIME NOT NULL, 
	pc_id INTEGER NOT NULL, 
	PRIMARY KEY (timetable_id), 
	FOREIGN KEY(pc_id) REFERENCES pc (pc_id)
);
INSERT INTO timetable VALUES(1,'Monday','09:00:00',1);
INSERT INTO timetable VALUES(2,'Monday','10:00:00',3);
INSERT INTO timetable VALUES(3,'Tuesday','09:00:00',2);
INSERT INTO timetable VALUES(4,'Tuesday','11:00:00',4);
INSERT INTO timetable VALUES(5,'Wednesday','10:00:00',5);
INSERT INTO timetable VALUES(6,'Wednesday','14:00:00',6);
INSERT INTO timetable VALUES(7,'Thursday','09:00:00',1);
INSERT INTO timetable VALUES(8,'Thursday','11:00:00',3);
INSERT INTO timetable VALUES(9,'Friday','10:00:00',2);
INSERT INTO timetable VALUES(10,'Friday','15:00:00',6);
COMMIT;
