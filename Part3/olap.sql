SELECT COALESCE(severity, 'ALL severity') AS severity,
       COALESCE(locality, 'ALL localities') AS locality,
       COALESCE(CAST(week_day AS VARCHAR), 'ALL week days') AS week_day,
       COUNT(*)
FROM f_incident
         NATURAl JOIN d_location
         NATURAL JOIN d_time
GROUP BY CUBE (severity, locality, week_day);