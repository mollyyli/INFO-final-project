library(dplyr)
library(plotly)

## reads file, filters university
data <- read.csv("Crime_Data.csv") %>% filter(Neighborhood == "UNIVERSITY")
## takes the first section of each offense to limit the total # of crimes
data$Primary.Offense.Description <- gsub( "(.*)-(.*)", "\\1",  data$Primary.Offense.Description)
## counts number of each crime
crime_count <- data %>% group_by(Primary.Offense.Description) %>% summarise(n = n_distinct(Report.Number))

x <- list(
  title = "Types of Crime"
)
y <- list(
  title = "Frequency"
)

# plotly bar plot
# crime_plot <- 
#  plot_ly(
#    x = crime_count$Primary.Offense.Description,
#    y = crime_count$n,
#    name = "Types of Crime",
#    type = "bar"
#  ) %>%
#  layout(title = "Frequency of Each Crime", xaxis = x, yaxis = y)

## plotly pie chart
crime_pie <- plot_ly(data, labels = ~crime_count$Primary.Offense.Description, values = ~crime_count$n, type = 'pie') %>%
  layout(title = 'Frequency of Each Crime',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))