#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                sliderInput(
                    inputId = "NUMERO_DE_CLASSES",
                    label = "Número de classes:",
                    min = 1,
                    max = 30,
                    step = 1,
                    value = 10
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
