# Table 10 , HeatMap 
# UCR Table 8 
library(fmsb)
library(hrbrthemes)
library(GGally)
library(viridis)
source("R_Scripts/readHC.R")

HCTable10 <- read.csv("data/processed/ucr/FBI_UCR_TABLE10.csv")
colnames(HCTable10) <- c("Location","Incidents","Race","Religion","SexualOrientation","Ethnicity","Disability","Year","Gender","GenderIdentity")
HCTable10[is.na(HCTable10)] <- 0

HCTable10 <- HCTable10 %>% filter(Location != "Total" )

HCTable10 <- HCTable10[,-2]

HCTable10 <- HCTable10 %>% group_by(Year) %>% mutate_if(is.numeric,sum) %>% ungroup()

HCTable10 <- HCTable10 %>% pivot_longer( !c(Location,Year) , names_to = "Bias", values_to = "Data")


ggplot(HCTable10, aes(Bias, Location, fill= Data)) + 
  geom_tile() +
  scale_fill_distiller(palette = "Greens") +
  theme_ipsum() 
