DROP TABLE IF EXISTS d_reporter cascade;

CREATE TABLE d_reporter
(
    id_reporter SERIAL,
    name        VARCHAR(80),
    address     VARCHAR(80),
    PRIMARY KEY (id_reporter)
);

INSERT INTO d_reporter(name, address)
SELECT name, address
FROM analyses;


DROP TABLE IF EXISTS d_time cascade;

CREATE TABLE d_time
(
    id_time   SERIAL,
    day       INTEGER,
    week_day  INTEGER,
    week      INTEGER,
    month     INTEGER,
    trimester INTEGER,
    year      INTEGER,
    PRIMARY KEY (id_time)
);

INSERT INTO d_time(day, week_day, week, month, trimester, year)
SELECT EXTRACT(DAY FROM instant),
       EXTRACT(DOW FROM instant),
       EXTRACT(WEEK FROM instant),
       EXTRACT(MONTH FROM instant),
       EXTRACT(QUARTER FROM instant),
       EXTRACT(YEAR FROM instant)
FROM incident;


DROP TABLE IF EXISTS d_location cascade;

CREATE TABLE d_location
(
    id_location SERIAL,
    latitude    NUMERIC(9, 6),
    longitude   NUMERIC(9, 6),
    locality    VARCHAR(80),
    PRIMARY KEY (id_location)
);

INSERT INTO d_location(latitude, longitude, locality)
SELECT s.gpslat, s.gpslong, s.locality
FROM incident i
         JOIN transformer t ON i.id = t.id
         LEFT JOIN substation s on t.gpslat = s.gpslat and t.gpslong = s.gpslong;


DROP TABLE IF EXISTS d_element cascade;

CREATE TABLE d_element
(
    id_element   SERIAL,
    element_id   VARCHAR(10),
    element_type VARCHAR(50),
    PRIMARY KEY (id_element)
);

INSERT INTO d_element(element_id, element_type)
SELECT b.id, 'BUSBAR'
FROM incident i
         JOIN busbar b ON i.id = b.id
UNION
SELECT t.id, 'TRANSFORMER'
FROM incident i
         JOIN transformer t ON i.id = t.id
UNION
SELECT l.id, 'LINE'
FROM incident i
         JOIN line l ON i.id = l.id;


DROP TABLE IF EXISTS f_incident cascade;

CREATE TABLE f_incident
(
    id_reporter INTEGER,
    id_time     INTEGER,
    id_location INTEGER,
    id_element  INTEGER,
    severity    VARCHAR(30),
    PRIMARY KEY (id_reporter, id_time, id_location, id_element),
    FOREIGN KEY (id_reporter) REFERENCES d_reporter (id_reporter),
    FOREIGN KEY (id_time) REFERENCES d_time (id_time),
    FOREIGN KEY (id_location) REFERENCES d_location (id_location),
    FOREIGN KEY (id_element) REFERENCES d_element (id_element)
);

INSERT INTO f_incident(id_reporter, id_time, id_location, id_element, severity)
SELECT dr.id_reporter, dt.id_time, dl.id_location, e.id_element, i.severity
FROM incident i
         JOIN d_element e ON i.id = e.element_id
         JOIN analyses a on i.instant = a.instant and i.id = a.id
         JOIN d_reporter dr ON a.address = dr.address
         JOIN transformer t ON i.id = t.id
         JOIN d_location dl ON t.gpslong = dl.longitude AND t.gpslat = dl.latitude
         JOIN d_time dt ON make_date(dt.year, dt.month, dt.day) = date(i.instant);








