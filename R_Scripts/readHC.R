readHC <- function(){
  
HCbyOffensedf <- read.csv("data/processed/ucr/annual_hc_by_offense_type.csv")
# "Offense" "X2010"   "X2011"   "X2012"   "X2013"   "X2014"   "X2015"   "X2016"   "X2017"   "X2018"   "X2019"  

colnames(HCbyOffensedf) <- c("Offense","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCbyStatedf <- read.csv("data/processed/ucr/annual_hc_by_state.csv")
colnames(HCbyStatedf) <- c("States","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCbyPlacedf <- read.csv("data/processed/ucr/annual_hc_count_by_place.csv")
colnames(HCbyPlacedf) <- c("Place","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCbyAgedf <- read.csv("data/processed/ucr/annual_offenders_by_age.csv")
colnames(HCbyAgedf) <- c("AgeCategory","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCTable1 <- read.csv("data/processed/ucr/FBI_UCR_TABLE1.csv")
colnames(HCTable1) <- c("Biasmotivation","Incidents","Victims","Year")

HCTable2_Incidents <- read.csv("data/processed/ucr/FBI_UCR_TABLE2_Incidents.csv")
colnames(HCTable2_Incidents) <- c("Crime","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCTable2_Victims <- read.csv("data/processed/ucr/FBI_UCR_TABLE2_Victims.csv")
colnames(HCTable2_Victims) <- c("Crime","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")

HCTable8 <- read.csv("data/processed/ucr/FBI_UCR_TABLE8.csv")
colnames(HCTable8) <- c("Biasmotivation","Incidents","Individual","Business_FinancialInstitutions","Government","ReligiousOrganization","Society_Public","Other","Year")

HCList <- list(HCbyOffensedf,HCbyStatedf,HCbyPlacedf,HCbyAgedf,HCTable1,HCTable2_Incidents,HCTable2_Victims,HCTable8)

return (HCList)
}