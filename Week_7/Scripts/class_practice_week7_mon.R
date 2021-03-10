##Class practice with maps
##by Evan Rank
##2021-03-08


#load libraries
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)

#read in data
popdata <- read.csv(here("Week_7", "Data", "CApopdata.csv"))
stars<-read_csv(here("Week_7","data","stars.csv"))

world <- map_data("world") #map_data gets base layer

head(world)

usa <- map_data("usa")
head(usa)

ggplot()+
  geom_polygon(data = world, aes(x=long, y=lat, group=group, fill=region), color="black")+
               guides(fill= FALSE)+ #stops legend
  theme_minimal()+
  theme(panel.background = element_rect(fill = "lightblue"))+
  coord_map(projection = "mercator", xlim=c(-180, 180)) #change the map projection

states <- map_data("state")
head(states)

counties <- map_data("county")

CA_data <-states %>% 
  filter(region == "california")

ggplot()+
  geom_polygon(data=CA_data, aes(x=long, y=lat, group=group, fill=region))+
  guides(fill= FALSE)+
  theme_minimal()+
 coord_map(projection = "mercator", ylim=c(32.5, 42))

head(counties)

CApop_county<-popdata %>%
  select("subregion" = County, Population)  %>% # rename the county col
  inner_join(counties) %>%
  filter(region == "california") # some counties have same names in other states

ggplot()+
  geom_polygon(data=CApop_county, aes(x=long, y=lat, group=group, fill=Population), color="black")+
  theme_minimal()+
  coord_map()+
  scale_fill_gradient(trans= "log10")+
  geom_point(data = stars, # add a point at all my sites
             aes(x = long,
                 y = lat))+
  labs(size ="# stars/m2")+
  ggsave(here("Week_7", "Output", "CApop.pdf"))
