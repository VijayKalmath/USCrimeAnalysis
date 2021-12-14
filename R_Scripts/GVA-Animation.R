GVA_Animation <- function() {
  
source("R_Scripts/readGVA.R")


state_region_mapping <- read.csv("data/processed/GVA/region_state.csv")
state_region_mapping <- state_region_mapping %>% select(State,Region)

GVAList = readGVA()
Gmdf = data.frame(GVAList[1])

Gmdf$IncidentDate <- as.Date(Gmdf$IncidentDate,format="%B%d,%Y")
Gmdf$Year <- format(Gmdf$IncidentDate, format = "%Y")
Gmdf$Month <-format(Gmdf$IncidentDate, format = "%b")

Gmdf <- Gmdf %>% group_by(Year,State) %>% mutate(InjuredCount  = sum(Injured,Killed)) 

Gmdf$Year <- as.numeric(Gmdf$Year)

Gmdf <- merge(Gmdf,state_region_mapping)

Gmdf$Month <- as.factor(Gmdf$Month)
levels(Gmdf$Month) <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")


Gmdf <- Gmdf %>% filter(State %in% c("California","Florida","Illinois","Louisiana","Michigan","NewYork","Texas"))

Gmdf <- Gmdf %>% filter(Month %in% c("Jan","Feb","Mar","Jun","Jul","Aug","Oct","Nov","Dec"))
  
ggplot(Gmdf, aes(x=InjuredCount/1000, y=fct_reorder(State,InjuredCount,max), fill=State)) + 
  geom_bar(stat='identity') +
  facet_grid(~Month, scales = "free_y") + 
  theme_bw() +
  theme(legend.position='none') + 
  labs(title = "Number of Injuries per Month for top 6 States in Year {closest_state}") +
  xlab("Number of Injured in Thousands ")+
  ylab("States")+
  transition_states(Year,wrap=FALSE) +
  ease_aes('linear')

}