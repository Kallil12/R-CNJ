#-----------------------------------------------------------------------
# server.R

library(shiny)

ht <- hist(precip, plot = FALSE)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                col <- sample(colors(), size = 1)
                plot(ht,
                     main = input$TROCAR_COR,
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação",
                     col = col,
                     sub = col)

            })
    }
)
