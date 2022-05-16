#-----------------------------------------------------------------------
# server.R

library(shiny)
library(xtable)

shinyServer(
    function(input, output) {
        output$SUMMARY_AOV <-
            renderPrint({

                m0 <- lm(Fertility ~ 1 + .,
                         data = swiss[, c("Fertility", input$VARIAVEIS)]
                )
                print(xtable(anova(m0)), type = "html")

            })
    }
)
