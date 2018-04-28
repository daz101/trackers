#
# Author: Daricia Wilkinson
#Purpose: Visualize the prevalence of third party tracks for mobile users 
#Created in Spring 2018 
#Data sets: Based on two data sets from Reuben Binns, researcher at Oxford University 
#see about page for citation 
#

library(shiny)
library(shinydashboard)
require(highcharter)
require(plotly)


dashboardPage(
  dashboardHeader(title = "Is Sharing Caring?"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Mobile Trackers", tabName = "mobile", icon = icon("mobile")), 
      menuItem("Cross-Device Tracking", tabName = "crossdevice", icon = icon("desktop"), badgeLabel = "new", badgeColor = "green"),
      menuItem("Genre Analysis", tabName = "genre", icon = icon("signal", lib = "glyphicon")),
      menuSubItem("Trackers per Genre in Countries", "country"),
      menuItem("Raw Data", tabName = "rawdata", icon = icon("download")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
    
  ),
  dashboardBody(
   tabItems(
    
     #container for home page
     tabItem("dashboard", 
     infoBox("Mobile Apps", 959000, icon = icon("mobile")),
    infoBox("Countries", 10 * 3, icon = icon("globe"), color = "purple"),
    infoBox("Companies", 578, icon = icon("building"), color = "yellow"),
    
  fluidRow(
    box(
      width = 8, status = "info", solidHeader = TRUE,
      title = "Location of Tracking Companies",
      highchartOutput("worldMap")
    ), 
    box(
      width = 3, status = "info", solidHeader = TRUE,
      title = "Top 20 Locations of Trackers",
      tableOutput("trkTable")
    )
    
  )
     ),
    #end of dashboard container 
  
  tabItem("mobile", 
          fluidRow(
            box(
              width = 9, status = "info", solidHeader = TRUE,
              title = "Prominent Mobile Trackers",
              plotlyOutput("bubbles", width = "100%", height = 900),
              verbatimTextOutput("click")
            ),
            box(
              width = 3, status = "info", solidHeader = TRUE,
              title = "Top 20 Mobile Trackers",
              tableOutput("mTable")
            )
          )
          
  ), #end of mobile 
  
  
  tabItem("crossdevice", 
          fluidRow(
            box(
              width = 10, status = "info", solidHeader = TRUE,
              title = "Companies Capable of Cross-Device Tracking with Prevalent Trackers",
              plotlyOutput("cdevice", width = "100%", height = 600)
            )
          )
          ), #end of cross-device tracking
  
  
  tabItem("rawdata", 
          numericInput("maxrows", "Rows to show", 25),
          verbatimTextOutput("rawtable"),
          downloadButton("downloadCsv", "Download as CSV")
          ), #end of raw data 
  
  
  tabItem("genre",
          box(
            width=12, status = "info", solidHeader = TRUE,
            title = "Distribution of Trackers per Genre (based on over 900,000 Apps)",
          plotlyOutput("sumGenre", height = 500, width = "100%")
          )
          ),
  
  
  tabItem("country",
          fluidPage(
          box(
            width= 6, status = "primary", solidHeader = TRUE, 
            title = "Distribution of Trackers in the Game & Entertainment Genre (based on over 900,000 Apps)",
            plotlyOutput("games", width = "100%")
            ),
          
          box(
            width= 6,status = "primary", solidHeader = TRUE, 
            title = "Distribution of Trackers in the Productivity & Tools Genre (based on over 900,000 Apps)",
            plotlyOutput("productivity", width = "100%")
          ),
          
          box(
            width= 6,status = "primary", solidHeader = TRUE, 
            title = "Distribution of Trackers in the Family Genre (based on over 900,000 Apps)",
            plotlyOutput("family", width = "100%")
          )
          )
          ),
  
  
  tabItem("about",
          fluidRow(
            box(
              width = 8, status = "primary",
              title= "About This Project", "The purpose of this project is to visualize prevalent and prominent third-party trackers on mobile and web-based platforms on a global scale."
            ,br(), "The dashboard provides an overview of the most prevalent mobile trackers worldwide. Viewers could review the companies with the most prominent trackers and view the companies with the capability to conduct cross-device tracking"
              ),
            
            box(
              title = "Author", width = 3, background = "light-blue",
              "Author: Daricia Wilkinson", br(), "Purpose: Data Science Class Project"
            )
            ),
            
          fluidRow(
            
            box(
              title = "References", width = 5, background = "maroon",
              "This project is based on two data sets from:", br(), "Binns, Reuben, Ulrik Lyngs, Max Van Kleek, Jun Zhao, Timothy Libert, and Nigel Shadbolt. Third Party Tracking in the Mobile Ecosystem. arXiv preprint arXiv:1804.03603 (2018)."
            , br(), "Binns, Reuben, Jun Zhao, Max Van Kleek, and Nigel Shadbolt. Measuring third party tracker power across web and mobile. arXiv preprint arXiv:1802.02507 (2018)."
              )
            
            
          )
          
          )
  )
  #end of tabitems container
  )
  #end of body
)