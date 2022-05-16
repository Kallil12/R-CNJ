#-----------------------------------------------------------------------
# server.R

library(shiny)

shinyServer(
    function(input, output) {
        output$TABELA <-
            renderDataTable({
                mtcars[, input$VARIAVEIS]
            },
            options = list(orderClasses = TRUE)
            )
    }
)
