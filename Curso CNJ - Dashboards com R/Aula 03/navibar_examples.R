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

my_slider_input <-
    sliderInput(
        inputId = "NUMERO_DE_CLASSES",
        label = "Número de classes:",
        min = 1,
        max = 30,
        step = 1,
        value = 10)

my_select_input <-
    selectInput(
        inputId = "COR_BARRAS",
        label = "Cor das barras:",
        choices = c("Vermelho" = "red",
                    "Verde" = "green",
                    "Azul" = "blue"),
        selected = "red")

my_checkbox_input <-
    checkboxInput(
        inputId = "MOSTRAR_RUG",
        label = "Marcar sobre eixo com os valores?",
        value = FALSE)

my_footer <- tagList(
    hr(),
    HTML("<center>Dashboards e relatórios dinâmicos com R</center>")
)

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
        output$ECDF <- renderPlot({
            plot(ecdf(precip), col = input$COR_BARRAS)
            if (input$MOSTRAR_RUG) {
                rug(x)
            }
        })
        output$DENSIDADE <- renderPlot({
            plot(density(precip), col = input$COR_BARRAS)
            if (input$MOSTRAR_RUG) {
                rug(x)
            }
        })
    }
)

#-----------------------------------------------------------------------
# Visões por aba.

# NOTE: nessa aplicação dá pra ver que o shiny tem comportamento "lazy".

# browseURL("https://mastering-shiny.org/basic-reactivity.html#laziness")
#
# One of the strengths of declarative programming in Shiny is that it
# allows apps to be extremely lazy. A Shiny app will only ever do the
# minimal amount of work needed to update the output controls that you
# can currently see.

ui <- fluidPage(
    titlePanel("Menus de navegação 1 · Usando abas"),
    #----------------------------------------
    # Essa parte sempre vai estar visível.
    fluidRow(
        column(width = 4,
               my_slider_input),
        column(width = 4,
               my_select_input),
        column(width = 4,
               my_checkbox_input)
    ),
    #----------------------------------------
    # Abas permitem mudar entre gráficos.
    tabsetPanel(
        tabPanel(title = "Histograma",
                 plotOutput("HISTOGRAMA")),
        tabPanel(title = "Densidade",
                 plotOutput("DENSIDADE")),
        tabPanel(title = "Acumulada",
                 plotOutput("ECDF"))
    ),
    #----------------------------------------
    # Isso também é fixo, é um rodapé.
    my_footer
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Página com menu vertical na lateral.

# Descrição: Cria um menu lateral de navegação com itens um abaixo ao
# outro.

ui <- fluidPage(
    titlePanel("Menus de navegação 2 · Usando itens na lateral"),
    navlistPanel(
        widths = c(3, 9),
        #------------------------------------
        # Essa parte sempre vai estar visível.
        header = fluidRow(
            column(width = 4,
                   my_slider_input),
            column(width = 4,
                   my_select_input),
            column(width = 4,
                   my_checkbox_input)
        ),
        #------------------------------------
        # Abas permitem mudar entre gráficos.
        tabPanel(title = "Histograma",
                 plotOutput("HISTOGRAMA")),
        tabPanel(title = "Densidade",
                 plotOutput("DENSIDADE")),
        tabPanel(title = "Acumulada",
                 plotOutput("ECDF")),
        #------------------------------------
        # Isso também é fixo, é um rodapé.
        footer = my_footer
    )
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Página com menu horizontal.

# Descrição: Cria um menu de navegação superior com guias um ao lado do
# outro.

ui <- fluidPage(
    navbarPage(
        title = "Aplicação",
        #------------------------------------
        # Essa parte sempre vai estar visível.
        header = tagList(
            titlePanel("Menus de navegação 3 · Menu superior na página"),
            fluidRow(
                column(width = 4,
                       my_slider_input),
                column(width = 4,
                       my_select_input),
                column(width = 4,
                       my_checkbox_input)
            )
        ),
        #------------------------------------
        # Abas permitem mudar entre gráficos.
        tabPanel(title = "Histograma",
                 plotOutput("HISTOGRAMA")),
        tabPanel(title = "Densidade",
                 plotOutput("DENSIDADE")),
        tabPanel(title = "Acumulada",
                 plotOutput("ECDF")),
        #----------------------------------------
        # Isso também é fixo, é um rodapé.
        footer = my_footer
    )
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
# Página com menus e entradas nos menus.

# Descrição: Cria um menu de navegação superior com um menu no último
# item do menu contendo algumas entradas.

ui <- navbarPage(
    navbarPage(
        title = "Aplicação",
        #------------------------------------
        # Essa parte sempre vai estar visível.
        header = tagList(
            titlePanel("Menus de navegação 3 · Menu superior na página"),
            fluidRow(
                column(width = 4,
                       my_slider_input),
                column(width = 4,
                       my_select_input),
                column(width = 4,
                       my_checkbox_input)
            )
        ),
        #------------------------------------
        # Um item no próprio menu.
        tabPanel(title = "Histograma",
                 plotOutput("HISTOGRAMA")),
        #------------------------------------
        # Outros itens como entradas do menu.
        navbarMenu(
            title = "Outros gráficos",
            tabPanel(title = "Densidade",
                     plotOutput("DENSIDADE")),
            tabPanel(title = "Acumulada",
                     plotOutput("ECDF"))
        ),
        #------------------------------------
        # Isso também é fixo, é um rodapé.
        footer = footer
    )
)

shinyApp(ui = ui, server = server)

#-----------------------------------------------------------------------
