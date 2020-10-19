-- eid must appear in either freelancer or permanent
CREATE TABLE Employee 
(
	name VARCHAR(80) NOT NULL,
	bdate DATE NOT NULL,
	eid INTEGER NOT NULL,
	PRIMARY KEY(eid)
);

CREATE TABLE Department 
(
	name VARCHAR(200) NOT NULL,
	budget NUMERIC(16,4) NOT NULL,
	did INTEGER NOT NULL,
	PRIMARY KEY(did)
);

CREATE TABLE WorksAt
(
	eid INTEGER NOT NULL,
	did INTEGER NOT NULL,
	since DATE NOT NULL,
	PRIMARY KEY(eid),
	FOREIGN KEY (did) REFERENCES Department(did),
	FOREIGN KEY (eid) REFERENCES Employee(eid)
);

-- eid must not appear in permanent
-- If there are multiple restrictions we do "eid,job must not appear in permanent"
CREATE TABLE Freelancer 
(
	job VARCHAR(80) NOT NULL,
	hour_rate NUMERIC(16,4) NOT NULL,
	eid INTEGER NOT NULL,
	FOREIGN KEY (eid) REFERENCES Employee(eid),
	PRIMARY KEY (eid)
);

-- eid must not appear in freelancer
CREATE TABLE Permanent 
(
	speciality VARCHAR(80) NOT NULL,
	eid INTEGER NOT NULL,
	FOREIGN KEY (eid) REFERENCES Employee(eid),
	PRIMARY KEY (eid)
);

CREATE TABLE Contract 
(
	salary NUMERIC(16,4) NOT NULL,
	role VARCHAR(80) NOT NULL,
	eid INTEGER NOT NULL,
	PRIMARY KEY(eid, role),
	FOREIGN KEY (eid) REFERENCES Permanent(eid)
);

-- DIAGRAM 2

CREATE TABLE Car 
(
	license CHAR(10),
	...
	PRIMARY KEY(license)
);

CREATE TABLE Person(
	driver_id VARCHAR(10),
	...
	PRIMARY KEY(driver_id),
);

CREATE TABLE Accident(
	report_id INTEGER,
	...
	PRIMARY KEY (report_id)
);

CREATE TABLE involved_in
(
	license CHAR(10) NOT NULL,
	driver_id VARCHAR(10) NOT NULL,
	report_id INTEGER NOT NULL,
	damage_total NUMERIC(16,4) NOT NULL,
	FOREIGN KEY (license) REFERENCES Car(license),
	FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
	FOREIGN KEY (report_id) REFERENCES Accident(report_id),
	PRIMARY KEY(driver_id, license, report_id)
);

-- DIAGRAM 3

-- Every program must appear in the table 'comprise' at least once
CREATE TABLE program( 
	program_name VARCHAR(80) NOT NULL,
	PRIMARY KEY(program_name)
);

...

CREATE TABLE course(
	courseno smallint,
	credits NUMERIC(2,1) NOT NULL,
	title VARCHAR(80) NOT NULL,
	syllabus text NOT NULL,
	PRIMARY KEY(courseno)
);

CREATE TABLE Requires
(
	pre_requisite smallint,
	main_course smallint,
	FOREIGN KEY(license) REFERENCES Course(courseno),
	FOREIGN KEY(main_course) REFERENCES Course(courseno),
	CHECK(main_course <> pre_requisite) -- This should throw a warning, says they are both different
	PRIMARY KEY(pre_requisite, main_course) 
);

-- Diagram 4

CREATE TABLE contract(
	tin VARCHAR(30),
	lab_name VARCHAR(200),
	start_DATE DATE NOT NULL,
	end_DATE DATE NOT NULL,
	agreement text NOT NULL,
	PRIMARY KEY(tin, lab_name),
	FOREIGN KEY(tin) REFERENCES pharmacy(tin),
	FOREIGN KEY(lab_name) REFERENCES laboratory(lab_name)
);

CREATE TABLE supervisor(
	name VARCHAR(80),
	PRIMARY KEY(name)
);

CREATE TABLE supervises(
	tin VARCHAR(30),
	lab_name VARCHAR(200),
	name VARCHAR(80),
	PRIMARY KEY(name, lab_name, tin),
	FOREIGN KEY(name) REFERENCES supervisor(name),
	FOREIGN KEY(lab_name, tin) REFERENCES contract(lab_name, tin)
);

-- Diagram 5

CREATE TABLE musician( -- not final form
	ssn INTEGER	UNIQUE NOT NULL, 
	mobile VARCHAR(15) UNIQUE NOT NULL, 
	PRIMARY KEY(ssn),
);


CREATE TABLE album(
	id INTEGER NOT NULL,
	release_date DATE NOT NULL,
	title VARCHAR(255) NOT NULL,
	ssn INTEGER	NOT NULL,
	PRIMARY KEY(id)
	FOREIGN KEY(ssm) REFERENCES musician(ssn)
);


