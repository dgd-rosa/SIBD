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
--INSERT INTO transformer VALUES ('T-1', 70, 50, 5, 5, 'B-789', 'B-2'); -- The voltage value pv does not correspond to the bus bar value
--INSERT INTO transformer VALUES ('T-3', 50, 60, 89, 40, 'B-789', 'B-2'); -- The voltage value sv does not correspond to the bus bar value
INSERT INTO transformer VALUES ('T-1', 50, 50, 5, 5, 'B-789', 'B-2');
INSERT INTO transformer VALUES ('T-2', 50, 80, 51, 52, 'B-2', 'B-4'); -- The voltage values correspond to the bus bar values

-- Create line
INSERT INTO line VALUES ('L-1', 100, 'B-3', 'B-789');
INSERT INTO line VALUES ('L-2', 800, 'B-4', 'B-2');

-- Create incident
INSERT INTO incident VALUES ('1999-01-20 04:05:06', 'L-1', 'Line broke down', 'low');
INSERT INTO incident VALUES ('1999-01-22 04:05:06', 'L-1', 'Line broke down', 'low');
INSERT INTO incident VALUES ('1999-01-25 04:05:06', 'B-789', 'Bus bar is not working', 'low');
-- INSERT INTO incident VALUES ('1999-01-21 05:05:06', 'B-789', 'Bus bar is not working', 'high');
INSERT INTO incident VALUES ('2020-01-21 05:05:06', 'B-789', 'Bus bar is not working', 'high');
INSERT INTO incident VALUES ('2021-03-21 04:05:06', 'T-1', 'Transformer broke', 'high');
INSERT INTO incident VALUES ('2021-04-21 04:01:06', 'T-1', 'Transformer broke', 'high');
INSERT INTO incident VALUES ('2021-05-21 14:05:06', 'T-1', 'Transformer broke', 'high');

-- Create line incident
INSERT INTO lineincident VALUES ('1999-01-20 04:05:06', 'L-1', '555.05');

-- Create analyses
--INSERT INTO analyses VALUES ('2021-01-21 04:05:06', 'T-1', 'Transformer does not work', 'D Rose', 'Porto covo'); -- Gives error due to 3rd trigger
INSERT INTO analyses VALUES ('1999-01-20 04:05:06', 'L-1', 'Line was not easy to fix', 'First Month', 'Lisbon');
INSERT INTO analyses VALUES ('1999-01-25 04:05:06', 'B-789', 'Bus bar was impossible to fix', 'D Rose', 'Forte da casa');
-- INSERT INTO analyses VALUES ('1999-01-21 05:05:06', 'B-789', 'Bus bar was impossible to fix', 'D Rose', 'Forte da casa');
INSERT INTO analyses VALUES ('2020-01-21 05:05:06', 'B-789', 'Bus bar was impossible to fix', 'D Rose', 'Forte da casa');
INSERT INTO analyses VALUES ('2021-04-21 04:01:06', 'T-1', 'Transformer broke', 'Peter Warrior', 'Ourique');
INSERT INTO analyses VALUES ('2021-03-21 04:05:06', 'T-1', 'Transformer broke', 'Peter Warrior', 'Ourique');
INSERT INTO analyses VALUES ('2021-05-21 14:05:06', 'T-1', 'Transformer broke', 'Peter Warrior', 'Ourique');

