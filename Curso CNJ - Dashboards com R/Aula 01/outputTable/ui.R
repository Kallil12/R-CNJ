#-----------------------------------------------------------------------
# ui.R

library(shiny)

choi <- names(mtcars)

shinyUI(
    fluidPage(
        titlePanel("Tabela de dados mtcars"),
        sidebarPanel(
            checkboxGroupInput(
                inputId = "VARIAVEIS",
                label = "Selecione as variáveis:",
                choices = choi,
                selected = choi[1:4]
            )
        ),
        mainPanel(
            dataTableOutput("TABELA")
        )
    )
)
