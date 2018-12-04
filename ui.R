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
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(6,
           img(src='Seattle-Police-Department-SPD-north-precinct.png', align = "right")       
    ),
    column(6,
           plotOutput("plot1"),
           wellPanel(
             dateRangeInput("dates",
                            label = h4("Date Range:"),
                            start = "2008-01-01",
                            end = "2017-12-31"
             )
           )
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
           )
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
           )
    )
  )
)

shinyUI(my_ui)
