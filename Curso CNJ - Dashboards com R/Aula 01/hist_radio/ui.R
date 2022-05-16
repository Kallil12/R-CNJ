#-----------------------------------------------------------------------
# ui.R

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                radioButtons(
                    inputId = "COR",
                    label = "Escolha a cor para as barras:",
                    choices = c(
                        "Turquesa"    = "#00CC99",
                        "Azul"        = "#0066FF",
                        "Rosa"        = "#FF3399",
                        "Laranja"     = "#FF6600",
                        "Roxo"        = "#660066",
                        "Verde limão" = "#99FF33"
                    )
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAM")
            )
        )
    )
)
