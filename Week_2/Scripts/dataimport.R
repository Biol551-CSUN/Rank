##This is my first script, learning to import data
##created by Evan Rank
##created on 2021-02-03

###load libraries###

library(tidyverse)
library(here)

##read in data ###

WeightData<-read_csv(here("Week_2","data","weightdata.csv"))

##Data Analysis ###

head(WeightData)
tail(WeightData)
View(WeightData)


