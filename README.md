# Google_Data_Analytics_Capstone_Cyclistic_Case_Study 
# Google Data Analytics Capstone: Analyzing Company Data to Provide Actionable Marketing Insights
My capstone project for the Google Data Analytics Professional Certificate, a Cyclistic bike share case study.

By: Camryn Tidsworth

Last updated: April 26, 2024

## Introduction

As part of the Google Data Analytics Professional Certification, I completed the capstone case study. In this case study, I was given a real-world data analysis scenario for the fictional bike sharing company Cyclistic. Acting in the capacity of a junior data analyst on the Cyclistic marketing analyst team, my task was to analyze historical company data to answer the business question. I followed the Google data analysis process of ‘ask, prepare, process, analyze, share, and act’ to complete my analysis. The following is an in-depth explanation of each step of the process. 
Links:
Data source [accessed on 4/2/2040]
SQL queries
Data visualization (Tableau)

## Ask
First, some background about Cyclistic: 
> “In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.”

Cyclistic offers multiple pricing plans for its riders. Customers can purchase single-ride or full-day passes as casual riders, or they can purchase an annual membership. The Cyclistic marketing and finance departments have determined that the key to future success is to convert as many casual riders to annual members as possible. In this project, I will answer the business question, “how do annual members and casual riders use Cyclistic bikes differently?” I will prepare, clean, and analyze historical trip data from the last 12 months to understand how annual members and casual riders use Cyclistic’s services. Finally, I will use these insights to recommend strategies for the marketing campaign to convert casual riders into annual Cyclistic members. 

Stakeholders:
Lilly Moreno: as the director of marketing, Moreno is in charge of developing Cyclistic marketing programs. 
Cyclistic Executive Team: The executive team holds final approval for any marketing initiatives.

## Prepare
The data used in this case study has been made publicly available by the real-world company Motivate International Inc. under this license. For the purposes of our case study, this represents data from the fictional company Cyclistic. The data is divided by month and stored in csv. files. Because the data is recent, was collected internally from the company, and includes the information we need to answer our business question, it is considered reliable. 

Tools Used:
BigQuery
Tableau

Because of the large size of this dataset, I chose to use BigQuery to clean and analyze the data and Tableau for follow up analysis and visualization. 

## Process
In the process phase, I explored and cleaned the data to prepare it for analysis. 

After downloading all the data to my computer as csv. files and organizing them in a common folder, I previewed the files to do some initial exploration. The data appeared to be fairly clean already but I did spot some null values and noted this down for future cleaning. 

The next step was to shift the data to BigQuery for more in-depth exploration via SQL. I chose BigQuery because the data set, at 4,332,404 rows, was too large to effectively manipulate in spreadsheets. I created a Google Cloud storage bucket to store the data and then opened it in the BigQuery console. Since the data was distributed across 12 different tables, I combined them into a single table called ‘combined_tripdata_last12mnths’ using the SQL query below.


The schema for the new table:

### Data Exploration
Now that I had a single combined table, it was time to explore the data and flag inconsistencies for future cleaning. 

1. First, I checked for NULL or missing values. The columns start_station_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng all had NULL values. There were 3,587,964 NULL values in total.


2. Next, I checked for duplicate rows using the primary key, ride_id. There were no duplicate rows. 


3. I then confirmed the length of the strings in ride_id, by writing queries to find strings greater than or less than 16.  All strings were shown to be 16 characters long. 


4. I then checked for invalid or unlikely ride lengths. I chose to define this as any ride that lasted less than 1 minute or longer than 24 hours. The query counted 152,631 invalid ride lengths in total. 


5. Finally, I checked for invalid latitude and longitude values. There were 3 invalid end longitude values of “0.0”. 

### Data Cleaning
Now that I had a better understanding of the issues with my data, it was time to clean the data in BigQuery. The original csv. files remained unaltered and stored as a backup on my computer. 

1. The first step was to delete NULL values. This statement removed 1,374,761 rows from the table.


2. Delete invalid ride lengths, removing 85,675 rows from the table.


2. Next, I deleted the 3 invalid longitude values. 

3. Finally, I created a new table with the new columns ride_length_minutes, day_of_week, and month. The new table, named ‘combined_tripdata_last12mnths_cleaned’ was now ready for analysis. 


## Analyze
The goal of the analysis phase is to explore trends in the data and answer the business question “How do annual members and casual riders use Cyclistic bikes differently?”
For the first part of my analysis, I remained in BigQuery and used SQL to aggregate data into summary statistics including:
Number of casual riders versus members
Average ride duration by member type
Average number of rides per month and day of the week by member type
Average ride duration per month and day of the week by member type
Rideable type usage by member type

1. Count of members and casual riders


2. Average ride duration by member type


3. Average number of rides and ride duration per month and day of the week


4. Rideable type usage by member type



Next, I downloaded the table ‘combined_tripdata_last12mnths_cleaned’ as a csv. file and opened it in Tableau to continue my analysis and visualize the trends.

## Share

There were 2,689,421 members and 1,481,955 casual riders in the last 12 months. That means that approximately 64.5% of Cyclistic users are members while 35.5% remain casual riders. Let’s see what we can learn to get that annual member percentage even higher going forward. 





First, let's break down our ridership by use case. Members take more rides during the week while casual riders spike on the weekends. Given this trend, it appears that members are using Cyclistic as part of their daily routine throughout the week while casual riders are using the service for leisure on the weekends. 



This is further confirmed when we look at ride start time. Members most often start their rides Between 7:00 and 8:00 in the morning, and at 5:00 in the evening. The most likely explanation for this is that members are using the bikes to commute. As the number of rides ramps up earlier in the morning for members, it is also possible that they are riding for daily exercise. Casual riders, on the other hand, increase slowly throughout the day and peak at around 5:00 pm. This is more consistent with a leisure use case. 



I also wanted to plot the location of each ride to see if members and casual riders grouped in any particular locations. These maps show the start location for each ride broken down by members and casual riders. While we can see that both groups are more concentrated in the center of the city, there doesn’t seem to be much difference between where members and casual riders choose to ride. 



When we look at ride length over the course of the year, we can see that members’ ride duration stays fairly consistent throughout the year while casual members take longer rides in the summer months. 


However, both members and casual riders take more rides in total during the summer, with ridership at its lowest in the winter months of Quarter 1 and peaking in Quarter 3. A marketing campaign would be most effective if it launched in the spring and built awareness of Cyclistic going into the busiest quarter at the end of summer. 


So, what do we know about the difference between members and casual riders? Members are more consistent both in when and how long they ride. While members do ride more in the summer, they still stay consistent in terms of ride length and time of day, suggesting that they are using Cyclistic for practical purposes like commuting or routine exercise. 

Casual members, on the other hand, are more focused on leisure and take more rides on the weekends and during Quarter 3 in the summer. As interest in Cyclistic is already high during this time of year, this would be the best time to focus on converting casual riders to full-time bike commuters. An effective conversion strategy would focus on enticing casual riders to integrate cycling into their daily routine, perhaps through promoting the health benefits, cost effectiveness, or overall enjoyment factor of commuting and exercising by bike. 

#### Members:
Use Cyclistic as part of their daily routine throughout the week
Take the most number of rides during the week
Take more rides during the summer but ride duration stays about the same. 
#### Casual:
Use Cyclistic for leisure rides
Less consistent timing
Take more rides and longer rides in summer and on weekends

## Act
Now that we understand the difference between members and casual riders, what should we do with this information? Here are my three data-driven recommendations for the marketing campaign to convert casual riders to members. 

#### 3 recommendations: 
Ramp up advertising efforts during quarters 2 and 3 to take advantage of increased ridership and reach the most people. 
Encourage casual riders to integrate cycling into their daily lifestyle, perhaps by emphasizing the health benefits and cost-effectiveness of exercising and commuting by bike. 
Focus more physical advertising materials like posters, billboards, etc. in the center of the city where there is the highest density of riders. 
