#install.packages("shiny")  
#install.packages("plotly")  
#install.packages("dplyr")
library("shiny")
library("plotly")
library("dplyr")

#my_server <- function(input, output) {
#  output$plot1<- renderPlot({
  crime_data <- read.csv("Crime_Data.csv")
  crime_data_Udistrict <- crime_data %>% filter(Neighborhood == "UNIVERSITY") 
  crime_data_beat <- crime_data_Udistrict %>% group_by(Beat) %>% summarize(count = n())
  barplot(
          crime_data_beat$count, 
          main=paste("Crime Data in U district"),
          names.arg = crime_data_beat$Beat,
          cex.names=0.8,
          las=2,
          col="red",
          ylab="Frequency",
          xlab="Beat")
  
    
#    })
  
#  }
  