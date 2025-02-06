SELECT 
  COUNT(*) 
FROM 
  `college-brawijaya.zoomcamp.green_tripdata` AS c 
WHERE 
  c.filename LIKE "green_tripdata_2020-%";
