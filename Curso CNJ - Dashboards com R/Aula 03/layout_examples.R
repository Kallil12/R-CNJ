#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(shiny)

#-----------------------------------------------------------------------
# Define os inputs aqui para apenas reusá-los.

div_style <- c("background-color: #e8e8e8;",
               "padding: 1em;",
               "border: 1px solid black;",
               "border-radius: 10px;")

my_slider_input <-
    div(style = paste0(div_style, collapse = " "),
        sliderInput(
            inputId = "NUMERO_DE_CLASSES",
            label = "Número de classes:",
            min = 1,
            max = 30,
            step = 1,
            value = 10))

my_select_input <-
    div(style = paste0(div_style, collapse = " "),
        selectInput(
            inputId = "COR_BARRAS",
            label = "Cor das barras:",
            choices = c("Vermelho" = "red",
                        "Verde" = "green",
                        "Azul" = "blue"),
            selected = "red"))

my_checkbox_input <-
    div(style = paste0(div_style, collapse = " "),
        checkboxInput(
            inputId = "MOSTRAR_RUG",
            label = "Marcar sobre eixo com os valores?",
            value = FALSE))

# O server será o mesmo em todas as aplicações.
server <- shinyServer(
    function(input, output, session) {
        x <- precip
        a <- extendrange(x, f = 0.05)
        output$HISTOGRAMA <- renderPlot({
            bks <- seq(from = a[1],
                       to = a[2],
                       length.out = input$NUMERO_DE_CLASSES + 1)
            hist(precip,
                 breaks = bks,
                 main = NULL,
                 col = input$COR_BARRAS,
                 ylab = "Frequência absoluta",
                 xlab = "Precipitação")
            if (input$MOSTRAR_RUG) {
                rug(x)
            }
        })
    }
)

#-----------------------------------------------------------------------
# Layout responsivo em grupos de colunas que se empilham.

# NOTE: o `fluidRow()` é interessante para layouts na forma de grid
# que se adaptam para mobile.

ui <- fluidPage(
    titlePanel("Layout 1 · Responsivo em colunas"),
    fluidRow(
        column(width = 4,
               my_slider_input),
        column(width = 4,
               my_select_input),
        column(width = 4,
               my_checkbox_input)
    ),
    fluidRow(
        column(width = 12,
               plotOutput("HISTOGRAMA"))
    )
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Layout responsivo em elementos que se empilham.

# NOTE: o `flowLayout()` é interessante para apresentar caixas de
# informação (infoboxes).

ui <- fluidPage(
    titlePanel("Layout 2 · Responsivo em elementos enfileirados"),
    flowLayout(
        my_slider_input,
        my_select_input,
        my_checkbox_input
    ),
    plotOutput("HISTOGRAMA")
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Layout com menu lateral e área principal.

# NOTE: o `sidebarLayout()` é uma disposição com a qual estamos muito
# acostumados por isso ele é muito utilizado.

ui <- fluidPage(
    titlePanel("Layout 3 · Menu lateral e área principal"),
    sidebarLayout(
        sidebarPanel(
            my_slider_input,
            my_select_input,
            my_checkbox_input
        ),
        mainPanel(
            plotOutput("HISTOGRAMA")
        )
    )
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Layout com divisão horizontal que não empilha.

ui <- fluidPage(
    titlePanel("Layout 4 · Em colunas mas sem disposição responsiva"),
    splitLayout(
        my_slider_input,
        my_select_input,
        my_checkbox_input
    ),
    plotOutput("HISTOGRAMA")
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Layout com disposição vertical, já empilhado.

ui <- fluidPage(
    titlePanel("Layout 5 · Disposição na forma vertical como uma pilha"),
    verticalLayout(
        my_slider_input,
        my_select_input,
        my_checkbox_input
    ),
    plotOutput("HISTOGRAMA")
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
