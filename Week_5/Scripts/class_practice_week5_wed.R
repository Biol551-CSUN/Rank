##Class practice/notes for WEek 5 Wednesday
##by Evan Rank
##2021-02-24

##Load libraries
library(tidyverse)
library(here)
library(lubridate)

now()
now(tzone = "GMT")
today()

ymd("2021-02-24")

ymd_hms("2021-02=24 10:22:20 PM")

mdy_hms("02/24/2021 22:22:20")
#make a character string (c for vector)
datetimes<-c("02/24/2021 22:22:20", 
             "02/25/2021 11:21:10", 
             "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes)
month(datetimes)

datetimes + hours(4)

hour(datetimes) #hour is for printing the hour, hours is for changing the number. Can do the same with, minutes, seconds, months, years etc

round_date(datetimes, "minute")

CondData <-read_csv(here("Week_5","data", "CondData.csv"))

CondDate <- CondData %>%
  mutate(DateTime = ymd_hms(date))

view(CondDate)
  

