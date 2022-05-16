#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip
ht <- hist(x, plot = FALSE)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                plot(ht,
                     col = "#006666",
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação",
                     main = input$TITULO,
                     sub = input$SUBTITULO)

            })
    }
)
