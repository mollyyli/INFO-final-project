library(shiny)

# Run the application 
source("project_ui.R")
source("final_viz.R")
shinyApp(ui = my_ui, server = my_server)

