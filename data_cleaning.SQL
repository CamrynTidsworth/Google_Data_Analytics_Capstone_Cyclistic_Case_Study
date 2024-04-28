-- Delete NULL values
DELETE FROM bike_sharing.combined_tripdata_last12mnths
WHERE
start_station_name IS NULL OR
start_station_id IS NULL OR
end_station_name IS NULL OR
end_station_id IS NULL OR
end_lat IS NULL OR
end_lng IS NULL;

-- Delete invalid ride lengths
DELETE FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` 
WHERE 
TIMESTAMP_DIFF(ended_at, started_at, minute) < 1 OR
TIMESTAMP_DIFF(ended_at, started_at, minute) > 1440;

-- Delete invalid longitude values
DELETE
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths`
WHERE end_lng = 0.0;

-- Create new table
CREATE TABLE `bike_sharing.combined_tripdata_last12mnths_cleaned_v2` AS
SELECT
ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual, 

-- Create a "ride_length_minutes" column
TIMESTAMP_DIFF (ended_at, started_at, minute) AS ride_length_minutes,

-- Create a "day_of_week" column
CASE
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 1 THEN 'SUN'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 2 THEN 'MON'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 3 THEN 'TUE'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 4 THEN 'WED'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 5 THEN 'THU'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 6 THEN 'FRI'
  WHEN EXTRACT (DAYOFWEEK FROM started_at) = 7 THEN 'SAT'
END AS day_of_week,

-- Create a "month" column
CASE
  WHEN EXTRACT (MONTH FROM started_at) = 1 THEN 'JAN'
  WHEN EXTRACT (MONTH FROM started_at) = 2 THEN 'FEB'
  WHEN EXTRACT (MONTH FROM started_at) = 3 THEN 'MAR'
  WHEN EXTRACT (MONTH FROM started_at) = 4 THEN 'APR'
  WHEN EXTRACT (MONTH FROM started_at) = 5 THEN 'MAY'
  WHEN EXTRACT (MONTH FROM started_at) = 6 THEN 'JUN'
  WHEN EXTRACT (MONTH FROM started_at) = 7 THEN 'JUL'
  WHEN EXTRACT (MONTH FROM started_at) = 8 THEN 'AUG'
  WHEN EXTRACT (MONTH FROM started_at) = 9 THEN 'SEP'
  WHEN EXTRACT (MONTH FROM started_at) = 10 THEN 'OCT'
  WHEN EXTRACT (MONTH FROM started_at) = 11 THEN 'NOV'
  WHEN EXTRACT (MONTH FROM started_at) =12 THEN 'DEC'
END AS month,

FROM `bike_sharing.combined_tripdata_last12mnths`

-- Delete invalid ride lengths
WHERE TIMESTAMP_DIFF (ended_at, started_at, minute) > 1 AND 
TIMESTAMP_DIFF (ended_at, started_at, minute) < 1440;
