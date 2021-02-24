##Week 5 Homework with COnductivity and Depth Data
##by Evan Rank in collaboration with Group 3
##2021-02-24

##Load libraries

library(tidyverse)
library(here)
library(lubridate)

##Read in data

CondData <-read_csv(here("Week_5","data", "CondData.csv"))
DepthData <-read_csv(here("Week_5", "data", "DepthData.csv"))

view(CondData)
view(DepthData)

##Manipulate dataframe dates to prep join
CondData<-CondData %>%
  mutate(date = ymd_hms(date)) %>% 
  mutate(date = round_date(date, "10secs")) ##rounding to sync different dataframes for join
 DepthData<-DepthData %>% 
   mutate(date = ymd_hms(date)) %>% 
   mutate(date = round_date(date, "10secs")) ##rounding to sync for join

##Join data
FullData <- inner_join(CondData, DepthData)
view(FullData)

FullData <- FullData %>% 
  mutate(hourmin = paste(hour(date), minute(date), sep = ":")) ##extracting hour/minute
view(FullData)

##Summarize and plot

FullData %>% 
  group_by(hourmin) %>% ##now we can take our means for each minute
  summarise(date_avg = mean(date),
            depth_avg = mean(Depth),
            temp_avg = mean(TempInSitu),
            sal_avg = mean (SalinityInSitu_1pCal)) %>%
  write_csv(here("Week_5","Output", "means_depthcond.csv")) %>% #pipe into ggplot2
  ggplot(aes(x=depth_avg, y=sal_avg, color=temp_avg))+
  geom_point()+#scatter to see if there is a relationship between depth and salinity
labs(title="Depth vs Salinity",
     subtitle="Averaged by Minute", #instead of putting "mean" everywhere, I will clarify here
     x="Depth (m)",
     y="Salinity (ppt)",
     color="Temperature (C)")+
  ggsave(here("Week_5","Output","hw_depthcond_plot.png"),
                                     width = 8, height=6)
