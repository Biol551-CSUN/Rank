##Class practice for Week 5 with  data practicing joins with data from Becker and Silbiger
##By Evan Rank
##2021-02-22

##Load libraries
library(tidyverse)
library(here)

##Load data
#environmental data form each site
EnviroData<-read_csv(here("Week_5","data", "site.characteristics.data.csv"))

#thermal performance data
TPCData<-read_csv(here("Week_5","data","Topt_data.csv"))

#Data wrangling
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, values_from = values) %>% 
  arrange(site.letter)#rearrange data by site letter alphabetical. could also do
#coldest-to-warmest etc

FullData_left <-left_join(TPCData, EnviroData_wide) %>%  #needs at least one same column (site.letter)
#if there was an extra site on the right hand data frame it would be excluded, but in this case nothing is missing in the left site
relocate(where(is.numeric), .after = where(is.character)) #relocate all numberic after character

FullData_left %>% 
  group_by(site.letter) %>% 
summarise_at(vars(E:substrate.cover), list(mean = mean, var = var), na.rm = TRUE)

T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
            Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
             pH = c(7.3, 7.8, 8.1, 7.9))

inner_join(T1, T2)
full_join(T1, T2)
semi_join(T1, T2)
anti_join(T1, T2)

install.packages ('cowsay')
library(cowsay)
say("help", by = 'egret')
