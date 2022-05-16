#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                checkboxInput(
                    inputId = "MOSTRAR_RUG",
                    label = "Marcar sobre eixo com os valores?",
                    value = FALSE
                ),
                checkboxInput(
                    inputId = "MOSTRAR_MODA",
                    label = "Destacal a classe modal?",
                    value = FALSE
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
