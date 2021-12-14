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

ggplot(Gmdf, aes(x=InjuredCount, y=fct_reorder(State,InjuredCount,max), fill=State)) + 
  geom_bar(stat='identity') +
  facet_grid(~Month, scales = "free_y") + 
  theme_bw() +
  theme(legend.position='none') + 
  labs(title = "{closest_state}") +
  transition_states(Year,wrap=FALSE) +
  ease_aes('linear')

}