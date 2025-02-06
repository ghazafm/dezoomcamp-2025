SELECT 
 count(*)
FROM 
  `college-brawijaya.zoomcamp.yellow_tripdata` AS c 
WHERE 
  c.filename LIKE "yellow_tripdata_2020%";
