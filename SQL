CREATE TABLE `bike_sharing.combined_tripdata_last12mnths` AS SELECT *
FROM (
SELECT * FROM `bike_sharing.202303` UNION ALL
SELECT * FROM `bike_sharing.202304` UNION ALL
SELECT * FROM `bike_sharing.202305` UNION ALL
SELECT * FROM `bike_sharing.202306` UNION ALL
SELECT * FROM `bike_sharing.202307` UNION ALL
SELECT * FROM `bike_sharing.202308` UNION ALL
SELECT * FROM `bike_sharing.202309` UNION ALL
SELECT * FROM `bike_sharing.202310` UNION ALL
SELECT * FROM `bike_sharing.202311` UNION ALL
SELECT * FROM `bike_sharing.202312` UNION ALL
SELECT * FROM `bike_sharing.202401` UNION ALL
SELECT * FROM `bike_sharing.202402`);
