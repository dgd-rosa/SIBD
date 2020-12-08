-- Create person
INSERT INTO person VALUES ('D Rose', 'Forte da casa', 8779, 1);
INSERT INTO person VALUES ('D Rose', 'Porto covo', 8789, 2);
INSERT INTO person VALUES ('Peter Warrior', 'Ourique', 8788, 3);
INSERT INTO person VALUES ('Peter Warrior', 'Lisboa', 8778, 4);
INSERT INTO person VALUES ('First Month', 'Lisbon', 456465, 5);
INSERT INTO person VALUES ('First Month', 'Olhao', 456965, 6);
INSERT INTO person VALUES ('Ronaldo', 'Porto Santo', 98193, 1235);
INSERT INTO person VALUES ('Duarte', 'Tomar', 919193, 324);

-- Create supervisor
INSERT INTO supervisor VALUES ('D Rose', 'Porto covo');
INSERT INTO supervisor VALUES ('Peter Warrior', 'Ourique');
INSERT INTO supervisor VALUES ('First Month', 'Lisbon');
INSERT INTO supervisor VALUES ('Ronaldo', 'Porto Santo');
INSERT INTO supervisor VALUES ('Duarte', 'Tomar');

-- Create analyst
INSERT INTO analyst VALUES ('First Month', 'Lisbon');
INSERT INTO analyst VALUES ('D Rose', 'Forte da casa');
INSERT INTO analyst VALUES ('D Rose', 'Porto covo');
INSERT INTO analyst VALUES ('Peter Warrior', 'Ourique');


-- Create substation
INSERT INTO substation VALUES (5, 5, 'Lisbon', 'D Rose', 'Porto covo');
INSERT INTO substation VALUES (51, 52, 'Lisbon', 'D Rose', 'Porto covo');
INSERT INTO substation VALUES (89, 40, 'Alentejo', 'Peter Warrior', 'Ourique');
INSERT INTO substation VALUES (39.336775, -8.936379, 'Rio Maior', 'First Month', 'Lisbon');
INSERT INTO substation VALUES (42.336775, -8.936379, 'NORTH', 'First Month', 'Lisbon');
INSERT INTO substation VALUES (23, 34, 'Terra do Sol', 'Ronaldo', 'Porto Santo');


-- Create element
    -- Bus bar
INSERT INTO element VALUES ('B-789');
INSERT INTO element VALUES ('B-2');
INSERT INTO element VALUES ('B-3');
INSERT INTO element VALUES ('B-4');
    -- Transformer
INSERT INTO element VALUES ('T-1');
INSERT INTO element VALUES ('T-2');
INSERT INTO element VALUES ('T-3');
    -- Line
INSERT INTO element VALUES ('L-1');
INSERT INTO element VALUES ('L-2');
INSERT INTO element VALUES ('L-3');


-- Create bus bar
INSERT INTO busbar VALUES ('B-789', 50);
INSERT INTO busbar VALUES ('B-2', 50);
INSERT INTO busbar VALUES ('B-3', 70);
INSERT INTO busbar VALUES ('B-4', 80);

-- Create transformer
INSERT INTO transformer VALUES ('T-1', 70, 50, 5, 5, 'B-789', 'B-2'); -- The voltage value pv does not correspond to the bus bar value
INSERT INTO transformer VALUES ('T-3', 50, 60, 89, 40, 'B-789', 'B-2'); -- The voltage value sv does not correspond to the bus bar value
INSERT INTO transformer VALUES ('T-2', 50, 80, 51, 52, 'B-2', 'B-4'); -- The voltage values correspond to the bus bar values
INSERT INTO transformer VALUES ('T-1', 50, 50, 5, 5, 'B-789', 'B-2');

-- Create line
INSERT INTO line VALUES ('L-1', 100, 'B-3', 'B-789');
INSERT INTO line VALUES ('L-2', 800, 'B-4', 'B-2');

-- Create incident
INSERT INTO incident VALUES ('1999-01-20 04:05:06', 'L-1', 'Line broke down', 'low');
INSERT INTO incident VALUES ('1999-01-21 04:05:06', 'B-789', 'Bus bar is not working', 'low');
INSERT INTO incident VALUES ('1999-01-21 05:05:06', 'B-789', 'Bus bar is not working', 'high');
-- INSERT INTO incident VALUES ('2020-01-21 05:05:06', 'B-789', 'Bus bar is not working', 'high');
INSERT INTO incident VALUES ('2021-01-21 04:05:06', 'T-1', 'Transformer broke', 'high');
INSERT INTO incident VALUES ('2021-01-21 04:01:06', 'T-1', 'Transformer broke', 'high');
INSERT INTO incident VALUES ('2021-01-21 14:05:06', 'T-1', 'Transformer broke', 'high');

-- Create line incident
INSERT INTO lineincident VALUES ('1999-01-20 04:05:06', 'L-1', '555.05');

-- Create analyses
INSERT INTO analyses VALUES ('2021-01-21 04:05:06', 'T-1', 'Transformer does not work', 'D Rose', 'Porto covo'); -- Gives error due to 3rd trigger
INSERT INTO analyses VALUES ('1999-01-20 04:05:06', 'L-1', 'Line was not easy to fix', 'First Month', 'Lisbon');
INSERT INTO analyses VALUES ('1999-01-21 04:05:06', 'B-789', 'Bus bar was impossible to fix', 'D Rose', 'Forte da casa');
INSERT INTO analyses VALUES ('1999-01-21 05:05:06', 'B-789', 'Bus bar was impossible to fix', 'D Rose', 'Forte da casa');
-- INSERT INTO analyses VALUES ('2020-01-21 05:05:06', 'B-789', 'Bus bar was impossible to fix', 'Peter Warrior', 'Ourique');


-- Values for testing the indexes

INSERT INTO element VALUES('T-5');
INSERT INTO substation VALUES(20,15,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-5',50,50,20,15,'B-789', 'B-2');
INSERT INTO element VALUES('T-6');
INSERT INTO substation VALUES(24,18,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-6',50,50,24,18,'B-789', 'B-2');
INSERT INTO element VALUES('T-7');
INSERT INTO substation VALUES(28,21,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-7',50,50,28,21,'B-789', 'B-2');
INSERT INTO element VALUES('T-8');
INSERT INTO substation VALUES(32,24,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-8',50,50,32,24,'B-789', 'B-2');
INSERT INTO element VALUES('T-9');
INSERT INTO substation VALUES(36,27,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-9',50,50,36,27,'B-789', 'B-2');
INSERT INTO element VALUES('T-10');
INSERT INTO substation VALUES(40,30,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-10',50,50,40,30,'B-789', 'B-2');
INSERT INTO element VALUES('T-11');
INSERT INTO substation VALUES(44,33,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-11',50,50,44,33,'B-789', 'B-2');
INSERT INTO element VALUES('T-12');
INSERT INTO substation VALUES(48,36,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-12',50,50,48,36,'B-789', 'B-2');
INSERT INTO element VALUES('T-13');
INSERT INTO substation VALUES(52,39,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-13',50,50,52,39,'B-789', 'B-2');
INSERT INTO element VALUES('T-14');
INSERT INTO substation VALUES(56,42,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-14',50,50,56,42,'B-789', 'B-2');
INSERT INTO element VALUES('T-15');
INSERT INTO substation VALUES(60,45,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-15',50,50,60,45,'B-789', 'B-2');
INSERT INTO element VALUES('T-16');
INSERT INTO substation VALUES(64,48,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-16',50,50,64,48,'B-789', 'B-2');
INSERT INTO element VALUES('T-17');
INSERT INTO substation VALUES(68,51,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-17',50,50,68,51,'B-789', 'B-2');
INSERT INTO element VALUES('T-18');
INSERT INTO substation VALUES(72,54,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-18',50,50,72,54,'B-789', 'B-2');
INSERT INTO element VALUES('T-19');
INSERT INTO substation VALUES(76,57,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-19',50,50,76,57,'B-789', 'B-2');
INSERT INTO element VALUES('T-20');
INSERT INTO substation VALUES(80,60,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-20',50,50,80,60,'B-789', 'B-2');
INSERT INTO element VALUES('T-21');
INSERT INTO substation VALUES(84,63,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-21',50,50,84,63,'B-789', 'B-2');
INSERT INTO element VALUES('T-22');
INSERT INTO substation VALUES(88,66,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-22',50,50,88,66,'B-789', 'B-2');
INSERT INTO element VALUES('T-23');
INSERT INTO substation VALUES(92,69,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-23',50,50,92,69,'B-789', 'B-2');
INSERT INTO element VALUES('T-24');
INSERT INTO substation VALUES(96,72,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-24',50,50,96,72,'B-789', 'B-2');
INSERT INTO element VALUES('T-25');
INSERT INTO substation VALUES(100,75,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-25',50,50,100,75,'B-789', 'B-2');
INSERT INTO element VALUES('T-26');
INSERT INTO substation VALUES(104,78,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-26',50,50,104,78,'B-789', 'B-2');
INSERT INTO element VALUES('T-27');
INSERT INTO substation VALUES(108,81,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-27',50,50,108,81,'B-789', 'B-2');
INSERT INTO element VALUES('T-28');
INSERT INTO substation VALUES(112,84,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-28',50,50,112,84,'B-789', 'B-2');
INSERT INTO element VALUES('T-29');
INSERT INTO substation VALUES(116,87,'Atlantida','Ronaldo', 'Porto Santo');
INSERT INTO transformer VALUES('T-29',50,50,116,87,'B-789', 'B-2');
INSERT INTO element VALUES('T-30');
INSERT INTO substation VALUES(120,90,'Porto','D Rose', 'Porto covo');
INSERT INTO transformer VALUES('T-30',50,50,120,90,'B-789', 'B-2');
INSERT INTO element VALUES('T-31');
INSERT INTO substation VALUES(124,93,'Porto','D Rose', 'Porto covo');
INSERT INTO transformer VALUES('T-31',50,50,124,93,'B-789', 'B-2');
INSERT INTO element VALUES('T-32');
INSERT INTO substation VALUES(128,96,'Porto','D Rose', 'Porto covo');
INSERT INTO transformer VALUES('T-32',50,50,128,96,'B-789', 'B-2');
INSERT INTO element VALUES('T-33');
INSERT INTO substation VALUES(132,99,'Porto','D Rose', 'Porto covo');
INSERT INTO transformer VALUES('T-33',50,50,132,99,'B-789', 'B-2');
INSERT INTO element VALUES('T-34');