library(shiny)
library(dplyr)
library(plotly)
library(data.table)
library(ggplot2)
library(rsconnect)

crime_data <- read.csv("Crime_Data.csv")
crime_data_Udistrict <- crime_data %>% filter(Neighborhood == "UNIVERSITY")

my_ui <- fluidPage(
  
  # Application title
  titlePanel("University District Crime"),
  fluidRow(
    paste("This data originates from the Seattle Police Department which we accessed via API. This dataset contains all of the reported incidents in the greater Seattle area from 2008-2017. We narrowed down the dataset for this application to just the reports within the University District.")
  ),
    
    
  
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(6,
           img(src='Seattle-Police-Department-SPD-north-precinct.png', align = "right") 
           ,
           paste("The map represents each sector in Seattle. L1, U1, U2, and U3 are sectors at UW")

    ),
    column(6,
           plotOutput("plot1"),
           wellPanel(
             dateRangeInput("dates",
                            label = h4("Date Range:"),
                            start = "2008-01-01",
                            end = "2017-12-31"
             )
           ),
           paste("The question we asked was 'Where do crime happen the most often in Udistrict' Use the Date Range to select a date range"), 
           paste("to see the frequencies of crimes in different sections of U District")
    )
  ),
  hr(),
  fluidRow(
    column(6,
           plotOutput("plot2"),
           wellPanel(
             selectInput("crime", 
                         label = h4("Crime Type:"), 
                         choices = as.vector(unique(crime_data_Udistrict$Crime.Subcategory))
             )
           ),
           paste("The question we asked was 'when do crimes occur most often?' Use the drop down menu to compare the frequencies of"), 
           paste("crimes by type of crime over the months in a year.")
    ),
    column(6,
           plotlyOutput("plot3"),
           wellPanel(
             sliderInput("time", 
                         label = h4("Time Window:"), 
                         min = 0, 
                         max = 2359, 
                         value = c(0, 2359)
             )
           ),
           paste("The question we asked was 'what is the frequency of each crime?'. The widget controls the time window of the crimes in military time.")
    )
  )
)

shinyUI(my_ui)
