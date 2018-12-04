library(shiny)
library(dplyr)
library(data.table)
library(ggplot2)

my_ui <- fluidPage(
  
  # Application title
  titlePanel("University District Crime"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(6,
      plotOutput("plot1"),
      wellPanel(
        dateRangeInput("dates",
                       label = h4("Date Range:"),
                       start = "2008-01-01",
                       end = "2017-12-31"
        )
      )
    ),
    column(6,
      plotOutput("plot2"),
      wellPanel(
        selectInput("crime", 
                    label = h4("Crime Type:"), 
                    choices = as.vector(unique(crime_data_Udistrict$Crime.Subcategory))
        )
      )
    )
  ),
  hr(),
  fluidRow(
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

