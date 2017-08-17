library(leaflet)
library(shiny)
library(htmltools)

quake <- read.csv("2.5_month_us.csv")

ui <- fluidPage(
  titlePanel("U.S. Earthquakes in Past Month, 8/17/2017"),
  titlePanel("click for more details"),
  leafletOutput("mymap")

)

server <- function(input, output) {
  
  output$mymap <- renderLeaflet({
    leaflet(quake) %>% 
    addTiles() %>%
    addCircleMarkers(~longitude,~latitude, 
                       radius = ~ 7,
                       color = ~ color,
                       fill = FALSE, weight = 4,
                       popup = ~htmlEscape(place)) %>% 
    addLegend(labels = c("> 5", "4 - 5", "3 - 4", "2 - 3"), 
                colors = c("red", "darkorchid", "darkorange", "dodgerblue" ), 
                title = "Magnitude")
  })
}

shinyApp(ui, server)
