#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                textInput(
                    inputId = "TITULO",
                    label = "Texto para o título:",
                    value = ""
                ),
                textInput(
                    inputId = "SUBTITULO",
                    label = "Texto para o subtítulo:",
                    value = ""
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
