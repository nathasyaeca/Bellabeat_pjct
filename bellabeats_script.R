#load the packages
library(tidyverse)
library(skimr)
#import all necesary df
#activity df
activity <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/dailyActivity_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activitydate = mdy(activitydate))
#calories df
#finding fav time for exercise
caloriesHour <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/hourlyCalories_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activityhour = mdy_hms(activityhour)) %>% 
  ggplot(aes(hour(activityhour), calories))+
  geom_smooth(show.legend = F) +
  labs(x = "",
       y = "Calories",
       title = "Calories of User Each Hours")
#steps df
hourlySteps <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/hourlySteps_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activityhour = mdy_hms(activityhour)) %>% 
  ggplot(aes(hour(activityhour), steptotal)) + 
  geom_smooth(show.legend = F) +
  labs(x = "",
       y = "Daily User Steps")
#visualizing activity df
activity %>% 
  select(activitydate, calories, id) %>% 
  group_by(id) %>% 
  ggplot(aes(activitydate, calories, fill = id)) +
  geom_boxplot(size = 0.5, show.legend = F) +
  labs(x = "",
       y = "Calories",
       title = "Calories That the User Burn Everyday")
#heartrate/sec df
heartrate <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/heartrate_seconds_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         time = mdy_hms(time))
#sleepday df
sleepday <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/sleepDay_merged.csv") %>%
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         sleepday = mdy_hms(sleepday))
#weighLogInfo df
weightLogInfo <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/weightLogInfo_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         date = mdy_hms(date))
skim_without_charts(weightLogInfo)
#see mean(total distance)
activity %>% 
  select(totaldistance) %>% 
  filter(totaldistance != 0) %>% 
  summarize(mean(totaldistance))   #5.98645
#mean(calories)
activity %>% 
  select(calories) %>% 
  summarize(mean(calories))        #2303.61
#total step and calories that they burn
activity %>% 
  filter(totalsteps != 0) %>% 
  ggplot(aes(calories, totalsteps)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Calories",
       y = "Total Steps",
       title = "Total steps of user and how much calories they burn")
#merging two df (activity and weight log info) to see differences between
#user weigh (kg) and their total calories burn per-day.