readGVA <- function(){
  
GVAMassShooting <- read.csv("data/processed/GVA/MassShootingTotalYears.csv")
  
GVAAccidentalInjuries <- read.csv("data/processed/GVA/Accidental_InjuriesAll.csv")

GVAAccidentalDeaths <- read.csv("data/processed/GVA/Accidental_DeathsAll.csv")

colnames(GVAMassShooting) <- c("IncidentID","IncidentDate","State","CityOrCounty","Address","Killed","Injured","Operations")
GVAMassShooting <- GVAMassShooting[-8]

colnames(GVAAccidentalInjuries) <- c("IncidentID","IncidentDate","State","CityOrCounty","Address","Killed","Injured","Operations","Age")  
GVAAccidentalInjuries <- GVAAccidentalInjuries[-8]

colnames(GVAAccidentalDeaths) <- c("IncidentID","IncidentDate","State","CityOrCounty","Address","Killed","Injured","Operations","Age")  
GVAAccidentalDeaths <- GVAAccidentalDeaths[-8]

GVAList <- list(GVAMassShooting,GVAAccidentalInjuries,GVAAccidentalDeaths)
  
return(GVAList)
}
