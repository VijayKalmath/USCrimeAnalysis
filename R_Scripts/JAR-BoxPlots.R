JarBoxPlots <- function() {
  # This for  Box plot  plot for Juvenile Arrest Records faceted by Gender
  source("R_Scripts/readJar.R")
  
  JuvenileList = readJar()
  JuvelineArrestGenderdf = data.frame(JuvenileList[2])
  
  JuvelineArrestGenderdf <- JuvelineArrestGenderdf[-c(1,20,21,22,41,42),]
  
  JuvelineArrestGenderdf <- pivot_longer(JuvelineArrestGenderdf,cols = starts_with("Y"),names_to = "Year", values_to = "OffenseValue")
  
  JuvelineArrestGenderdf$Year<-gsub("Y","",as.character(JuvelineArrestGenderdf$Year))
  JuvelineArrestGenderdf$Year <- as.numeric(JuvelineArrestGenderdf$Year)
  JuvelineArrestGenderdf[is.na(JuvelineArrestGenderdf)] <- 0
  JuvelineArrestGenderdf <- as.data.frame(JuvelineArrestGenderdf)
  
  
  tdf <- JuvelineArrestGenderdf %>% group_by(Offense) %>% mutate(OffenseSum = sum(OffenseValue)) %>% ungroup() %>% select(Offense,OffenseSum) %>% unique() %>% arrange(desc(OffenseSum)) %>% top_n(10,OffenseSum)
  
  Male <- JuvelineArrestGenderdf %>% filter(Gender=="Male")
  Male <- merge(Male,tdf)
  JuvelineArrestGenderMalePlot <- ggplot(Male, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
    geom_boxplot() + 
    theme(text = element_text(size = 20)) +
    ggtitle("Male")+
    xlab("Type of Offense")+
    ylab("Incidents")+
    coord_flip()
  
  female <- JuvelineArrestGenderdf %>% filter(Gender=="Female")
  female <- merge(female,tdf)
  JuvelineArrestGenderFemalePlot <- ggplot(female, aes(x=reorder(Offense,OffenseValue,median), y=OffenseValue) ) +
    geom_boxplot() +
    theme(text = element_text(size = 20)) +
    ggtitle("Female")+
    xlab("Type of Offense")+
    ylab("Incidents")+
    coord_flip()
  
  final_plot <- JuvelineArrestGenderMalePlot + JuvelineArrestGenderFemalePlot
  final_plot
}