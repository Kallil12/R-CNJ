#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                numericInput(
                    inputId = "CEXAXIS",
                    label = "Tamanho do texto dos eixos:",
                    value = 1,
                    min = 0.5,
                    max = 2,
                    step = 0.1
                ),
                numericInput(
                    inputId = "LINE",
                    label = "Distância dos rótulos dos eixos:",
                    value = 3,
                    min = 1,
                    max = 4,
                    step = 0.1
                ),
                numericInput(
                    inputId = "MAR",
                    label = "Tamanho do texto dos eixos:",
                    value = 5,
                    min = 3,
                    max = 7,
                    step = 0.5
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
