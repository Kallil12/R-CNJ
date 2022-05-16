#-----------------------------------------------------------------------
# server.R

library(shiny)

x <- precip
ht <- hist(x)


shinyServer(
    function(input, output) {
        output$HISTOGRAMA <-
            renderPlot({

                plot(ht,
                     family = input$FONT_FAMILY,
                     font = as.integer(input$FONT_STYLE),
                     col = "#FF9200",
                     main = NULL,
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação")


            })
    }
)

# ATTENTION: Agora para mudar a fonte de um gráfico é mais laborioso.
# Confira uma solução em:
# https://stackoverflow.com/questions/28034091/how-to-use-different-fonts-in-an-r-shiny-plot
