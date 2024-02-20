# activate shiny pkg
library(shiny)
library(plotly)
library(tidyverse)
library(sf)

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

# world continent
cont <- st_read("World_Continents/World_Continents.shp")

# server script
server <- function(input, output) {
  # animation graph area
  output$animationGraph <- renderPlotly({
    p <- ggplot(df, aes(.data[[input$factor]], CO2_Emission, color = Continent)) +
      geom_point(aes(size = Population, frame = Year, ids = Country)) +
      scale_color_manual(values =c("#99ffcc","#ccff33", "#66ccff",
                                   "#ff99ff","#ffcc66" , "#ffff00") ) +
      scale_x_log10() 
    
    fig <- ggplotly(p)
    
    fig <- fig %>% 
      animation_opts(
        1000, easing = "linear", redraw = FALSE
      )
    fig
})
  
  output$worldMap <- renderPlot({
    ggplot() +
      geom_sf(aes(fill = CONTINENT), data = cont) +
      scale_fill_manual(values = c("#99ffcc", "grey", "#ccff33","#ccff33", "#66ccff",
                                   "#ff99ff","#ffcc66" , "#ffff00")) + 
      theme(axis.line=element_blank(),axis.text.x=element_blank(),
            axis.text.y=element_blank(),axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),legend.position="none",
            panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),plot.background=element_blank())
    
  })
}
