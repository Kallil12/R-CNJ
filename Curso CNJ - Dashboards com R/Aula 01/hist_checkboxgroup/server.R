#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip
ht <- hist(x, plot = FALSE)
nc <- length(ht$counts)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                seqcol <- colorRampPalette(input$CORES)

                plot(ht,
                     col = seqcol(nc),
                     main = NULL,
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação"
                     )

            })
    }
)
