CREATE TABLE role (
	role_id INTEGER NOT NULL, 
	role_name VARCHAR, 
	PRIMARY KEY (role_id), 
	UNIQUE (role_name)
);
CREATE TABLE course (
	course_id INTEGER NOT NULL, 
	course_name VARCHAR NOT NULL, 
	PRIMARY KEY (course_id)
);
CREATE TABLE user (
	user_id INTEGER NOT NULL, 
	email VARCHAR NOT NULL, 
	password VARCHAR NOT NULL, 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id), 
	UNIQUE (email), 
	FOREIGN KEY(role_id) REFERENCES role (role_id)
);
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
CREATE TABLE sc (
	sc_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	PRIMARY KEY (sc_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
CREATE TABLE pc (
	pc_id INTEGER NOT NULL, 
	prof_id INTEGER NOT NULL, 
	course_id INTEGER NOT NULL, 
	prof_class VARCHAR NOT NULL, 
	PRIMARY KEY (pc_id), 
	FOREIGN KEY(prof_id) REFERENCES professor (prof_id), 
	FOREIGN KEY(course_id) REFERENCES course (course_id)
);
CREATE TABLE scp (
	scp_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	pc_id INTEGER NOT NULL, 
	PRIMARY KEY (scp_id), 
	FOREIGN KEY(student_id) REFERENCES student (student_id), 
	FOREIGN KEY(pc_id) REFERENCES pc (pc_id)
);
CREATE TABLE timetable (
	timetable_id INTEGER NOT NULL, 
	day VARCHAR NOT NULL, 
	time TIME NOT NULL, 
	pc_id INTEGER NOT NULL, 
	PRIMARY KEY (timetable_id), 
	FOREIGN KEY(pc_id) REFERENCES pc (pc_id)
);
CREATE TABLE attendance (
	attendance_id INTEGER NOT NULL, 
	attendance_date DATE, 
	attendance_time TIME, 
	status BOOLEAN, 
	scp_id INTEGER NOT NULL, 
	PRIMARY KEY (attendance_id), 
	FOREIGN KEY(scp_id) REFERENCES scp (scp_id)
);
