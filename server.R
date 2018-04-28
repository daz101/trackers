#
# Author: Daricia Wilkinson
#Purpose: Visualize the prevalence of third party tracks for mobile users 
#Created in Spring 2018 
#Data sets: Based on two data sets from Reuben Binns, researcher at Oxford University 
#see about page for citation 


library(shiny)
library(shinydashboard)
library(rworldmap)
library(ggplot2)
library(tidyverse)
library(plotly)
library(highcharter)
library(rsconnect)
library(htmlwidgets)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  #load dataframes 
  mobile_trackers_grouped <- read.csv("mobile_trackers_grouped.csv")
  countriesAllApps <- read.csv("countriesAllApps.csv")
  countryFamily <- read.csv("countryFamily.csv")
  countryProductivity <- read.csv("countryProductivity.csv")
  countryGames <- read.csv("countryGames.csv")
  mobileSubset <- read.csv("mobileSubset.csv")
  countrySubset <- read.csv("countrySubset.csv")
  summaryGenre <- read.csv("summaryGenre.csv")
  grouped_tracking <- read.csv("grouped_tracking.csv")
  
  
  
  
  matched <- joinCountryData2Map(countriesAllApps, joinCode="NAME", nameJoinColumn="country")
  
  output$bubbles<- renderPlotly({
    
    m <- ggplot(data = mobile_trackers_grouped)+geom_boxplot(aes(x = company, y = mTotal, colour = mTotal))+ scale_y_log10() + coord_flip()+ geom_jitter(aes(x = company, y = mTotal, size = mTotal, colour = mTotal, width = 0.3)) + scale_colour_gradient(low = "blue", high = "red")+labs(y= "Prominent Mobile Trackers", x="Parent Companies", color= "No. of Trackers")
    m <- ggplotly(m)
  })
  
  output$cdevice<- renderPlotly({
    
    d <- ggplot(data = grouped_tracking)+geom_point(aes(x = mTotal, y = webTotal, colour = webTotal, name=company))+ scale_y_log10() + coord_flip()+ geom_jitter(aes(x = mTotal, y = webTotal, size = webTotal, colour = webTotal, width = 0.3)) + scale_colour_gradient(low = "blue", high = "red") + scale_x_log10()+ labs(x= "Prevalent Web Trackers", y="Prevalent Mobile Trackers", color= "No. of Trackers")
    d <- ggplotly(d)
  })
  
output$click <- renderPrint({
  p <- event_data("plotly_click")
  if (is.null(p)) "Click events appear here (double-click to clear)" else p
})

  
  output$rawtable <- renderPrint({
    orig <- options(width = 1000)
    print(tail(df(), input$maxrows), row.names = FALSE)
    options(orig)
  })
  
output$mTable <- renderTable({
  mobileSubset
})

output$trkTable<- renderTable({
  countrySubset
})
    
  
output$worldMap <- renderHighchart({
  hc <-hcmap(map = "custom/world-robinson-highres", data = countriesAllApps,joinBy = c("name", "country"), value = "n", name = "country") %>% hc_mapNavigation(enabled = TRUE)
  
  hc
})
  

output$sumGenre <- renderPlotly({
  sumG <- ggplot(data = summaryGenre, aes(x=super_genre, y=total, fill=super_genre)) + geom_bar(stat = "identity") + labs(x="Genres of Apps", y="Number of Trackers per Genre", fill="Genres")
  sumG<- ggplotly(sumG)
})


output$games <- renderPlotly({
  
  gam <- ggplot(data = countryGames, aes(y=total, x=country, fill=country)) + geom_bar(stat = "identity") + labs(y="Number of trackers", x="Country")+ scale_y_log10()
  gam <- ggplotly(gam) 
  
  
})  

output$productivity <- renderPlotly({
  
  prod <- ggplot(data = countryProductivity, aes(y= total, x=country, fill=country)) + geom_bar(stat = "identity") + labs(y="Number of trackers", x="Country")+ scale_y_log10()
  prod <- ggplotly(prod) 
  
  
}) 


output$family <- renderPlotly({
  
  fam <- ggplot(data = countryFamily, aes(y= total, x=country, fill=country)) + geom_bar(stat = "identity") + labs(y="Number of trackers", x="Country")+ scale_y_log10()
  fam <- ggplotly(fam) 
  
  
})
  
})
