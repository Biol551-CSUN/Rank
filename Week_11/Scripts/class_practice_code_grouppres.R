library(devtools)
library(wheatmap)

mtcars_matrix <- as.matrix(mtcars)
mtcars_scale <- scale(mtcars_matrix)
heatmap <- both.cluster(mtcars_scale)
heatmap$mat[,1:4]

BaseHeatmap <- WHeatmap(heatmap$mat, name='h1',
                        yticklabels =TRUE, xticklabels=TRUE, yticklabel.side = 'b', xticklabel.fontsize = 20,
                        cmp = CMPar(brewer.name = 'BuPu'))
BaseHeatmap

map1<-WHeatmap(heatmap$mat, name='h1',
         yticklabels =TRUE, yticklabel.side = 'b', xticklabel.fontsize = 20,
         xticklabels = TRUE, xticklabel.side = 'a',
         cmp = CMPar(brewer.name = 'Spectral'))
map1

Dendrogram <- BaseHeatmap+
  WDendrogram(heatmap$row.clust,
              LeftOf('h1'),
              facing='right')
Dendrogram

map2 <- BaseHeatmap+
  WDendrogram(heatmap$column.clust,
              TopOf('h1'),
              facing='bottom')

Legend <-Dendrogram+
  WLegendV('h1', BottomRightOf('h1', h.pad=.4), 'l1')

Legend

Legend1 <-Dendrogram+
  WLegendV('h1', BottomLeftOf('h1', h.pad = -.2), 'l1')

Legend1

Highlight <- Legend + 
  WRect('h1', c(2,5), c(2,3), col='yellow')

Highlight

library(rinat)
library(tidyverse)

get_inat_obs(query = "Parrotfishes", #query for common name
             quality = "research")

get_inat_obs(query="kelp forest")

get_inat_obs(taxon_id = 53353,
             quality = "research")

Mule_deer <- get_inat_obs(query = "Mule Deer",
                          bounds = c(38.44047, -125, 40.86652, -121.837),
                          quality = 'research',
                          year =2019)


plot(Mule_deer$longitude, Mule_deer$latitude)

get_inat_taxon_stats(place=123751)

library(plotly)

rm(list = ls())

tuesdata <- tidytuesdayR::tt_load('2020-02-18')



view(tuesdata)

fig <- plot_ly(data = food_consumption,
               x= ~co2_emision,
               y= ~consumption)

fig