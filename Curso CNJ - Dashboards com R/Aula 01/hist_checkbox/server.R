#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip

ht <- hist(x, plot = FALSE)
col <- rep("#3366CC", length(ht$counts))

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                if (input$MOSTRAR_MODA) {
                    col[which.max(ht$counts)] <- "#142952"
                }

                plot(ht,
                     col = col,
                     main = NULL,
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação"
                     )

                if (input$MOSTRAR_RUG) {
                    rug(x)
                }

            })
    }
)
