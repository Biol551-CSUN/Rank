##Class practice for Week 8 Wednesday
##by Evan Rank
##2021-03-24

##Load Libraries
library(tidyverse)
library(here)
library(palmerpenguins)
library(PNWColors)

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)

)

head(df)

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)), 
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))
#key steps for making a function
#-name
#-arguments (inputs) for the function (x, y, z etc)
#place code you have developed in the body of thje function
#return tells us what valeus we want



rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm =TRUE)-min(x, na.rm = TRUE))
  return(value)}
}
  
df %>% 
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

temp_C <- (temp_F -32) * 5/9

fahrenheit_to_celsius <- function() {temp_C <- (temp_F -32) * 5/9
return(temp_C)}

celsius_to_kelvin <- function(temp_C) {temp_K <- (temp_C+273.15)
return(temp_K)}

celsius_to_kelvin(100)

myplot<-function(data,x, y){
pal<-pnw_palette("Lake", 3, type='discrete')

ggplot(data, aes(x=x, y=y, color=island))+
  geom_point()+
  geom_smooth(method = 'lm')+
  scale_color_manual("Island", values=pal)+
  theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = flipper_length_mm) #no worky worky without curly curly from {rlang}

myplot<-function(data,x, y){
  pal<-pnw_palette("Lake", 3, type='discrete')
  
  ggplot(data, aes(x={{x}}, y={{y}}, color=island))+
    geom_point()+
    geom_smooth(method = 'lm')+
    scale_color_manual("Island", values=pal)+
    theme_bw()
}

#with default data set:

myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Lake", 3, type='discrete')
  
  ggplot(data, aes(x={{x}}, y={{y}}, color=island))+
    geom_point()+
    geom_smooth(method = 'lm')+
    scale_color_manual("Island", values=pal)+
    theme_bw()
}

myplot(x = body_mass_g, y= flipper_length_mm)+ #can still layer with +
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")

#aside on if-else

a <- 4
b <- 5

if (a >b){
  f<-20
} else { f<-10}
f

myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

myplot(x = body_mass_g, y = flipper_length_mm, lines=FALSE)
myplot(x = body_mass_g, y = flipper_length_mm)

install.packages("fortunes")
library(fortunes)
fortune()
