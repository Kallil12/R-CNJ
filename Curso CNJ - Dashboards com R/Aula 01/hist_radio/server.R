#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip
ht <- hist(x, plot = FALSE)

shinyServer(
    function(input, output) {
        output$HISTOGRAM <-
            renderPlot({

                plot(ht,
                     col = input$COR,
                     main = NULL,
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação"
                     )

            })
    }
)
