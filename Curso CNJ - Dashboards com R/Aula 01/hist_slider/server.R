#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip

# Extremos com amplitude estendida em 5%.
a <- extendrange(x, f=0.05)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                bks <- seq(from = a[1],
                           to = a[2],
                           length.out = input$NUMERO_DE_CLASSES + 1)
                hist(x,
                     breaks = bks,
                     main = NULL,
                     col = "#008A8A",
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação")
            })
    }
)
