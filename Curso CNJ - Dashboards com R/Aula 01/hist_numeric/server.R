#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip
ht <- hist(x, plot = FALSE)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                m <- input$MAR
                par(mar = c(m, m, 1, 1))

                plot(ht,
                     col = "#660066",
                     main = NULL,
                     axes = FALSE,
                     ann = FALSE,
                     xaxt = "n",
                     yaxt = "n"
                     )
                box(bty = "L")

                axis(side = 1, cex.axis = input$CEXAXIS)
                axis(side = 2, cex.axis = input$CEXAXIS)

                title(
                    ylab = "Frequência absoluta",
                    xlab = "Precipitação",
                    line = input$LINE
                )

            })
    }
)
