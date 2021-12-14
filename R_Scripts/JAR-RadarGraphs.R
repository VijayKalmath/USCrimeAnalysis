JarGenderRadar <- function() {

library(fmsb)
source("R_Scripts/readJar.R")

JuvenileList = readJar()
Jdf = data.frame(JuvenileList[2])
Jdf <- Jdf[-c(1,20,21,22,41,42),]
Jdf <- pivot_longer(Jdf,cols = starts_with("Y"),names_to = "Year", values_to = "OffenseValue")

Jdf$Year<-gsub("Y","",as.character(Jdf$Year))
Jdf$Year <- as.numeric(Jdf$Year)
Jdf[is.na(Jdf)] <- 0
Jdf <- as.data.frame(Jdf)
JMendf <- Jdf %>% filter(Gender=="Male")
JFemaledf <- Jdf %>% filter(Gender=="Female")


Jdf <- Jdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))
JMendf <- JMendf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))
JFemaledf <- JFemaledf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))

JarGendertop6 <- Jdf %>% arrange(desc(MeanValue)) %>% top_n(6,MeanValue)

JarMentop6 <- merge(JarGendertop6,JMendf,by="Offense")
JarMentop6["MeanValue"] <- JarMentop6["MeanValue.y"]
JarMentop6 <- JarMentop6[,-c(2,3)]

JarFemaletop6 <- merge(JarGendertop6,JFemaledf,by="Offense")
JarFemaletop6["MeanValue"] <- JarFemaletop6["MeanValue.y"]
JarFemaletop6 <- JarFemaletop6[,-c(2,3)]

JarGendertop6 <- JarGendertop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)

JarMentop6 <- JarMentop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)
JarFemaletop6 <- JarFemaletop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)
JarGendertop6 <- rbind(JarFemaletop6, JarMentop6)
rownames(JarGendertop6) <- c("Female","Male")
JarGendertop6 <- rbind(rep(900,10) , rep(100,10) ,JarGendertop6)

colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

radarchart(JarGendertop6 , axistype=1 , 
#custom polygon
pcol=colors_border , pfcol=colors_in , plwd=2 , plty=1,
#custom the grid
cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
#custom labels
vlcex=0.8,title=paste("Top 5 Offenses by Gender"), 
)
legend(x=2, y=1, legend = rownames(as.matrix(JarGendertop6)[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=.8, pt.cex=2)

}