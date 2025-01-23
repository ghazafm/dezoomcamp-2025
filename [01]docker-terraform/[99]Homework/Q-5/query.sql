SELECT
	SUM(t.total_amount) AS total_amount,
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup"
FROM 
	green_taxi t 
JOIN zones zpu ON
	t."PULocationID" = zpu."LocationID"
WHERE
	t.lpep_pickup_datetime >= '2019-10-17 00:00:00' AND
	t.lpep_pickup_datetime < '2019-10-18 00:00:00'
GROUP BY
	zpu."Borough", zpu."Zone"
HAVING
	SUM(total_amount) > 13000
ORDER BY total_amount DESC
LIMIT 5;