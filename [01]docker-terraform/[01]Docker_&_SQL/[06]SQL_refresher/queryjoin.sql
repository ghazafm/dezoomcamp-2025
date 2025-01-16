SELECT
	t.tpep_pickup_datetime,
	t.tpep_dropoff_datetime,
	t.total_amount,
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup",
	CONCAT(zdo."Borough", '/', zdo."Zone") AS "dropoff"
FROM 
	yellow_taxi t 
JOIN zones zpu ON
	t."PULocationID" = zpu."LocationID"
JOIN zones zdo ON
	t."DOLocationID" = zdo."LocationID"
-- LIMIT 100;