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
WHERE id = 'B-1'
GROUP BY (name, address)
HAVING COUNT(*) = (SELECT COUNT(*) FROM incident WHERE incident.id = 'B-1');

