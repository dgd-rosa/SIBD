DROP TABLE IF EXISTS d_reporter cascade;
DROP TABLE IF EXISTS d_time cascade;
DROP TABLE IF EXISTS d_location cascade;
DROP TABLE IF EXISTS d_element cascade;
DROP TABLE IF EXISTS f_incident cascade;

CREATE TABLE d_reporter
(
    id_reporter SERIAL,
    name        VARCHAR(80),
    address     VARCHAR(80),
    PRIMARY KEY (id_reporter)
);

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

CREATE TABLE d_location
(
    id_location SERIAL,
    latitude    NUMERIC(9, 6),
    longitude   NUMERIC(9, 6),
    locality    VARCHAR(80),
    PRIMARY KEY (id_location)
);

CREATE TABLE d_element
(
    id_element   SERIAL,
    element_id   VARCHAR(10),
    element_type VARCHAR(50),
    PRIMARY KEY (id_element)
);

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









