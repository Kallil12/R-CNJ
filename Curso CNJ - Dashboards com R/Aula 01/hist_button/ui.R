#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                actionButton(inputId = "TROCAR_COR",
                             label = "Nova cor!")
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
