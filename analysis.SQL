-- Count number of members versus casual riders
SELECT
  member_casual,
  COUNT(*) AS number
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned`
GROUP BY member_casual
ORDER BY member_casual;
-- there are 1481955 casual riders
-- there are 2689421 members

-- Find average ride duration by member type
SELECT member_casual AVG(ride_length_minutes) AS average_ride_time
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned`
GROUP BY member_casual;

-- Average ride time per day of the week by member type
SELECT member_casual, day_of_week, AVG(ride_length_minutes) AS average_ride_time
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned` 
GROUP BY member_casual, day_of_week
ORDER BY day_of_week, member_casual;

-- Average ride time per month by member type
SELECT member_casual, month, AVG(ride_length_minutes) AS average_ride_time
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned` 
GROUP BY member_casual, month
ORDER BY month, member_casual;

-- Number of rides per day of the week by member type
SELECT member_casual, day_of_week, COUNT(member_casual) AS number_of_rides
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned` 
GROUP BY member_casual, day_of_week
ORDER BY day_of_week, member_casual;

-- Number of rides per month by member type
SELECT member_casual, month, COUNT(member_casual) AS number_of_rides
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned` 
GROUP BY member_casual, month
ORDER BY month, member_casual;

-- Count rideable type usage by member type
SELECT 
member_casual, rideable_type,
COUNT(*) AS number_of_rides
FROM `crack-audio-418512.bike_sharing.combined_tripdata_last12mnths_cleaned`
GROUP BY member_casual, rideable_type
ORDER BY member_casual;
