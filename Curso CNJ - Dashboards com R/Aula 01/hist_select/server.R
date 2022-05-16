#-----------------------------------------------------------------------
# server.R

library(shiny)

shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                L <-
                    switch(
                        input$DATASET,
                        precip = list(x = precip,
                                      xlab = "Precipitação anual média (polegadas)"),
                        rivers = list(x = rivers,
                                      xlab = "Comprimento dos rios (milhas)"),
                        islands = list(x = islands,
                                       xlab = "Área de ilhas (1000 milhas quadradas)")
                    )

                hist(L$x,
                     breaks = input$NUMERO_DE_CLASSES,
                     col = "#8F0047",
                     main = NULL,
                     ylab = "Frequência absoluta",
                     xlab = L$xlab)
                rug(L$x)

        })
    }
)
