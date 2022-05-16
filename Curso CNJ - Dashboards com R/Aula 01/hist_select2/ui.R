#-----------------------------------------------------------------------
# ui.R

library(shiny)

# fml <- names(X11Fonts())
fml <- c("Helvetica Neue", "Times New Roman", "Arial")
fnt <- c("plain" = 1,
         "bold" = 2,
         "italic" = 3,
         "bold-italic" = 4)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                radioButtons(
                    inputId = "FONT_FAMILY",
                    label = "Escolha a fonte:",
                    choices = fml,
                    selected = "serif"
                ),
                radioButtons(
                    inputId = "FONT_STYLE",
                    label = "Escolha a fonte:",
                    choices = fnt,
                    selected = 1
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
