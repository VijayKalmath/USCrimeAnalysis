Jar_Heatmap_plot <- function() {
# Heat Map for JAR Data
library(ggplot2)
library(hrbrthemes)
source("R_Scripts/readJar.R")



JuvenileList = readJar()
Jdf = data.frame(JuvenileList[3])

Jdf <- Jdf[-c(1,22,43,64,21,42,63,84,20,41,62,83),]

Jdf <- pivot_longer(Jdf,cols = starts_with("Y"),names_to = "Year", values_to = "OffenseValue")

Jdf$Year<-gsub("Y","",as.character(Jdf$Year))
Jdf$Year <- as.numeric(Jdf$Year)
Jdf[is.na(Jdf)] <- 0
Jdf <- as.data.frame(Jdf)

Jdf <- Jdf %>% group_by(Year) %>% mutate(cumulative = sum(OffenseValue))
Jdf <- Jdf %>% mutate(prop = OffenseValue/cumulative)


ggplot(Jdf) + 
  geom_tile(aes(x=Year, y=fct_reorder(Offense,prop), fill= prop)) +
  scale_fill_distiller(palette = "YlOrBr",direction = 1) +
  facet_wrap(~ Race)+
  ggtitle("Type of Offense by Year Heatmap (by Gender and Incidents)")+
  ylab("Type of Offense")+
  xlab("Incidents")
}