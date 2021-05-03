

install.packages('modelsummary')
install.packages('tidymodels')
install.packages('broom')
install.packages('flextable')
install.packages('performance')

library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance)
library(modelsummary)
library(tidymodels)

mod<-lm(y~x, data = df) #simple linear

mod<-lm(y~x1 + x2, data = df) #linear regression

mod<-lm(y~x1*x2, data = df) # interaction term, the * will compute x1+x2+x1:x2 

Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

check_model(Peng_mod) # check assumptions of an lm model
anova(Peng_mod)
summary(Peng_mod) #gives coeffs with error
coeffs<-tidy(Peng_mod) # cleans coeffs, just put tidy() around it
coeffs
results<-glance(Peng_mod) #Rsquared, AICs, etc
results


resid_fitted<-augment(Peng_mod) #adds residuals to your original data
resid_fitted

# 'modelsummary'
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
#Save the results as a .docx
modelsummary(models, output = here("Week_13","output","table.docx"))

#canned coefficient model plots

modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names')

models<- penguins %>%
  ungroup()%>% # the penguin data are grouped so we need to ungroup them
  nest(-species) # nest all the data by species
models

models<- penguins %>%
  ungroup()%>% # the penguin data are grouped so we need to ungroup them
  nest(-species) %>% # nest all the data by species 
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))
models

results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance))  # R2 and others
results

results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance)) %>% # R2 and others 
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest()

view(results)
