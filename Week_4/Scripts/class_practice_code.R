##Penguins again
##by Evan Rank
##2021-02-15

##Load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

##Data is contained in package as "penguins"
glimpse(penguins)

##Filter practice
#filter(.data = penguins, year == 2008)
#filter(.data = penguins, body_mass_g > 5000)
filter(.data = penguins, sex == "female", body_mass_g >4000)
#identical to filter(.data = penguins, sex == female & body_mass_g >4000)


filter(.data = penguins, year == 2008 | year == 2009)
       filter(.data = penguins, island != "Dream")
              
              filter(.data = penguins, species == "Adelie" & species == "Gentoo")
              
data2<-mutate(.data = penguins, body_mass_kg = body_mass_g/1000)
view(data2)

data2<-mutate(.data = penguins, body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm)
view(data2)

data2<-mutate(.data=penguins, after_2008 = ifelse(year>2008, "After 2008","Before 2008"))
view(data2)

data2 <- mutate(penguins, sex_cap = ifelse(sex == "male", "Male", "Female"))
view(data2)

penguins %>%
  filter(sex == "female") %>% mutate(log_mass = log(body_mass_g)) %>%
                                      select(species, island, sex, log_mass)

summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
          max_bill_length = max(bill_length_mm, na.rm=TRUE))

penguins %>%
  group_by(island)%>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

#remove NAs drop_na()
penguins %>%
drop_na(sex)

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()
                              