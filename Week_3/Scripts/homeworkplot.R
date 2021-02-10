##Week 3 Homework - Palmer Pengiuns
##by Evan Rank in collaboration with Group 3
##2021-02-10

##Load packages
library(palmerpenguins)
library(tidyverse)
library(here)
library(ghibli)

penguin <- drop_na(penguins)

ggplot(data=penguins,
       mapping=aes(x=island,
         y=body_mass_g))+
  geom_boxplot()+
geom_jitter(data = penguin,
            aes(x=island,
                y=body_mass_g,
                color=sex),
            position=position_jitterdodge(dodge=0.5))+
labs(title="Penguin Body Mass by Sex",
     subtitle="For Biscoe, Dream, and Torgersen Islands",
     x="Island",
     y="Body Mass (g)",
     color= "Sex")+
  scale_color_manual(labels=c("Female", "Male"),
                     values=c("213148FF","#2C1D16FF"))+
theme_gray()+
  theme(axis.title=element_text(size = 20, color="#5C5344FF"),
        panel.background=element_rect(fill="bisque1"),
        legend.text=element_text(size=15, color="#2C1D16FF"))
ggsave(here("Week_3","output","homeworkplot.png"),
       width = 8, height=6)
