JarBoxPlots_RacePLot <- function() {

# This for Box plot for Juvenile Arrest Records faceted by Race
source("R_Scripts/readJar.R")

JuvenileList = readJar()
JRdf = data.frame(JuvenileList[3])

JRdf <- JRdf[-c(1,22,43,64,21,42,63,84,20,41,62,83),]

JRdf <- pivot_longer(JRdf,cols = starts_with("Y"),names_to = "Year", values_to = "OffenseValue")

JRdf$Year<-gsub("Y","",as.character(JRdf$Year))
JRdf$Year <- as.numeric(JRdf$Year)
JRdf[is.na(JRdf)] <- 0
JRdf <- as.data.frame(JRdf)


JRWhiteplot <- ggplot(JRdf %>% filter(Race=="White"), aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("White")+
  xlab("Type of Offense")+
  ylab("Incidents")+
  coord_flip()

JRAAplot <- ggplot(JRdf %>% filter(Race=="AfricanAmerican"), aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("African American")+
  xlab("Type of Offense")+
  ylab("Incidents")+
  coord_flip()

JRAIplot <- ggplot(JRdf %>% filter(Race=="AmericanIndian"), aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("American Indian")+
  xlab("Type of Offense")+
  ylab("Incidents")+
  coord_flip()

JRAplot <- ggplot(JRdf %>% filter(Race=="Asian"), aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  xlab("Type of Offense")+
  ylab("Incidents")+
  ggtitle("Asian")+
  coord_flip()



final_plot <- JRWhiteplot + JRAAplot + JRAIplot + JRAplot
final_plot

}