-- Person must appear in either supervisor and/or analyst

DROP TABLE IF EXISTS Person CASCADE;
DROP TABLE IF EXISTS Supervisor CASCADE;
DROP TABLE IF EXISTS Substation CASCADE;
DROP TABLE IF EXISTS Supervises CASCADE;
DROP TABLE IF EXISTS Analyst CASCADE;
DROP TABLE IF EXISTS Element CASCADE;
DROP TABLE IF EXISTS Incident CASCADE;
DROP TABLE IF EXISTS Analyses CASCADE;
DROP TABLE IF EXISTS Line_Incident CASCADE;
DROP TABLE IF EXISTS Line CASCADE;
DROP TABLE IF EXISTS Bus_Bar CASCADE;
DROP TABLE IF EXISTS Transformer CASCADE;
DROP TABLE IF EXISTS Line_Connection CASCADE;
DROP TABLE IF EXISTS Transformer_Connection CASCADE;
DROP TABLE IF EXISTS Located CASCADE;
DROP TYPE IF EXISTS Severity CASCADE;


CREATE TABLE Person
(
    name    VARCHAR(100)        NOT NULL,
    address VARCHAR(100)        NOT NULL,
    phone   VARCHAR(15) UNIQUE  NOT NULL,
    tax_id  VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (name, address)
);

-- Persons cannot analyse incidents regarding Elements of a Substation they supervises
CREATE TABLE Supervisor
(
    name    VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    PRIMARY KEY (name, address),
    FOREIGN KEY (name, address) REFERENCES Person (name, address)
);


CREATE TABLE Substation
(
    gps_coords    VARCHAR(100) NOT NULL, -- TODO(use point or coordinates data type instead of varchar)
    locality_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (gps_coords)
);


CREATE TABLE Supervises
(
    supervisor_name    VARCHAR(100) NOT NULL,
    supervisor_address VARCHAR(100) NOT NULL,
    gps_coords         VARCHAR(100) NOT NULL,
    PRIMARY KEY (gps_coords),
    FOREIGN KEY (gps_coords) REFERENCES Substation (gps_coords),
    FOREIGN KEY (supervisor_name, supervisor_address) REFERENCES Supervisor (name, address)
);

-- Persons cannot analyse incidents regarding Elements of a Substation they supervises
CREATE TABLE Analyst
(
    name    VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    PRIMARY KEY (name, address),
    FOREIGN KEY (name, address) REFERENCES Person (name, address)
);

CREATE TYPE Severity AS ENUM ('low', 'medium', 'high');

-- Element must appear in either line, bus bar or transformer
CREATE TABLE Element
(
    id VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE Incident
(
    description VARCHAR(100) NOT NULL,
    instant     TIMESTAMP    NOT NULL,
    severity    Severity     NOT NULL,
    element_id  VARCHAR(20)  NOT NULL, -- Instead of refers_to. TODO(verify if it need to be changed)
    PRIMARY KEY (instant, element_id),
    FOREIGN KEY (element_id) REFERENCES Element (id)
);


CREATE TABLE Analyses
(
    analyst_name    VARCHAR(100),
    analyst_address VARCHAR(100),
    instant         TIMESTAMP    NOT NULL,
    element_id      VARCHAR(20)  NOT NULL,
    report          VARCHAR(100) NOT NULL,
    PRIMARY KEY (instant, element_id),
    FOREIGN KEY (analyst_name, analyst_address) references Analyst (name, address),
    FOREIGN KEY (instant, element_id) REFERENCES Incident (instant, element_id)
);


CREATE TABLE Line_Incident
(
    point      VARCHAR(100) NOT NULL,
    instant    TIMESTAMP    NOT NULL,
    element_id VARCHAR(20)  NOT NULL,
    PRIMARY KEY (instant, element_id),
    FOREIGN KEY (instant, element_id) REFERENCES Incident (instant, element_id)
);


CREATE TABLE Line
(
    impedance  INTEGER NOT NULL,
    element_id VARCHAR(20),
    PRIMARY KEY (element_id),
    FOREIGN KEY (element_id) REFERENCES Element (id)
);

CREATE TABLE Bus_Bar
(
    voltage    INTEGER NOT NULL,
    element_id VARCHAR(20),
    PRIMARY KEY (element_id),
    FOREIGN KEY (element_id) REFERENCES Element (id)
);


CREATE TABLE Transformer
(
    primary_voltage   INTEGER NOT NULL,
    secondary_voltage INTEGER NOT NULL,
    element_id        VARCHAR(20),
    PRIMARY KEY (element_id),
    FOREIGN KEY (element_id) REFERENCES Element (id)
);

CREATE TABLE Line_Connection
(
    line_id      VARCHAR(20) NOT NULL,
    bus_bar_1_id VARCHAR(20),
    bus_bar_2_id VARCHAR(20) CHECK ( bus_bar_1_id != bus_bar_2_id ),
    PRIMARY KEY (line_id, bus_bar_1_id, bus_bar_2_id),
    FOREIGN KEY (line_id) REFERENCES Line (element_id),
    FOREIGN KEY (bus_bar_1_id) REFERENCES Bus_Bar (element_id),
    FOREIGN KEY (bus_bar_2_id) REFERENCES Bus_Bar (element_id)
);


-- The voltage of the primary Bus Bar must match the primary voltage of the Transformer to which the Bus Bar is connected
-- The voltage of the secondary Bus Bar must match the secondary voltage of the Transformer to which the Bus Bar is connected
CREATE TABLE Transformer_Connection
(
    transformer_id VARCHAR(20) NOT NULL,
    bus_bar_1_id   VARCHAR(20),
    bus_bar_2_id   VARCHAR(20) CHECK ( bus_bar_1_id != bus_bar_2_id ),
    PRIMARY KEY (transformer_id, bus_bar_1_id, bus_bar_2_id),
    FOREIGN KEY (transformer_id) REFERENCES Transformer (element_id),
    FOREIGN KEY (bus_bar_1_id) REFERENCES Bus_Bar (element_id),
    FOREIGN KEY (bus_bar_2_id) REFERENCES Bus_Bar (element_id)
);


CREATE TABLE Located
(
    transformer_id VARCHAR(20) NOT NULL,
    gps_coords     VARCHAR(100),
    PRIMARY KEY (transformer_id),
    FOREIGN KEY (transformer_id) REFERENCES Transformer (element_id),
    FOREIGN KEY (gps_coords) REFERENCES Substation (gps_coords)
);
