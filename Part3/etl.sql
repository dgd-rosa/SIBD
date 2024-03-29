-- populate d_reporter
INSERT INTO d_reporter(name, address)
SELECT DISTINCT name, address
FROM analyses;

-- populate d_time
CREATE OR REPLACE FUNCTION load_time_dimension() RETURNS VOID AS
$$
DECLARE
    date_value TIMESTAMP;

BEGIN
    date_value := '1998-01-01 00:00:00';
    WHILE date_value < '2030-01-01 00:00:00'
        LOOP
            INSERT INTO d_time(day, week_day, week, month, trimester, year)
            VALUES (EXTRACT(DAY FROM date_value),
                    EXTRACT(DOW FROM date_value),
                    EXTRACT(WEEK FROM date_value),
                    EXTRACT(MONTH FROM date_value),
                    EXTRACT(QUARTER FROM date_value),
                    EXTRACT(YEAR FROM date_value));
            date_value := date_value + INTERVAL '1 DAY';
        end loop;
end;
$$ LANGUAGE plpgsql;

SELECT load_time_dimension();


-- populate d_location
INSERT INTO d_location(latitude, longitude, locality)
SELECT DISTINCT s.gpslat, s.gpslong, s.locality
FROM incident i
         JOIN transformer t ON i.id = t.id
         LEFT JOIN substation s on t.gpslat = s.gpslat and t.gpslong = s.gpslong;


-- populate d_element
INSERT INTO d_element(element_id, element_type)
SELECT DISTINCT b.id, 'BUSBAR'
FROM incident i
         JOIN busbar b ON i.id = b.id
UNION
SELECT DISTINCT t.id, 'TRANSFORMER'
FROM incident i
         JOIN transformer t ON i.id = t.id
UNION
SELECT DISTINCT l.id, 'LINE'
FROM incident i
         JOIN line l ON i.id = l.id;


--populate f_incident
INSERT INTO f_incident(id_reporter, id_time, id_location, id_element, severity)
SELECT dr.id_reporter, dt.id_time, dl.id_location, e.id_element, I.severity
FROM (SELECT a.name, a.address, i.instant, sb.gpslong, sb.gpslat, t.id, i.severity
      FROM incident i
               JOIN analyses a ON (i.instant = a.instant AND a.id = i.id)
               JOIN transformer t ON i.id = t.id
               JOIN substation sb ON (t.gpslat = sb.gpslat AND t.gpslong = sb.gpslong)
     ) AS I
         JOIN d_reporter dr ON (I.name = dr.name AND I.address = dr.address)
         JOIN d_time dt ON (CAST(EXTRACT(DAY FROM I.instant) AS INTEGER) = dt.day
    AND CAST(EXTRACT(DOW FROM I.instant) AS INTEGER) = dt.week_day
    AND CAST(EXTRACT(WEEK FROM I.instant) AS INTEGER) = dt.week
    AND CAST(EXTRACT(MONTH FROM I.instant) AS INTEGER) = dt.month
    AND CAST(EXTRACT(QUARTER FROM I.instant) AS INTEGER) = dt.trimester
    AND CAST(EXTRACT(YEAR FROM I.instant) AS INTEGER) = dt.year)
         JOIN d_location dl ON (I.gpslong = dl.longitude AND I.gpslat = dl.latitude)
         JOIN d_element e ON e.element_id = I.id;

