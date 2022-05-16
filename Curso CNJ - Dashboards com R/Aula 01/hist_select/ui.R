#-----------------------------------------------------------------------
# ui.R

library(shiny)

nclass <- c("Sturges", "Scott", "Freedman-Diaconis")
obj <- c("precip", "rivers", "islands")

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                selectInput(
                    inputId = "DATASET",
                    label = "Escolha o conjunto de dados:",
                    choices = obj
                ),
                selectInput(
                    inputId = "NUMERO_DE_CLASSES",
                    label = "Escolha a regra para número de classes:",
                    choices = nclass
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
