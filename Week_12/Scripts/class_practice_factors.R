##class practice code for factors

library(tidyverse)
library(here)

tuesdata <- tidytuesdayR::tt_load(2021, week = 7)
income_mean<-tuesdata$income_mean

#read.csv() yields all factors
#read_csv() reads strings as characters

starwars %>% 
  filter(!is.na(species)) %>% 
  count(species, sort = TRUE)

star_counts <- starwars %>% 
  filter(!is.na(species)) %>% 
  mutate(species = fct_lump(species, n=3)) %>% 
  count(species)

star_counts %>% 
  ggplot(aes(x=species, y=n))+
  geom_col() #counts will not be in order

star_counts %>% 
  ggplot(aes(x=fct_reorder(species, n), y=n))+ #reorders species from least to greatest
  geom_col()

star_counts %>% 
  ggplot(aes(x=fct_reorder(species, n, .desc = TRUE), y=n))+ #default is ascending, lets flip it
  geom_col()+
  labs(x= "Species")

total_income<-income_mean %>%
  group_by(year, income_quintile)%>%
  summarise(income_dollars_sum = sum(income_dollars))%>%
  mutate(income_quintile = factor(income_quintile)) # make it a factor

ggplot(total_income, aes(x=year, y=income_dollars_sum, color=income_quintile))+
  geom_line() 
ggplot(total_income, aes(x=year, y=income_dollars_sum, 
                         color=fct_reorder2(income_quintile,year,income_dollars_sum)))+
  geom_line()



x1 <- factor(c("Jan", "Mar", "Apr", "Dec")) 
x1#the levels appear alphabetical, what to do?

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec")) #manually reordering levels in a vector
x1 

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) # only keep species that have more than 3
starwars_clean

#check levels
levels(starwars_clean$species)

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>% 
  droplevels() #eliminate all levels so that the levels from factors before the subset go away

#Recode a level
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor 
  filter(n>3)  %>% # only keep species that have more than 3 
  droplevels() %>% # drop extra levels 
  mutate(species = fct_recode(species, "Humanoid" = "Human"))
starwars_clean

