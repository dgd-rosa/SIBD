INSERT INTO Person
VALUES ('Pedro', 'Alentenjo', '56656', '4578');
INSERT INTO Supervisor
VALUES ('Pedro', 'Alentenjo');
INSERT INTO Analyst
VALUES ('Pedro', 'Alentenjo');

INSERT INTO Person
VALUES ('Pedro', 'Lisboa', '654', '2198');
INSERT INTO Analyst
VALUES ('Pedro', 'Lisboa');

INSERT INTO Person
VALUES ('D Rose', 'Forte da Casa', '6+5+6', '259219516');
INSERT INTO Supervisor
VALUES ('D Rose', 'Forte da Casa');
INSERT INTO Analyst
VALUES ('D Rose', 'Forte da Casa');

SELECT *
FROM Supervisor s
         JOIN Person p ON (s.name = p.name AND s.address = p.address);


INSERT INTO Substation
VALUES ('12332', 'Lisbon');
INSERT INTO Supervises
VALUES ('Pedro', 'Alentenjo', '12332');
SELECT *
FROM Supervises sup
         JOIN Supervisor s ON (sup.supervisor_name = s.name AND sup.supervisor_address = s.address)
         JOIN Substation S2 on sup.gps_coords = S2.gps_coords;


INSERT INTO Element
VALUES ('AC-130');
INSERT INTO Incident
VALUES ('Failure in bus bar', '1999-01-08 04:05:06', 'low', 'AC-130');
INSERT INTO Analyses
VALUES ('Pedro', 'Alentenjo', '1999-01-08 04:05:06', 'AC-130', 'Messy execution');


INSERT INTO Incident
VALUES ('Failure in bus bar 2', '1999-01-09 04:05:06', 'low', 'AC-130');
INSERT INTO Analyses
VALUES ('Pedro', 'Lisboa', '1999-01-09 04:05:06', 'AC-130', 'Messy execution');


SELECT *
FROM Analyses a
         JOIN Incident i on (a.instant = i.instant AND a.element_id = i.element_id);
SELECT *
FROM Incident i
         JOIN Element e ON e.id = i.element_id;


INSERT INTO Line_Incident
VALUES ('x: 20, y: 25', '1999-01-09 04:05:06.000000', 'AC-130');
INSERT INTO Line_Incident
VALUES ('x: 20, y: 25', '1999-01-08 04:05:06', 'AC-130');
SELECT *
FROM Line_Incident li
         JOIN Incident i ON (li.element_id = i.element_id AND li.instant = i.instant)
         JOIN Element e ON e.id = i.element_id
         JOIN analyses an ON (an.element_id = e.id AND an.instant = li.instant);



INSERT INTO Line
VALUES (50, 'AC-130');
INSERT INTO Element
VALUES ('B1');
INSERT INTO Element
VALUES ('B2');
INSERT INTO Bus_Bar
VALUES (50, 'B1');
INSERT INTO Bus_Bar
VALUES (70, 'B2');
INSERT INTO Line_Connection
VALUES ('AC-130', 'B1', 'B2');

INSERT INTO Element
VALUES ('T1');
INSERT INTO Transformer
VALUES (50, 80, 'T1');
INSERT INTO Transformer_Connection
VALUES ('T1', 'B1', 'B2');

-- Populating data for the first query
INSERT INTO Element
VALUES ('B-789');
INSERT INTO Bus_Bar
VALUES (70, 'B-789');

INSERT INTO Incident
VALUES ('Failure in bus bar 2', '1999-01-20 04:05:06', 'low', 'B-789');
INSERT INTO Incident
VALUES ('Failure in bus bar 2', '1999-01-21 04:05:06', 'medium', 'B-789');
INSERT INTO Incident
VALUES ('Failure in bus bar 2', '1999-01-22 04:05:06', 'high', 'B-789');

INSERT INTO Analyses
VALUES ('Pedro', 'Alentenjo', '1999-01-20 04:05:06', 'B-789', 'Messy execution');
INSERT INTO Analyses
VALUES ('Pedro', 'Alentenjo', '1999-01-21 04:05:06', 'B-789', 'Messy execution');
INSERT INTO Analyses
VALUES ('D Rose', 'Forte da Casa', '1999-01-22 04:05:06', 'B-789', 'Messy execution');

--inserting data for 3rd query
INSERT INTO element
VALUES ('T-202');
INSERT INTO transformer
VALUES (10, 100, 'T-202');

INSERT INTO element
VALUES ('T-203');
INSERT INTO transformer
VALUES (20, 200, 'T-203');

INSERT INTO element
VALUES ('T-204');
INSERT INTO transformer
VALUES (10, 100, 'T-204');

INSERT INTO substation
VALUES ('10 200 N', 'CHIADO');
INSERT INTO located
VALUES ('T-202','10 200 N');
INSERT INTO located
VALUES ('T-203','10 200 N');
INSERT INTO located
VALUES ('T-204','10 200 N');

INSERT INTO element
VALUES ('T-205');
INSERT INTO transformer
VALUES (10, 100, 'T-205');

INSERT INTO element
VALUES ('T-206');
INSERT INTO transformer
VALUES (10, 100, 'T-206');

INSERT INTO substation
VALUES ('200 Y 202', 'Ourique');
INSERT INTO located
VALUES ('T-205','200 Y 202');
INSERT INTO located
VALUES ('T-206','200 Y 202');

INSERT INTO element
VALUES ('T-207');
INSERT INTO transformer
VALUES (10, 100, 'T-207');

INSERT INTO substation
VALUES ('2110 200', 'New York');
INSERT INTO located
VALUES ('T-207','2110 200');

INSERT INTO substation
VALUES ('2120 100', 'New York');
INSERT INTO substation
VALUES ('4949 100', 'New York');
INSERT INTO substation
VALUES ('6996 100', 'New York');