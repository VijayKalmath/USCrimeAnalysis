readJar <- function(){
  
  JuvelineArrestdf <- read.csv("data/processed/JuvenileArrestRecords/All_JAR_Data.csv")
  
  colnames(JuvelineArrestdf) <- c("Offense","Y1980","Y1981","Y1982","Y1983","Y1984","Y1985","Y1986","Y1987","Y1988","Y1989","Y1990","Y1991","Y1992","Y1993","Y1994","Y1995","Y1996","Y1997","Y1998","Y1999","Y2000","Y2001","Y2002","Y2003","Y2004","Y2005","Y2006","Y2007","Y2008","Y2009","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019")
  
  JuvelineArrestGenderdf <- read.csv("data/processed/JuvenileArrestRecords/JAR_Databy_Gender.csv")
  
  colnames(JuvelineArrestGenderdf) <- c("Offense","Y1980","Y1981","Y1982","Y1983","Y1984","Y1985","Y1986","Y1987","Y1988","Y1989","Y1990","Y1991","Y1992","Y1993","Y1994","Y1995","Y1996","Y1997","Y1998","Y1999","Y2000","Y2001","Y2002","Y2003","Y2004","Y2005","Y2006","Y2007","Y2008","Y2009","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019","Gender")
  
  JuvelineArrestRacedf <- read.csv("data/processed/JuvenileArrestRecords/JAR_Databy_Race.csv")
  
  colnames(JuvelineArrestRacedf) <- c("Offense","Y1980","Y1981","Y1982","Y1983","Y1984","Y1985","Y1986","Y1987","Y1988","Y1989","Y1990","Y1991","Y1992","Y1993","Y1994","Y1995","Y1996","Y1997","Y1998","Y1999","Y2000","Y2001","Y2002","Y2003","Y2004","Y2005","Y2006","Y2007","Y2008","Y2009","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017","Y2018","Y2019","Race")
  
  JuvenileList <- list(JuvelineArrestdf,JuvelineArrestGenderdf,JuvelineArrestRacedf)
  
  return(JuvenileList)
}
