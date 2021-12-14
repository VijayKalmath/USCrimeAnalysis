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

tdf <- JRdf %>% group_by(Offense) %>% mutate(OffenseSum = sum(OffenseValue)) %>% ungroup() %>% select(Offense,OffenseSum) %>% unique() %>% arrange(desc(OffenseSum)) %>% top_n(10,OffenseSum)

white <- JRdf %>% filter(Race=="White")
white <- merge(white,tdf)

aa <- JRdf %>% filter(Race=="AfricanAmerican")
aa <- merge(aa,tdf)

ai <- JRdf %>% filter(Race=="AmericanIndian")
ai <- merge(ai,tdf)

A <- JRdf %>% filter(Race=="Asian")
A <- merge(A,tdf)


JRWhiteplot <- ggplot(white, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("Spread of White Arrestees for Offenses in Year 2000 - 2019")+
  xlab("Type of Offense")+
  ylab("Incidents")+
  coord_flip()

JRAAplot <- ggplot(aa, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("African American")+
  ggtitle("Spread of African American for Offenses in Year 2000 - 2019")+
  ylab("Incidents")+
  coord_flip()

JRAIplot <- ggplot(ai, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  ggtitle("Spread of American Indian Arrestees for Offenses in Year 2000 - 2019")+
  xlab("Type of Offense")+
  ylab("Incidents")+
  coord_flip()

JRAplot <- ggplot(A, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
  geom_boxplot() + 
  theme(text = element_text(size = 20)) +
  xlab("Type of Offense")+
  ylab("Incidents")+
  ggtitle("Spread of Asian Arrestees for Offenses in Year 2000 - 2019")+
  coord_flip()

final_plot <- JRWhiteplot + JRAAplot + JRAIplot + JRAplot
final_plot

}