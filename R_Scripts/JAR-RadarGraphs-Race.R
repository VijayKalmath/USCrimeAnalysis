library(fmsb)
source("R_Scripts/readJar.R")

JuvenileList = readJar()
Jdf = data.frame(JuvenileList[3])
Jdf <- Jdf[-c(1,22,43,64,21,42,63,84,20,41,62,83),]
Jdf <- pivot_longer(Jdf,cols = starts_with("Y"),names_to = "Year", values_to = "OffenseValue")

Jdf$Year<-gsub("Y","",as.character(Jdf$Year))
Jdf$Year <- as.numeric(Jdf$Year)
Jdf[is.na(Jdf)] <- 0
Jdf <- as.data.frame(Jdf)

JWhdf <- Jdf %>% filter(Race=="White")
JAAdf <- Jdf %>% filter(Race=="AfricanAmerican")
JAIdf <- Jdf %>% filter(Race=="AmericanIndian")
JAdf <- Jdf %>% filter(Race=="Asian")

Jdf <- Jdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))

JWhdf <- JWhdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))
JAAdf <- JAAdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))
JAIdf <- JAIdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))
JAdf <- JAdf %>% group_by(Offense) %>% summarize(MeanValue = mean(OffenseValue))

JarRacetop6 <- Jdf %>% top_n(6,MeanValue)

JarWhtop6 <- merge(JarRacetop6,JWhdf,by="Offense")
JarWhtop6["MeanValue"] <- JarWhtop6["MeanValue.y"]
JarWhtop6 <- JarWhtop6[,-c(2,3)]

JarAAtop6 <- merge(JarRacetop6,JAAdf,by="Offense")
JarAAtop6["MeanValue"] <- JarAAtop6["MeanValue.y"]
JarAAtop6 <- JarAAtop6[,-c(2,3)]

JarAItop6 <- merge(JarRacetop6,JAIdf,by="Offense")
JarAItop6["MeanValue"] <- JarAItop6["MeanValue.y"]
JarAItop6 <- JarAItop6[,-c(2,3)]

JAtop6 <- merge(JarRacetop6,JAdf,by="Offense")
JAtop6["MeanValue"] <- JAtop6["MeanValue.y"]
JAtop6 <- JAtop6[,-c(2,3)]


JarRacetop6 <- JarRacetop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)

JarWhtop6 <- JarWhtop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)
JarAAtop6 <- JarAAtop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)
JarAItop6 <- JarAItop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)
JAtop6 <- JAtop6 %>% pivot_wider(names_from = Offense, values_from = MeanValue)

JarRacetop6 <- rbind(JarWhtop6, JarAAtop6,JarAItop6,JAtop6)
rownames(JarRacetop6) <- c("White","AfricanAmerican","AmericanIndian","Asian")

JarRacetop6 <- rbind(rep(1500,10) , rep(100,10) ,JarRacetop6)

colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

radarchart(JarRacetop6 , axistype=1 , 
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=2 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
)
legend(x=1, y=1, legend = rownames(as.matrix(JarRacetop6)[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=.8, pt.cex=2)

