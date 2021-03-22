##Class practice for Week 8 for several packages
##by Evan Rank
##2021-03-22

##Load libraries
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)


##Graph side by side patchwork
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()


p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)

p1/p2+
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

view(mtcars)

##ggrepel
ggplot(mtcars, aes(x=wt,
                   y=mpg,
                   label=rownames(mtcars)))+
  geom_text_repel()+ #or geom_label_repel for boxes
  geom_point(color = 'red')

##gganimate
penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species))+
  geom_point()+
  transition_states(
    year, #what to animate by
    transition_length = 2, #relative length between transitions
    state_length = 1 #length of the pause between transitions
  )+
  ease_aes("sine-in-out")+
  ggtitle('Year: {closest_state}')+
  anim_save(here("Week_8","output","mypengiungif.gif"))

##Magick for image processing

penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  ggsave(here("Week_8","output","penguinplot.png"))

penplot<-image_read(here("Week_8","output","penguinplot.png"))
out <- image_composite(penplot, penguin, offset = "+70+30", gravity = "center")
out