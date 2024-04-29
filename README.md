# Google_Data_Analytics_Capstone_Cyclistic_Case_Study 
![Untitled design](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/9f90ea9c-70dd-4557-af84-51b7a161bf4a)


# Google Data Analytics Capstone: Analyzing Company Data to Provide Actionable Marketing Insights
My capstone project for the Google Data Analytics Professional Certificate, a Cyclistic bike share case study.

By: Camryn Tidsworth

Last updated: April 26, 2024

## Introduction

As part of the [Google Data Analytics Professional Certification](https://www.coursera.org/professional-certificates/google-data-analytics?skipBrowseRedirect=true), I completed the capstone case study. In this case study, I was given a real-world data analysis scenario for the fictional bike sharing company Cyclistic. Acting in the capacity of a junior data analyst on the Cyclistic marketing analyst team, my task was to analyze historical company data to answer the business question. I followed the Google data analysis process of ‘ask, prepare, process, analyze, share, and act’ to complete my analysis. The following is an in-depth explanation of each step of the process. 

### Links:
[Data source](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 4/2/2040]

SQL queries

[Data visualization (Tableau)](https://public.tableau.com/views/BikeShareCaseStudy_17134659071010/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

## Ask
First, some background about Cyclistic: 
> “In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.”

Cyclistic offers multiple pricing plans for its riders. Customers can purchase single-ride or full-day passes as casual riders, or they can purchase an annual membership. The Cyclistic marketing and finance departments have determined that the key to future success is to convert as many casual riders to annual members as possible. In this project, I will answer the business question, **“how do annual members and casual riders use Cyclistic bikes differently?”** I will prepare, clean, and analyze historical trip data from the last 12 months to understand how annual members and casual riders use Cyclistic’s services. Finally, I will use these insights to recommend strategies for the marketing campaign to convert casual riders into annual Cyclistic members. 

### Stakeholders:
* Lilly Moreno: as the director of marketing, Moreno is in charge of developing Cyclistic marketing programs.
* Cyclistic Executive Team: The executive team holds final approval for any marketing initiatives.

## Prepare
The data used in this case study has been made publicly available by the real-world company Motivate International Inc. under [this license](https://divvybikes.com/data-license-agreement). For the purposes of our case study, this represents data from the fictional company Cyclistic. The data is divided by month and stored in csv. files. Because the data is recent, was collected internally from the company, and includes the information we need to answer our business question, it is considered reliable. 

### Tools Used:
* BigQuery
* Tableau

Because of the large size of this dataset, I chose to use BigQuery to clean and analyze the data and Tableau for follow up analysis and visualization. 

## Process
In the process phase, I explored and cleaned the data to prepare it for analysis. 

After downloading all the data to my computer as csv. files and organizing them in a common folder, I previewed the files to do some initial exploration. The data appeared to be fairly clean already but I did spot some null values and noted this down for future cleaning. 

The next step was to shift the data to BigQuery for more in-depth exploration via SQL. I chose BigQuery because the data set, at 4,332,404 rows, was too large to effectively manipulate in spreadsheets. I created a Google Cloud storage bucket to store the data and then opened it in the BigQuery console. Since the data was distributed across 12 different tables, I combined them into a single table called ‘combined_tripdata_last12mnths’ using the SQL query below.

<img width="890" alt="Screenshot 2024-04-28 at 9 32 28 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/f6ea9dfc-95a8-42ee-b954-34d417c046c1">


The schema for the new table:

<img width="814" alt="Screenshot 2024-04-13 at 9 37 02 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/ad9aceb4-e50e-4e89-a621-2a7209c3e867">


### Data Exploration
Now that I had a single combined table, it was time to explore the data and flag inconsistencies for future cleaning. 

1. First, I checked for NULL or missing values. The columns start_station_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng all had NULL values. There were 3,587,964 NULL values in total.

<img width="693" alt="Screenshot 2024-04-22 at 9 08 56 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/85bb92e7-c640-4e6e-a812-0bac9e13d567">


2. Next, I checked for duplicate rows using the primary key, ride_id. There were no duplicate rows. 

<img width="624" alt="Screenshot 2024-03-28 at 12 59 02 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/dbc994b2-9605-43d2-8b92-af32cb1d74d2">


3. I then confirmed the length of the strings in ride_id, by writing queries to find strings greater than or less than 16.  All strings were shown to be 16 characters long. 

<img width="571" alt="Screenshot 2024-03-28 at 1 04 55 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/a616d464-6f9e-4c5a-9c17-8eeb27f4230b">


4. I then checked for invalid or unlikely ride lengths. I chose to define this as any ride that lasted less than 1 minute or longer than 24 hours. The query counted 152,631 invalid ride lengths in total. 

<img width="893" alt="Screenshot 2024-04-22 at 8 44 59 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/64bb5034-0526-46d3-90da-b252a7a513d9">


5. Finally, I checked for invalid latitude and longitude values. There were 3 invalid end longitude values of “0.0”.

<img width="947" alt="Screenshot 2024-04-08 at 2 17 48 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/ca915d58-90b7-4282-ad76-82525ef0d258">


### Data Cleaning
Now that I had a better understanding of the issues with my data, it was time to clean the data in BigQuery. The original csv. files remained unaltered and stored as a backup on my computer. 

1. The first step was to delete NULL values. This statement removed 1,374,761 rows from the table.

<img width="887" alt="Screenshot 2024-03-29 at 12 04 55 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/5d33a569-c02b-4ed1-bb5e-b1cb50a18f6a">


2. Delete invalid ride lengths, removing 85,675 rows from the table.

<img width="847" alt="Screenshot 2024-04-22 at 10 42 44 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/11dc150a-8ac4-425d-add1-ef7216e415f3">


2. Next, I deleted the 3 invalid longitude values.

<img width="946" alt="Screenshot 2024-04-08 at 2 15 47 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/10143101-3d1b-41d5-916a-882bbd5a6bd6">


4. Finally, I created a new table with the new columns ride_length_minutes, day_of_week, and month. The new table, named ‘combined_tripdata_last12mnths_cleaned’ was now ready for analysis. 

<img width="883" alt="Screenshot 2024-03-29 at 11 40 42 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/dbb84962-0008-4910-b6b9-e5d6376df5d1">
<img width="847" alt="Screenshot 2024-04-22 at 10 45 32 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/e81f0978-1bc4-40a1-8a15-76d1dd314bda">

## Analyze
The goal of the analysis phase is to explore trends in the data and answer the business question “How do annual members and casual riders use Cyclistic bikes differently?”
For the first part of my analysis, I remained in BigQuery and used SQL to aggregate data into summary statistics including:
* Number of casual riders versus members
* Average ride duration by member type
* Average number of rides per month and day of the week by member type
* Average ride duration per month and day of the week by member type
* Rideable type usage by member type

1. Count of members and casual riders

<img width="888" alt="Screenshot 2024-04-01 at 10 01 16 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/ebf3e8b1-af14-429f-a687-4bf952c8e398">


3. Average ride duration by member type

<img width="887" alt="Screenshot 2024-04-01 at 11 01 45 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/16795180-80c9-48bb-96f7-8d5f3ff6bf71">


4. Average number of rides and ride duration per month and day of the week

<img width="883" alt="Screenshot 2024-04-01 at 11 22 57 AM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/6001d652-bf99-462d-a018-7d4d550ac570">


5. Rideable type usage by member type

<img width="849" alt="Screenshot 2024-04-22 at 5 42 57 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/058a3f3b-15c3-4f02-b1dd-7e207a8cd569">


Next, I downloaded the table ‘combined_tripdata_last12mnths_cleaned’ as a csv. file and opened it in Tableau to continue my analysis and visualize the trends.

## Share

![Sheet 6](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/5fbbec78-fb9c-43aa-a21d-db719cd42fa4)


There were 2,689,421 members and 1,481,955 casual riders in the last 12 months. That means that approximately 64.5% of Cyclistic users are members while 35.5% remain casual riders. Let’s see what we can learn to get that annual member percentage even higher going forward. 

![Sheet 3](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/c21947f7-c5e6-4819-8dd8-99fe618ac016)


First, let's break down our ridership by use case. Members take more rides during the week while casual riders spike on the weekends. Given this trend, it appears that members are using Cyclistic as part of their daily routine throughout the week while casual riders are using the service for leisure on the weekends. 

![Sheet 7](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/86b1f786-8017-43bc-b135-5b126a52b7c3)


This is further confirmed when we look at ride start time. Members most often start their rides Between 7:00 and 8:00 in the morning, and at 5:00 in the evening. The most likely explanation for this is that members are using the bikes to commute. As the number of rides ramps up earlier in the morning for members, it is also possible that they are riding for daily exercise. Casual riders, on the other hand, increase slowly throughout the day and peak at around 5:00 pm. This is more consistent with a leisure use case. 

<img width="296" alt="Screenshot 2024-04-28 at 12 27 31 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/1aeb4ffc-c377-49b8-926c-eb8689ac6e23">
<img width="297" alt="Screenshot 2024-04-28 at 12 27 43 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/be8fa43f-08d8-4e4a-9b02-6fee689d05f0">
<img width="176" alt="Screenshot 2024-04-13 at 12 26 53 PM" src="https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/d26e9102-1f8e-4fd2-85f3-f435b9b341af">


I also wanted to plot the location of each ride to see if members and casual riders grouped in any particular locations. These maps show the start location for each ride broken down by members and casual riders. While we can see that both groups are more concentrated in the center of the city, there doesn’t seem to be much difference between where members and casual riders choose to ride. 

![Sheet 8](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/ad90fc5d-37ef-4f12-866e-66ed9f23b644)


When we look at ride length over the course of the year, we can see that members’ ride duration stays fairly consistent throughout the year while casual members take longer rides in the summer months. 

![Sheet 1](https://github.com/CamrynTidsworth/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/assets/167467192/5d0246b1-2069-4431-a5f6-2789cda96f02)


However, both members and casual riders take more rides in total during the summer, with ridership at its lowest in the winter months of Quarter 1 and peaking in Quarter 3. A marketing campaign would be most effective if it launched in the spring and built awareness of Cyclistic going into the busiest quarter at the end of summer. 

So, what do we know about the difference between members and casual riders? Members are more consistent both in when and how long they ride. While members do ride more in the summer, they still stay consistent in terms of ride length and time of day, suggesting that they are using Cyclistic for practical purposes like commuting or routine exercise. 

Casual members, on the other hand, are more focused on leisure and take more rides on the weekends and during Quarter 3 in the summer. As interest in Cyclistic is already high during this time of year, this would be the best time to focus on converting casual riders to full-time bike commuters. An effective conversion strategy would focus on enticing casual riders to integrate cycling into their daily routine, perhaps through promoting the health benefits, cost effectiveness, or overall enjoyment factor of commuting and exercising by bike. 

#### Members:
* Use Cyclistic as part of their daily routine throughout the week
* Take the most number of rides during the week
* Take more rides during the summer but ride duration stays about the same. 
#### Casual:
* Use Cyclistic for leisure rides
* Less consistent timing
* Take more rides and longer rides in summer and on weekends

## Act
Now that we understand the difference between members and casual riders, what should we do with this information? Here are my three data-driven recommendations for the marketing campaign to convert casual riders to members. 

#### 3 Recommendations: 
* Ramp up advertising efforts during quarters 2 and 3 to take advantage of increased ridership and reach the most people. 
* Encourage casual riders to integrate cycling into their daily lifestyle, perhaps by emphasizing the health benefits and cost-effectiveness of exercising and commuting by bike. 
* Focus more physical advertising materials like posters, billboards, etc. in the center of the city where there is the highest density of riders.

Thank you to the Google Data Analytics Professional Certificate for equiping me with the knowledge and skills to complete this case study. I am excited to continue to learn, analyze, and shape data-driven decisions with the tools showcased here. Finally, thank you all for reading this article, and please do not hesitate to offer constructive feedback.  
