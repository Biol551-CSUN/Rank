##Homework with biogeochemistry data
##by Evan Rank in collaboration with
##20210217


##Load libraries
library(tidyverse)
library(here)

##Load data
ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv"))
View(ChemData)

##Summary statistics
ChemData_clean_spring<-ChemData %>% 
  filter(complete.cases(.)) %>% 
  filter(Season == "SPRING") %>% #Reporting our values specifically for the spring
  separate(col = Tide_time, #split grouped data in same column by "_"
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE)
View(ChemData_clean_spring)
  ChemData_sd<-ChemData_clean_spring %>% #Separate object for summary statistic so we still have clean data for our graph
  pivot_longer(cols =Temp_in:Salinity, #pivoting only the columns we want to calculate
               names_to = "Variables",
               values_to = "Values") %>% 
     group_by(Variables, Zone) %>% #I am interested in how observations change by zone
    summarise(sd_vals = sd(Values, na.rm = TRUE)) %>% #I want the standard error of these values for my final graph
        pivot_wider(names_from = Variables,
              values_from = sd_vals) %>% 
  write_csv(here("Week_4","output", "sd_temp_salinity_spring.csv")) #Exporting with informative file name


##I would like to plot at salinity and temperature specifically during the spring
 ChemData_clean_spring %>% #Data filtered in previous step 
   select(Temp_in, Salinity, Zone) %>%
   ggplot(aes(x=Temp_in, y=Salinity, color=Zone))+
   geom_point()+
   geom_smooth()+
 labs(title="Temperature vs Salinity By Zone",
      subtitle="For aquatic biogeochemistry data",
      x="Temperature",
      y="Salinity")+
 scale_color_viridis_d()#Colorblind friendly color scale
   