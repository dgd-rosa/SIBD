-- 3. View

CREATE VIEW supervisors_and_their_number_of_substations AS
SELECT s2.sname, s2.saddress, COUNT(*) AS number_of_substations
FROM supervisor s1
         JOIN substation s2 on s1.name = s2.sname and s1.address = s2.saddress
GROUP BY (s2.sname, s2.saddress)
HAVING COUNT(*) > 0;


-- 4. SQL
-- 1. Who are the analysts that have analyzed every incident of element ‘B-789’?
SELECT name, address
FROM analyses
WHERE id = 'B-789'
GROUP BY (name, address)
HAVING COUNT(*) = (SELECT COUNT(*) FROM incident WHERE incident.id = 'B-789');

--2. Who are the supervisors that do not supervise substations south of Rio Maior
--(Rio Maior coordinates: 39.336775, -8.936379)
--Then they supervise at North
SELECT DISTINCT s1.sname, s1.saddress
FROM substation s1
WHERE NOT EXISTS(
        SELECT DISTINCT (s2.sname, s2.saddress)
        FROM substation s2
        WHERE s2.gpslat < 39.336775 AND s1.sname = s2.sname AND s1.saddress = s2.saddress
    );
--3. What are the elements with smallest amount of incidents?
SELECT i1.id
FROM incident i1
GROUP BY i1.id
HAVING COUNT(*) <= ALL (
    SELECT COUNT(i2.id)
    FROM incident i2
    GROUP BY i2.id
);

--4. How many substations does each supervisor supervise? (include supervisors that do not
    --supervise any at the moment)
SELECT s1.name, s1.address, COUNT(s2.gpslat) AS n_substations --We use gpslat in COUNT() because it ignores null values
FROM supervisor s1 LEFT JOIN substation s2 on s1.name = s2.sname and s1.address = s2.saddress
GROUP BY s1.name, s1.address;

