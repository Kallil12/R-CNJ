#-----------------------------------------------------------------------
# ui.R

library(shiny)

choi <- names(swiss)[-1]

shinyUI(
    fluidPage(
        titlePanel("Regressão múltipla"),
        sidebarPanel(
            checkboxGroupInput(
                inputId = "VARIAVEIS",
                label = "Selecione as variáveis independentes:",
                choices = choi,
                selected = choi[1:2]
            )
        ),
        mainPanel(
            verbatimTextOutput("SUMMARY_LM")
        )
    )
)
