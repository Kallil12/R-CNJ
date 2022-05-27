#-----------------------------------------------------------------------
#
#         Dashboards e relatórios dinâmicos com R
#
#                                            Prof. Dr. Walmes M. Zeviani
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

library(shiny)
library(plotly)

# Função para posicionar os elementos.
div_placeholder <- function(content = "PLACEHOLDER",
                            color = "#d2d2d2",
                            height = "3em") {
    css <- c(sprintf("background-color: %s;", color),
             "padding: 5px;",
             "margin: 5px;",
             # "border: 1px solid black;",
             "border-radius: 5px;",
             sprintf("height: %s;", height))
    div(content,
        style = paste0(css, collapse = " "))
}

fluidPage(
    titlePanel("Título da aplicação"),
    includeCSS("www/style.css"),
    sidebarLayout(
        sidebarPanel(
            width = 2,
            # Input de Unidade Federativa.
            #div_placeholder("UNIDADE FEDERATIVA",
             #               color = "#f494dc"),
            selectInput(inputId = "UF",
                        label = "Unidade Federativa",
                        choices = sort(unique(br_municipal$abbrev_state)),
                        selected = "RN"),
            # Input de Ano Eleitoral.
            selectInput(inputId = "ANO", 
                        label = "Ano eleitoral",
                        choices = sort(unique(tb$Ano)),
                        selected = 2000)
        ),
        mainPanel(
            flowLayout(
                # Caixas de informação.
                div_placeholder("ANO SELECIONADO",
                                color = "#f4a57e",
                                height = "5em"),
                div_placeholder("UF SELECIONADA",
                                color = "#f4a57e",
                                height = "5em"),
                div_placeholder("TOTAL DE PREFEITURAS",
                                color = "#f4a57e",
                                height = "5em"),
                div_placeholder("PERCENTUAL DE PREFEITURAS",
                                color = "#f4a57e",
                                height = "5em")
            ),
            # Mapa.
                   # Gráfico de barras.
            plotOutput("MAP"),
            plotOutput("BARPLOT"),
            reactableOutput("TABLE")
        )
    )
)

#-----------------------------------------------------------------------
