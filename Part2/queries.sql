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