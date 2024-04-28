-- Check for NULL values
SELECT col_name, COUNT(1) AS nulls_count
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` t,
UNNEST(REGEXP_EXTRACT_ALL(TO_JSON_STRING(t), r'"(\w+)":null')) AS col_name
GROUP BY col_name;

/* start_station_name has 866105 NULL values,
start_staion_id has 866105 NULL values,
end_station_name has 920524 NULL values,
end_station_id has 920524 NULL values,
end_lat has 7353 NULL values,
end_lng has 7353 NULL values */

-- Check for duplicates
SELECT COUNT (ride_id) - COUNT (DISTINCT ride_id) AS duplicate_rows
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths';

-- Check string length
SELECT
  LENGTH (ride_id)
FROM
  bike_sharing.combined_tripdata_last12mnths
WHERE
LENGTH(ride_id) > 16

SELECT
  LENGTH (ride_id)
FROM
  bike_sharing.combined_tripdata_last12mnths
WHERE
LENGTH(ride_id) < 16

-- all ride_ids are 16 characters long

-- Check for invalid ride lengths
SELECT COUNT(
TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS shorter_than_1_minute
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths`
WHERE (TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) < 1;  -- there are 145743 rides shorter than 1 minute

SELECT COUNT(
TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS longer_than_24_hours
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths`
WHERE (TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) > 1440; -- there are 6888 rides longer than 24 hours

-- Check for invalid latitude and longitude values
SELECT start_lat 
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` 
WHERE start_lat > 50 OR start_lat < 35;

SELECT start_lng 
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` 
WHERE start_lng < -90 OR start_lng > -80;

SELECT end_lat 
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` 
WHERE end_lat > 50 OR end_lat < 35;

SELECT end_lng 
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths` 
WHERE end_lng < -90 OR end_lng > -80;

-- there are 3 invalid end_lng values
