#install.packages("shiny")  
#install.packages("plotly")  
#install.packages("dplyr")
library("shiny")
library("plotly")
library("dplyr")
library(lubridate)

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
  
  months <- month(as.POSIXct(crime_data_Udistrict$Occurred.Date, format = "%m/%d/%Y"))
  crime_data_Udistrict$Occurred.Date <- months
  frequency_by_month <- group_by(crime_data_Udistrict, Occurred.Date) %>%
    summarize(
      n = n()  
    )
  crime_barplot <- barplot(frequency_by_month$n, names.arg = frequency_by_month$Occurred.Date, horiz = FALSE, col = frequency_by_month$Occurred.Date, 
                           main = paste("Frequency of Crimes in the U District by Month (2008-2017"), 
                           xlab = "Months 1-12", ylab = "Number of Crimes")
  
  crime_data_Udistrict$Primary.Offense.Description <- gsub("(.*)-(.*)", "\\1", crime_data_Udistrict$Primary.Offense.Description)
  ## counts number of each crime
  crime_count <-
    crime_data_Udistrict %>%
    group_by(Primary.Offense.Description) %>%
    summarise(n = n_distinct(Report.Number))
  
  x <- list(title = "Types of Crime")
  y <- list(title = "Frequency")
  crime_pie <-
    plot_ly(
      crime_data_Udistrict,
      labels = ~ crime_count$Primary.Offense.Description,
      values = ~ crime_count$n,
      type = 'pie'
    ) %>%
    layout(
      title = 'Frequency of Each Crime',
      xaxis = list(
        showgrid = FALSE,
        zeroline = FALSE,
        showticklabels = FALSE
      ),
      yaxis = list(
        showgrid = FALSE,
        zeroline = FALSE,
        showticklabels = FALSE
      )
    )
  


#    })

#  }
    