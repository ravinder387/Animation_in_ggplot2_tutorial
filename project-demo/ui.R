# activate shiny pkg
library(shiny)
library(plotly)
library(tidyverse)

countries <- read_csv("countries.csv")
countries <- countries[,3:ncol(countries)]
emission <- read_csv("historical_emissions.csv")
emission <- emission[2:nrow(emission),]
emission <- emission[,1:25]
emission <- emission |> gather("Year", "CO2_Emission", 6:25)
emission <- emission[,-c(2:5)]
emission <- emission |> arrange(Year)
df <- emission |>
  inner_join(countries, by = "Country")

# build user interface
ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", href = "style.css")
  ),
  
fluidRow(h2("World CO2 Emission Analysis")),
fluidRow(hr()),
fluidRow(
 column(9, 
         plotlyOutput("animationGraph")),
  column(3,
         fluidRow(
           varSelectInput("factor", "Factor", countries[,4:6])
         ),
         fluidRow(
           plotOutput("worldMap")
         )
        
  )
  
)
)