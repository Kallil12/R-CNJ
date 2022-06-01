library(shiny)
library(reactable)
library(htmltools)
library(sf)
library(readxl)
library(tidyverse)
library(plotly)

ui <- fluidPage(
  titlePanel("Pagina"),
  tabsetPanel(
    tabPanel("Guia 1"),
    tabPanel("Guia 2"),
    tabPanel("Guia 3")
  )
)

server <- shinyServer(
  function(input, output, session) {
    NULL
  }
)

div_create <- function(content, color) {
  css <- c(sprintf("background-color: %s;", color),
           "margin: 1px;",
           "height: 4em;")
  div(content,
      style = paste0(css, collapse = " "))
}

shinyApp(ui = ui, server = server)