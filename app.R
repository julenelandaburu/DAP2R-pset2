# Question 3 (40%): Using what you created for question 2, convert it into a 
# Shiny app. Allow at least two elements to be controlled in the UI. For one of 
# the elements, include either 1) a warning that checks for a condition and does 
# not display the plot if the condition is not met or 2) a dynamic input where 
# the second input changes depending on the first. Include in your README file 
# a description of your warning or dynamic input. Save this code as "app.R."

# Note: The edits I did for the data sets are at the end of Q2 R file (I did not 
# add them here because I wanted only the app part to be on this file)

# Packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(sf)
library(shiny)
library(shinyFeedback)
library(plotly)

ui <- fluidPage(
  useShinyFeedback(),
  
  titlePanel("City of Chicago: Public Safety"),
  
  numericInput(inputId = "n", 
               label= "Choose a year between 2019 and 2023", 
               value = 2019),
  
  selectInput(inputId = "color",
              label = "Choose a color",
              choices = c("darkblue", "darkgreen", "darkred", "black"),
              selected = "darkred"),
  
  plotlyOutput("hv")
)

server <- function(input, output) {
  path  <- "C:/Users/Julene/Documents/GitHub/DAP2R-pset2/"
  homicides_community_q3 <- read.csv(paste0(path, "homicides_community_q3.csv"))
  chi_communities <- st_read(file.path(path, "/geo_export_a7c0c31a-6b8e-4c3f-8f41-d685a35da7a1.shp"))
  homicides_community_app <- inner_join(homicides_community_q3, chi_communities, 
                                        by = c("COMMUNITY_AREA" = "community"))
  
  homicides_updated <- reactive({
    valid_year <- input$n >= 2019 & input$n <= 2023
    feedbackWarning("n", !valid_year, "Please choose a year between 2019 and 2023!")
    req(valid_year)
    homicides_community_app %>% 
      filter(YEAR == input$n)
  })
  
  output$hv <- renderPlotly({
    ggplotly(ggplot() +
               geom_sf(data = homicides_updated(), 
                       aes(fill = homicides, geometry = geometry)) +
               scale_fill_gradient(low = "white", high = input$color) + 
               labs(title = "Number of victims of homicides and non-fatal shootings 
                    in each community area", 
                    fill = element_blank(),
                    caption = "Source: City of Chicago") +
               theme_void())
  })
  
}

shinyApp(ui = ui, server = server)