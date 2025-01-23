SELECT 
    CONCAT(zdo."Borough", '/', zdo."Zone") AS "dropoff",
    SUM(t.tip_amount) AS tip
FROM 
    green_taxi t
JOIN zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
WHERE 
    t.lpep_pickup_datetime > '2019-10-01 00:00:00' AND
    t.lpep_pickup_datetime < '2019-11-01 00:00:00' AND
    zpu."Zone" = 'East Harlem North'
GROUP BY 
    zdo."Borough", zdo."Zone"
ORDER BY 
    tip DESC
LIMIT 1;