HCtable8_plot <- function() {

library(fmsb)
library(hrbrthemes)
library(GGally)
library(viridis)
source("R_Scripts/readHC.R")

HCList=readHC()
#HCbyOffensedf,HCbyStatedf,HCbyPlacedf,HCbyAgedf,HCTable1,HCTable2_Incidents,HCTable2_Victims,HCTable8)

HC8df = as.data.frame(HCList[8])

HC8df <- HC8df[,-2]
HC8df <- HC8df %>% filter(Biasmotivation != "Total" ) %>% filter(Biasmotivation != "Single-Bias Incidents" )


colnames(HC8df) <- c("Biasmotivation","Individual","FinancialOrgs","Government","ReligiousOrgs","Public","Other","Year")
ggparcoord(HC8df,columns = 2:7, groupColumn = 1,splineFactor = 2.0,
           scale="uniminmax",
           showPoints = TRUE, 
           title = "Incidents wrt Victim Type by BiasMotivation ",
           alphaLines = 0.6
) + 
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=13)
  ) +
  xlab("Victim type for Incidents") + 
  ylab("Incidents Count")

}