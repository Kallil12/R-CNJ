#-----------------------------------------------------------------------
# server.R

library(shiny)

# Teste.
# input <- list(HEIGHT = "10", FONT = "Times", COLOR = "red")

fragment <- '
<style>
 p { line-height: %s; }
</style>
<p>
    <font face="%s" font color="%s">
        Aqui temos um texto qualquer que muda de cor!
    </font>
</p>
<p>
    <font color="%s">
        Esse aqui também muda.
    </font>
</p>
'

shinyServer(
    function(input, output) {
        output$TEXT <-
            renderPrint(
                cat(
                    sprintf(fragment,
                            input$HEIGHT,
                            input$FONT,
                            input$COLOR,
                            input$COLOR)
                    )
            )
    }
)
