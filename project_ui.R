library(shiny)
library(dplyr)
library(data.table)
library(ggplot2)

my_ui <- fluidPage(
  
  # Application title
  titlePanel("University District Crime"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("sector", label = h3("Sectors:"), 
                         choices = list("L2" = 1, "U1" = 2, "U2" = 3, "U3" = 4),
                         selected = c(1, 2, 3, 4))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1")
    )
  )
)

