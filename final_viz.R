#install.packages("shiny")  
#install.packages("plotly")  
#install.packages("dplyr")
#install.packages("lubridate")
library(shiny)
library(plotly)
library(dplyr)
library(lubridate)
library(data.table)

my_server <- function(input, output) {
  crime_data <- read.csv("Crime_Data.csv")
  crime_data_Udistrict <- crime_data %>% filter(Neighborhood == "UNIVERSITY")
  output$plot1<- renderPlot({
    new_data1 <- crime_data_Udistrict %>%
      filter(as.Date(Reported.Date, "%m/%d/%Y") >= input$dates[1] & as.Date(Reported.Date, "%m/%d/%Y") <= input$dates[2])
    crime_data_beat <- new_data1 %>% group_by(Beat) %>% summarize(count = n())
    barplot(
      crime_data_beat$count, 
      main=paste("Crime Data in U district"),
      names.arg = crime_data_beat$Beat,
      cex.names=0.8,
      las=2,
      col="red",
      ylab="Frequency",
      xlab="Beat")
  })
  
  output$plot2 <- renderPlot({
    new_data2 <- crime_data_Udistrict %>%
      filter(Crime.Subcategory == input$crime)
    months <- month(as.POSIXct(new_data2$Occurred.Date, format = "%m/%d/%Y"))
    new_data2$Occurred.Date <- months
    frequency_by_month <- group_by(new_data2, Occurred.Date) %>%
      summarize(n = n())
    crime_barplot <- barplot(frequency_by_month$n, names.arg = frequency_by_month$Occurred.Date, horiz = FALSE, col = frequency_by_month$Occurred.Date,
                             main = paste("Frequency of Crimes in the U District by Month (2008-2017)"),
                             xlab = "Months 1-12", ylab = "Number of Crimes")
  })
    
  output$plot3 <- renderPlotly({
    new_data3 <- crime_data_Udistrict %>%
      filter(Reported.Time >= input$time[1] & Reported.Time <= input$time[2])
    new_data3$Primary.Offense.Description <- gsub("(.*)-(.*)", "\\1", new_data3$Primary.Offense.Description)
    ## counts number of each crime
    crime_count <-
      new_data3 %>%
      group_by(Primary.Offense.Description) %>%
      summarise(n = n_distinct(Report.Number))
    
    x <- list(title = "Types of Crime")
    y <- list(title = "Frequency")
    crime_pie <-
      plot_ly(
        new_data3,
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
  })
}
    
