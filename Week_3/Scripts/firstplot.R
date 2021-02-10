## This is my first plot, using bill depth and length for several penguins

## Created by Evan Rank

## Created 2021-02-08

## Load libraries

library(tidyverse)
library(palmerpenguins)
library (here)

##Start dataframe

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) +
## Plot and Label
  geom_point()+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x= "Bill depth (mm)", y = "Bill length (mm)",
       color  = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
  scale_color_viridis_d()
