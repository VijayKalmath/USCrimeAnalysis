GVA_ParallelPlot <- function() {
# Parallel Plots from GVA

# X Axis -> Year 
# Y Axis -> Child 
library(hrbrthemes)
library(GGally)
library(viridis)
source("R_Scripts/readGVA.R")

GVAList = readGVA()
Gidf = data.frame(GVAList[2])
Gddf = data.frame(GVAList[3])
Gmdf = data.frame(GVAList[1])

Gidf$IncidentDate <- as.Date(Gidf$IncidentDate,format="%B%d,%Y")
Gidf$Year <- format(Gidf$IncidentDate, format = "%Y")
Gidf$Month <-format(Gidf$IncidentDate, format = "%b")

Gddf$IncidentDate <- as.Date(Gddf$IncidentDate,format="%B%d,%Y")
Gddf$Year <- format(Gddf$IncidentDate, format = "%Y")
Gddf$Month <-format(Gddf$IncidentDate, format = "%b")


Gmdf$IncidentDate <- as.Date(Gmdf$IncidentDate,format="%B%d,%Y")
Gmdf$Year <- format(Gmdf$IncidentDate, format = "%Y")
Gmdf$Month <-format(Gmdf$IncidentDate, format = "%b")


top_10_statesddf <- Gddf  %>% group_by(State) %>% summarise(InjuredCount  = sum(Injured)) %>% ungroup() %>% arrange(desc(InjuredCount)) %>% top_n(10,InjuredCount)

top_10_statesidf <- Gidf  %>% group_by(State) %>% summarise(InjuredCount  = sum(Injured)) %>% ungroup() %>% arrange(desc(InjuredCount)) %>% top_n(10,InjuredCount)

top_10_statesmdf <- Gmdf  %>% group_by(State) %>% summarise(InjuredCount  = sum(Injured)) %>% ungroup() %>% arrange(desc(InjuredCount)) %>% top_n(10,InjuredCount)

Gidf %>% filter(Age != "Adult") %>% group_by(Year,Age) %>% summarise(InjuredCount  = sum(Injured)) %>% pivot_wider(names_from = Year,values_from = InjuredCount) %>% 
  ggparcoord(columns = 2:8, 
             groupColumn=1, 
             scale="globalminmax",
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for Injuries across the Years",
             alphaLines = 0.3
             ) + 
  theme(text = element_text(size = 20)) +
  ylab("Number of Injuries")+
  xlab("Year")+
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )



Gddf %>% filter(Age != "Adult") %>% group_by(Year,Age) %>% summarise(InjuredCount  = sum(Injured)) %>% pivot_wider(names_from = Year,values_from = InjuredCount) %>% 
  ggparcoord(columns = 2:8, 
             groupColumn=1, 
             scale="globalminmax",
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for Death across the Years",
             alphaLines = 0.3
  ) + 
  theme(text = element_text(size = 20)) +
  ylab("Number of Deaths")+
  xlab("Year")+
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )


Gidf <- subset(Gidf, State %in% top_10_statesidf$State)
Gidf  %>% group_by(Year,State) %>% summarise(InjuredCount  = sum(Injured)) %>% pivot_wider(names_from = Year,values_from = InjuredCount) %>% 
  ggparcoord(columns = 2:8, 
             groupColumn=1, 
             scale="globalminmax",
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for Injuries in top 10 States",
             alphaLines = 0.3
  ) + 
  theme(text = element_text(size = 20)) +
  ylab("Number of Injuries")+
  xlab("Year")+
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )


Gddf <- subset(Gddf, State %in% top_10_statesddf$State)
Gddf  %>% group_by(Year,State) %>% summarise(InjuredCount  = sum(Injured)) %>% pivot_wider(names_from = Year,values_from = InjuredCount) %>% 
  ggparcoord(columns = 2:8, 
             groupColumn=1, 
             scale="globalminmax",
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for Deaths in top 10 States",
             alphaLines = 0.3
  ) + 
  theme(text = element_text(size = 20)) +
  ylab("Number of Deaths")+
  xlab("Year")+
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )


Gmdf <- subset(Gmdf, State %in% top_10_statesmdf$State)

Gmdf  %>% group_by(Year,State) %>% summarise(InjuredCount  = sum(Injured)) %>% pivot_wider(names_from = Year,values_from = InjuredCount) %>% 
  ggparcoord(columns = 2:8, 
             groupColumn=1, 
             scale="globalminmax",
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for Mass Shootings in top 10 States",
             alphaLines = 0.3
  ) + 
  theme(text = element_text(size = 20)) +
  ylab("Number of Injured")+
  xlab("Year")+
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )

}