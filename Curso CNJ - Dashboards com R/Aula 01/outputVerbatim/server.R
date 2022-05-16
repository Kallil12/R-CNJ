#-----------------------------------------------------------------------
# server.R

library(shiny)

shinyServer(
    function(input, output) {
        output$SUMMARY_LM <-
            renderPrint({
                m0 <- lm(Fertility ~ 1 + .,
                         data = swiss[, c("Fertility", input$VARIAVEIS)]
                         )
                summary(m0)
            })
    }
)
