## Penguin data mk2
## by Evan Rank
## Updated on 2021-02-09

## Load libraries
library(palmerpenguins)
library(tidyverse)
library (here)
library(ghibli)

##Data loaded as part of package, glimpse to confirm
glimpse(penguins)

##Start data frame

plot1<-ggplot(data=penguins,
       mapping = aes(x= bill_depth_mm,
                    y= bill_length_mm,
                    group = species,
                    color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+
  ##geom_smooth() using formula 'y ~ x'
  labs(x= "Bill depth (mm)",
        y= "Bill length (mm)")+
  
  scale_colour_ghibli_d("MononokeMedium")+
theme_bw()+
theme(axis.title=element_text(size = 20, color="coral"),
panel.background=element_rect(fill="lightsalmon"),
legend.text=element_text(size=15, color="coral2"))+
ggsave(here("Week_3","output","penguinplot.png"),
            width = 8, height=6)

