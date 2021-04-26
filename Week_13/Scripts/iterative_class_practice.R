library(tidyverse)
library(here)
library(purrr)

print(paste("The year is", 2000))

years<-c(2015:2021)
for (i in years){ # set up the for loop where i is the index
  print(paste("The year is", i)) # loop over i
}

year_data<-data.frame(matrix(ncol = 2, nrow = length(years))) #Need to preallocate space for the loop

colnames(year_data)<-c("year", "year_name")
year_data

for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over i
  year_data$year[i]<-years[i]
}
year_data

testdata<-read.csv(here("Week_13", "data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

CondPath<-here("Week_13", "data", "cond_data")

files <- dir(path = CondPath,pattern = ".csv")
files

cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")
cond_data

raw_data<-read.csv(paste0(CondPath,"/",files[1])) # test by reading in the first file and see if it works
head(raw_data)

mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp

for(i in 1:length(files)){
  
}

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read.csv(paste0(CondPath,"/",files[i]))
  
  cond_data$filename[i]<-files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
}

#maps in purrr
1:10 %>% #a vector from 1:10; numbber of times we will do the function
  map(rnorm, n=15) %>% #15 random numbers based on normal
  map_dbl(mean) #mean will be a vector of type "double"

#same thing different notation
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

1:10 %>% 
  map(~ rnorm(15, .x)) %>% 
  map_dbl(mean)

CondPath<-here("Week_13", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files

#Or, we can get the full file names in one less step by doing this...

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)
#save the entire path name
files

data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>%  # map everything to a dataframe and put the id in a column called filename
group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data
