##Homework Script Week 4 Monday
##by Evan Rank in collaboration with Group 3
##2021-02-15

##Load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ghibli)

##Data is contained in package as "penguins"
glimpse(penguins)

##Calculate mean and variance of body mass by species, island, and sex w/o NAs
mean_varcalc <- penguins %>% 
  group_by(species, island, sex) %>% 
  drop_na(sex, body_mass_g, island, species) %>% 
summarise(mean_body_mass_g = mean(body_mass_g, na.rm = TRUE), 
          var_body_mass_g = var(body_mass_g, na.rm = TRUE))
          
          view(mean_varcalc)
          
##log_fem
  penguins%>%
  filter(sex != "male") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_mass) %>% 
  ggplot(aes(x=species, y=log_mass))+
            geom_violin()+
    geom_jitter(aes(x=species, y=log_mass, color=island),
                position=position_jitterdodge(dodge=.5))+
           labs(title="Log Body Mass of Female Penguins by Species",
                subtitle="For Biscoe, Dream, and Torgersen Islands",
                x="Species",
                y="Log Body Mass (g)")+
    theme_bw()+
 
    theme(axis.title=element_text(size = 20, color="#06141FFF"),
          panel.background=element_rect(fill="#3D4F7DFF"),
          legend.text=element_text(size=15, color="#2C1D16FF"))+
  scale_colour_ghibli_d("YesterdayMedium", direction = -1)
  
  ggsave(here("Week_4","output","homeworkplotweek4mon.png"),
         width = 8, height=6)
  
  
  