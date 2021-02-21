##Class practice with biogeochemistry data
##by Evan Rank
##20210217


##Load libraries
library(tidyverse)
library(here)

##Load data
ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv"))

ChemData_clean<-ChemData %>% 
  filter(complete.cases(.)) %>%  #filters out anything that is not a complete row
separate(col =Tide_time,
         into = c("Tide","Time"),
         sep = "_", #separate by
         remove = FALSE) %>% #keep the original column around
  unite(col = "Site_Zone",
        c(Site,Zone),
        sep = ".",
        remove = FALSE)

ChemData_long <-ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, #columns wanting to pivot
               names_to = "Variables",
               values_to = "Values")
ChemData_long %>% 
  group_by(Variables, Site, Zone, Tide) %>% 
  summarise(Param_means = mean(Values, na.rm =TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))

ChemData_long %>% 
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")

ChemData_wide<-ChemData_long %>% 
pivot_wider(names_from = Variables, 
            values_from = Values)

ChemData_clean<-ChemData %>% 
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time,
            into = c("Tide", "Time"),
            sep = "_",
            remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>% 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% 
  write_csv(here("Week_4","output", "summary.csv"))