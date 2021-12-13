HCtable8_plot <- function() {

# UCR Table 8 
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



ggparcoord(HC8df,columns = 2:7, groupColumn = 1,splineFactor = 6.0,
           scale="uniminmax",
           showPoints = TRUE, 
           title = "No scaling",
           alphaLines = 0.6
) + 
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    legend.position="none",
    plot.title = element_text(size=13)
  ) +
  xlab("")

}