Bellabeat
================
Nathasya Pramudita
2023-11-04

- [Bellabeat Case Study.](#bellabeat-case-study)
  - [Introduction](#introduction)
  - [Dataset for the analysis](#dataset-for-the-analysis)
- [Wrangling the data.](#wrangling-the-data)
- [Analyzing and visualizing data
  frames](#analyzing-and-visualizing-data-frames)
  - [find some pattern of behavior](#find-some-pattern-of-behavior)
- [Conclusion](#conclusion)

# Bellabeat Case Study.

## Introduction

Bellabeat is company that created health device for all ages, specifying
for women. Their product is not only prioritized function but creating
unique appearance too. Bellabeat is the go-to wellness brand for women
with an ecosystem of products and services focused on women health. They
created various product such as:

1.  Wellness tracker
2.  Yoga mat with sustainable material
3.  Menstrual cup
4.  And all the accessories for their wellness tracker device

## Dataset for the analysis

To observe Bellabeat’s user behavior while using one of their best
product, Wellness tracker. We collect dataset from
`FitBit Fitness Tracker Data` Distribute via Amazon Mechanical Turk
between 12-04-2016 to 12-05-2016.

The dataset consist of:

- activity dataframe : Consist of 15 columns and 940 rows. It’s about
  their behavior pattern when using the wellness tracker device. The
  dataset is from 2016-04-12 until 2016-05-12, with 33 unique `id`
  users.

- caloriesHour : Consist of 3 columns and 22.099 rows. It’s about how
  much the user burn their calories every hours each day.

- heartrate : Consist of 3 variables with 2.482.658 rows. This dataframe
  is collecting every 5 seconds of the heartrate of our user while using
  the wellness tracker device.

- hourlySteps : Consist of 3 variables with 22.099 rows. It’s about each
  and every steps our user achived every hours.

- sleepday : Consist of 5 variables with 431 rows. They record how long
  the user stay in bed and their REM sleep quality.

- weightLogInfo : With 8 variables and 67 rows. This dataset is about 8
  unique users identity of weight, BMI, and last log in and out of the
  platform.

# Wrangling the data.

The data that we obtained is not in the best condition for the analysis
steps, so I need to clean some of data type in all data frame that’ll be
use.

``` r
#activity df
activity <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/dailyActivity_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activitydate = mdy(activitydate))
skim_without_charts(activity)
```

|                                                  |          |
|:-------------------------------------------------|:---------|
| Name                                             | activity |
| Number of rows                                   | 940      |
| Number of columns                                | 15       |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |          |
| Column type frequency:                           |          |
| character                                        | 1        |
| Date                                             | 1        |
| numeric                                          | 13       |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |          |
| Group variables                                  | None     |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| id            |         0 |             1 |  10 |  10 |     0 |       33 |          0 |

**Variable type: Date**

| skim_variable | n_missing | complete_rate | min        | max        | median     | n_unique |
|:--------------|----------:|--------------:|:-----------|:-----------|:-----------|---------:|
| activitydate  |         0 |             1 | 2016-04-12 | 2016-05-12 | 2016-04-26 |       31 |

**Variable type: numeric**

| skim_variable            | n_missing | complete_rate |    mean |      sd |  p0 |     p25 |     p50 |      p75 |     p100 |
|:-------------------------|----------:|--------------:|--------:|--------:|----:|--------:|--------:|---------:|---------:|
| totalsteps               |         0 |             1 | 7637.91 | 5087.15 |   0 | 3789.75 | 7405.50 | 10727.00 | 36019.00 |
| totaldistance            |         0 |             1 |    5.49 |    3.92 |   0 |    2.62 |    5.24 |     7.71 |    28.03 |
| trackerdistance          |         0 |             1 |    5.48 |    3.91 |   0 |    2.62 |    5.24 |     7.71 |    28.03 |
| loggedactivitiesdistance |         0 |             1 |    0.11 |    0.62 |   0 |    0.00 |    0.00 |     0.00 |     4.94 |
| veryactivedistance       |         0 |             1 |    1.50 |    2.66 |   0 |    0.00 |    0.21 |     2.05 |    21.92 |
| moderatelyactivedistance |         0 |             1 |    0.57 |    0.88 |   0 |    0.00 |    0.24 |     0.80 |     6.48 |
| lightactivedistance      |         0 |             1 |    3.34 |    2.04 |   0 |    1.95 |    3.36 |     4.78 |    10.71 |
| sedentaryactivedistance  |         0 |             1 |    0.00 |    0.01 |   0 |    0.00 |    0.00 |     0.00 |     0.11 |
| veryactiveminutes        |         0 |             1 |   21.16 |   32.84 |   0 |    0.00 |    4.00 |    32.00 |   210.00 |
| fairlyactiveminutes      |         0 |             1 |   13.56 |   19.99 |   0 |    0.00 |    6.00 |    19.00 |   143.00 |
| lightlyactiveminutes     |         0 |             1 |  192.81 |  109.17 |   0 |  127.00 |  199.00 |   264.00 |   518.00 |
| sedentaryminutes         |         0 |             1 |  991.21 |  301.27 |   0 |  729.75 | 1057.50 |  1229.50 |  1440.00 |
| calories                 |         0 |             1 | 2303.61 |  718.17 |   0 | 1828.50 | 2134.00 |  2793.25 |  4900.00 |

``` r
#caloriesHour df
caloriesHour <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/hourlyCalories_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activityhour = mdy_hms(activityhour))
skim_without_charts(caloriesHour)
```

|                                                  |              |
|:-------------------------------------------------|:-------------|
| Name                                             | caloriesHour |
| Number of rows                                   | 22099        |
| Number of columns                                | 3            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |              |
| Column type frequency:                           |              |
| character                                        | 1            |
| numeric                                          | 1            |
| POSIXct                                          | 1            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |              |
| Group variables                                  | None         |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| id            |         0 |             1 |  10 |  10 |     0 |       33 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |  mean |   sd |  p0 | p25 | p50 | p75 | p100 |
|:--------------|----------:|--------------:|------:|-----:|----:|----:|----:|----:|-----:|
| calories      |         0 |             1 | 97.39 | 60.7 |  42 |  63 |  83 | 108 |  948 |

**Variable type: POSIXct**

| skim_variable | n_missing | complete_rate | min        | max                 | median              | n_unique |
|:--------------|----------:|--------------:|:-----------|:--------------------|:--------------------|---------:|
| activityhour  |         0 |             1 | 2016-04-12 | 2016-05-12 15:00:00 | 2016-04-26 06:00:00 |      736 |

``` r
#hourlySteps df
hourlySteps <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/hourlySteps_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         activityhour = mdy_hms(activityhour))
skim_without_charts(hourlySteps)
```

|                                                  |             |
|:-------------------------------------------------|:------------|
| Name                                             | hourlySteps |
| Number of rows                                   | 22099       |
| Number of columns                                | 3           |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |             |
| Column type frequency:                           |             |
| character                                        | 1           |
| numeric                                          | 1           |
| POSIXct                                          | 1           |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |             |
| Group variables                                  | None        |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| id            |         0 |             1 |  10 |  10 |     0 |       33 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |   mean |     sd |  p0 | p25 | p50 | p75 |  p100 |
|:--------------|----------:|--------------:|-------:|-------:|----:|----:|----:|----:|------:|
| steptotal     |         0 |             1 | 320.17 | 690.38 |   0 |   0 |  40 | 357 | 10554 |

**Variable type: POSIXct**

| skim_variable | n_missing | complete_rate | min        | max                 | median              | n_unique |
|:--------------|----------:|--------------:|:-----------|:--------------------|:--------------------|---------:|
| activityhour  |         0 |             1 | 2016-04-12 | 2016-05-12 15:00:00 | 2016-04-26 06:00:00 |      736 |

``` r
#sleepday df
sleepday <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/sleepDay_merged.csv") %>%
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         sleepday = mdy_hms(sleepday))
skim_without_charts(sleepday)
```

|                                                  |          |
|:-------------------------------------------------|:---------|
| Name                                             | sleepday |
| Number of rows                                   | 413      |
| Number of columns                                | 5        |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |          |
| Column type frequency:                           |          |
| character                                        | 1        |
| numeric                                          | 3        |
| POSIXct                                          | 1        |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |          |
| Group variables                                  | None     |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| id            |         0 |             1 |  10 |  10 |     0 |       24 |          0 |

**Variable type: numeric**

| skim_variable      | n_missing | complete_rate |   mean |     sd |  p0 | p25 | p50 | p75 | p100 |
|:-------------------|----------:|--------------:|-------:|-------:|----:|----:|----:|----:|-----:|
| totalsleeprecords  |         0 |             1 |   1.12 |   0.35 |   1 |   1 |   1 |   1 |    3 |
| totalminutesasleep |         0 |             1 | 419.47 | 118.34 |  58 | 361 | 433 | 490 |  796 |
| totaltimeinbed     |         0 |             1 | 458.64 | 127.10 |  61 | 403 | 463 | 526 |  961 |

**Variable type: POSIXct**

| skim_variable | n_missing | complete_rate | min        | max        | median     | n_unique |
|:--------------|----------:|--------------:|:-----------|:-----------|:-----------|---------:|
| sleepday      |         0 |             1 | 2016-04-12 | 2016-05-12 | 2016-04-27 |       31 |

``` r
#weighLogInfo df
weightLogInfo <- read.csv("~/Case Study/Fitabase Data 4.12.16-5.12.16/Fitbase Data Raw/weightLogInfo_merged.csv") %>% 
  rename_all(tolower) %>% 
  mutate(id = as.character(id),
         date = mdy_hms(date))
skim_without_charts(weightLogInfo)
```

|                                                  |               |
|:-------------------------------------------------|:--------------|
| Name                                             | weightLogInfo |
| Number of rows                                   | 67            |
| Number of columns                                | 8             |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |               |
| Column type frequency:                           |               |
| character                                        | 2             |
| numeric                                          | 5             |
| POSIXct                                          | 1             |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |               |
| Group variables                                  | None          |

Data summary

**Variable type: character**

| skim_variable  | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:---------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| id             |         0 |             1 |  10 |  10 |     0 |        8 |          0 |
| ismanualreport |         0 |             1 |   4 |   5 |     0 |        2 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |         mean |            sd |           p0 |          p25 |          p50 |          p75 |         p100 |
|:--------------|----------:|--------------:|-------------:|--------------:|-------------:|-------------:|-------------:|-------------:|-------------:|
| weightkg      |         0 |          1.00 | 7.204000e+01 |         13.92 | 5.260000e+01 | 6.140000e+01 | 6.250000e+01 | 8.505000e+01 | 1.335000e+02 |
| weightpounds  |         0 |          1.00 | 1.588100e+02 |         30.70 | 1.159600e+02 | 1.353600e+02 | 1.377900e+02 | 1.875000e+02 | 2.943200e+02 |
| fat           |        65 |          0.03 | 2.350000e+01 |          2.12 | 2.200000e+01 | 2.275000e+01 | 2.350000e+01 | 2.425000e+01 | 2.500000e+01 |
| bmi           |         0 |          1.00 | 2.519000e+01 |          3.07 | 2.145000e+01 | 2.396000e+01 | 2.439000e+01 | 2.556000e+01 | 4.754000e+01 |
| logid         |         0 |          1.00 | 1.461772e+12 | 782994783\.61 | 1.460444e+12 | 1.461079e+12 | 1.461802e+12 | 1.462375e+12 | 1.463098e+12 |

**Variable type: POSIXct**

| skim_variable | n_missing | complete_rate | min                 | max                 | median              | n_unique |
|:--------------|----------:|--------------:|:--------------------|:--------------------|:--------------------|---------:|
| date          |         0 |             1 | 2016-04-12 06:47:11 | 2016-05-12 23:59:59 | 2016-04-27 23:59:59 |       56 |

From the summarized of all data that we’ll analyzed, some point that
need to highlight:

- Average of `totalsteps` all user is 7637, which means the average our
  user distance is 5 km.
- `lightactivedistance` average (3.34 km) is much more that
  `veryactivedistance` (1.50). Which means that we can narrowing down,
  that our customers activity is not that vigorously active but
  moderatly active.
- All data is already in good condition (no missing values, no N/A, no
  duplicate, no whitespace, and all the data in correct type) and ready
  to move for next steps (which is analysis and visualizing it).
- The difference of minutes between the most active group and the
  sedentary group is quite astronomic. Which is `21.2 minutes` and
  `991 minutes` (which is 16 hours) per days. We can encourage sedentary
  group to get more active to burn more calories and for their
  productivity.
- The Average Total of `timeinbed`(where the user decided to go to
  sleep) and `minutesasleep` (where the user already in REM stages) are
  `419 minutes` to `459 minutes` which means the averages of times our
  user need to get sleep soundly is `40 minutes`. We can recommend them
  to get active before they want to sleep our give them the notification
  to not playing with their gadgets before the get to sleep.
- The averages of heart rate of Bellabeat’s user is `77.3 beats per min`
  which is can be categorizing as normal, as the normal rates is between
  60-100 heart beats persecond.

*disclaimer: Since this summaries is merely on the base process. `mean`
and `standard deviation` of this data may not be precise and correct,
because we didn’t included filter like not counting 0 values, grouping
the variables, merged other necessary variable, or arrange the values.*

# Analyzing and visualizing data frames

## find some pattern of behavior

``` r
#finding fav time for exercise
caloriesHour  %>% 
  ggplot(aes(hour(activityhour), calories))+
  geom_smooth(show.legend = F) +
  labs(x = "",
       y = "Calories",
       title = "User intensity while using the device by hours")
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

![](bellabeats_files/figure-gfm/analyzed%20and%20visualizing%20df-1.png)<!-- -->

The graph above is telling us that the most productive time each day
when the user user our product is start on 10:00 and the peak is 20:00.
This means our user is the type that work in the large enviroment and
can move quite frequent for the rest of their work day. We can
minimalize our target market of what kind of people that like to used
our product.

``` r
#visualizing activity df
activity %>% 
  select(activitydate, calories, id) %>% 
  group_by(id) %>% 
  ggplot(aes(activitydate, calories, fill = id)) +
  geom_boxplot(size = 0.5, show.legend = F) +
  labs(x = "",
       y = "Calories",
       title = "Calories That the User Burn Everyday")
```

![](bellabeats_files/figure-gfm/calories%20that%20user%20burn%20everyday-1.png)<!-- -->

``` r
#daily user steps
hourlySteps %>% 
  ggplot(aes(hour(activityhour), steptotal)) + 
  geom_smooth(show.legend = F) +
  labs(x = "",
       y = "Daily User Steps")
```

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

![](bellabeats_files/figure-gfm/daily%20user%20steps-1.png)<!-- -->

Just like the most productive time, this graphs give the more precise on
what time our user walk the most, and our hypotesis is rigth! Most of
our user walk daily in their work times.

``` r
activity %>% 
  filter(totalsteps != 0) %>% 
  ggplot(aes(calories, totalsteps)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Calories",
       y = "Total Steps",
       title = "Total steps of user and how much calories they burn")
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](bellabeats_files/figure-gfm/total%20step%20and%20how%20much%20calories%20they%20burn-1.png)<!-- -->

This is quite obvious because the more they walk the more calories they
burn.

``` r
# create lolipop graph of two valiables so it's easy to compare them
```

``` r
activity %>% 
  select(veryactivedistance, moderatelyactivedistance, lightactivedistance, sedentaryactivedistance) %>%
  summarise_all(.fun = mean)
```

    ##   veryactivedistance moderatelyactivedistance lightactivedistance
    ## 1           1.502681                0.5675426            3.340819
    ##   sedentaryactivedistance
    ## 1             0.001606383

``` r
#created the merged df
active <- activity %>%
  inner_join(sleepday, by = c("id", "activitydate" = "sleepday")) %>% 
  select(id, activitydate, veryactivedistance, totalminutesasleep) %>% 
  ggplot(aes(x = totalminutesasleep, y = veryactivedistance)) +
  geom_point() + geom_smooth()
  labs(x = "Total mintues asleep",
       y = "Active intensity in distance")
sedentary <- activity %>% 
  inner_join(sleepday, by = c("id", "activitydate" = "sleepday")) %>% 
  select(id, activitydate, sedentaryactivedistance, totalminutesasleep) %>% 
  ggplot(aes(totalminutesasleep, sedentaryactivedistance)) +
  geom_point() + geom_smooth()
  labs(x = "Total mintues asleep",
       y = "Sedentary intensity in distance")
```

``` r
# combine two graph into one
ggarrange(active, sedentary, nrow = 1)
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](bellabeats_files/figure-gfm/combine%20two%20graph%20into%20one-1.png)<!-- -->

This two merge graph is my way to find some correlation of their sleep
quality, between the active group and sedentary group. But turn up,
there’s no correlation whatsoever in there. So, we can conclude that
either they have hectic activity or not. Our user sleep quality is still
the same.

``` r
activity %>% 
  inner_join(sleepday, by = c("id", "activitydate" = "sleepday")) %>% 
  select(id, activitydate, calories, totalminutesasleep) %>% 
  ggplot(aes(totalminutesasleep, calories)) +
  geom_point() + geom_smooth() +
  labs(x = "Total minutes asleep",
       y = "calories",
       title = "Correlation between calories burn and sleeping quality")
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](bellabeats_files/figure-gfm/corelattion%20between%20sleep%20quality%20and%20calories%20burn-1.png)<!-- -->

# Conclusion

1.  Main consumer that used Bellabeat product is; women how’s active in
    their daily life and workplace, have light activity, and their
    average distance of their daily steps is 5 km. (*We can used this to
    generated more prospect consumers in the future. Because we know our
    main target audience*)
2.  The most active times our user is between 8:00 in the morning and
    their peaks in 20:00 night.
3.  There’s no correlation between `veryactivedistance` group and
    `sedentaryactivedistance` group. That’s mean the intensity of
    activity don’t correlated with quality sleep. Meanwhile
    `moderatlyactivedistance` have more quality sleeps than
    `veryactivedistance` group.
