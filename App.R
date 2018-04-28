
library(shiny)
library(shinydashboard)
library(rworldmap)
library(ggplot2)
library(tidyverse)
library(plotly)
library(highcharter)
library(rsconnect)
library(htmlwidgets)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
   
  ),
  #end of sidebar
  dashboardBody()
)

server <- function(input, output) {
 
  
}

shinyApp(ui, server)