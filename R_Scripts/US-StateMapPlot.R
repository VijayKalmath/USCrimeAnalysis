# GVA Map Plot 

library(usmap)
library(ggplot2)

library(hrbrthemes)
library(GGally)
library(viridis)
source("R_Scripts/readGVA.R")

GVAList = readGVA()
Gidf = data.frame(GVAList[2])
Gddf = data.frame(GVAList[3])
Gmdf = data.frame(GVAList[1])



Gmdf$IncidentDate <- as.Date(Gmdf$IncidentDate,format="%B%d,%Y")
Gmdf$Year <- format(Gmdf$IncidentDate, format = "%Y")
Gmdf$Month <-format(Gmdf$IncidentDate, format = "%b")

Gmdf <- Gmdf %>% group_by(Year,State) %>% summarise(InjuredCount  = sum(Injured,Killed)) 

Gmdf <- rename_with(Gmdf,tolower)
Gmdf$year <- as.numeric(Gmdf$year)



map_with_animation <- plot_usmap(data = Gmdf, values = "injuredcount", color = "black") + 
  scale_fill_continuous(low = "green", high = "red",name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right") +
  transition_states(year) +
  ggtitle('Year: {closest_state}')

map_with_animation

anim_save("GVA-MassShootingUSMap.gif")
