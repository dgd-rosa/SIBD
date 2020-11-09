-- List the names of all analysts that analysed element with id 'B-789'
SELECT a.analyst_name
FROM Incident i
         JOIN analyses a on (i.instant = a.instant and i.element_id = a.element_id)
WHERE a.element_id = 'B-789';


-- What is the name of the analyst that has reported more incidents
SELECT count(*), a.analyst_name
FROM Incident i
         JOIN analyses a on (i.instant = a.instant and i.element_id = a.element_id)
GROUP BY (a.analyst_name)
HAVING count(*) = (SELECT MAX(C)
                   FROM (SELECT count(*) as C
                         FROM Incident i
                                  JOIN analyses a on (i.instant = a.instant and i.element_id = a.element_id)
                         GROUP BY (a.analyst_name)) AS Q);

--All substations with more than one transformer
SELECT s.gps_coords, s.locality_name, COUNT(*) as number_of_transformer
FROM transformer t
         JOIN located l ON (t.element_id = l.transformer_id)
         JOIN substation s ON (l.gps_coords = s.gps_coords)
GROUP BY (s.gps_coords)
HAVING COUNT(*) > 1;

--Find the names of the localities that have more substations than every other locality
SELECT s.locality_name, COUNT(*) as number
FROM substation s
GROUP BY (s.locality_name)
HAVING count(*) = (SELECT MAX(C)
                   FROM (SELECT COUNT(*) as C
                         FROM substation s
                         GROUP BY (s.locality_name)) as Q);