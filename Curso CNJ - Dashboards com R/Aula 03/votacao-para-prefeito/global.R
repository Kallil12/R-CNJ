#-----------------------------------------------------------------------
#
#         Dashboards e relatórios dinâmicos com R
#
#                                            Prof. Dr. Walmes M. Zeviani
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(reactable)
library(htmltools)
library(sf)
library(readxl)
library(tidyverse)

library(shiny)
library(plotly)

# Indica o diretório para o usuário Walmes.
if (Sys.info()["user"] == "walmes" & interactive()) {
    setwd("./ShinyApps/eleicoes_prefeito_1")
}

#-----------------------------------------------------------------------
# Lê os arquivos preparados com o `create_assets.R` em `./assets`.

tb <- readRDS("assets/eleicao_prefeito.rds")
str(tb)

br_municipal <- readRDS("assets/br_municipal.rds")
str(br_municipal)


#-----------------------------------------------------------------------
# Função para filtar os dados.

filter_data <- function(tb,
                        br_municipal,
                        unidade_federativa = "MS",
                        ano_eleitoral = 2000) {

    if (!is.null(unidade_federativa)) {
        tb_estado <- tb %>%
            filter(Sigla == unidade_federativa)
        br_estado <- br_municipal %>%
            filter(abbrev_state == unidade_federativa)
    } else {
        tb_estado <- tb
        br_estado <- br_municipal
    }

    if (!is.null(ano_eleitoral)) {
        tb_estado <- tb_estado %>%
            filter(Ano == ano_eleitoral)
    } else {
        tb_estado <- tb_estado
    }

    tb_estado <-
        left_join(tb_estado,
                  select(br_estado, code_muni, geom),
                  by = c("Codigo" = "code_muni"))
    attr(tb_estado, "sf_column") <- attr(br_estado, "sf_column")

    tb_estado <- tb_estado %>%
        mutate(Partido = reorder(factor(Partido), Partido, length),
               Partido_lump = Partido,
               Partido_lump = fct_lump_n(Partido_lump, n = 4,
                                         other_level = "Outros"),
               Partido_lump = fct_infreq(Partido_lump),
               Partido_lump = fct_relevel(Partido_lump, "Outros",
                                          after = Inf)) %>%
        drop_na(Partido_lump)

    tb_count <- tb_estado %>%
        count(Partido, sort = TRUE) %>%
        mutate(freq = 100 * n/sum(n))

    list(tb_count = tb_count,
         tb_estado = tb_estado)
}

##' filter_data(tb, br_municipal, "MS", 2000)

#-----------------------------------------------------------------------
# Gráficos e tabelas.

make_barplot <- function(tb_count,
                         unidade_federativa = "MS",
                         ano_eleitoral = 2000) {
    ggplot(data = tb_count,
           mapping = aes(y = Partido, x = n)) +
        geom_col() +
        geom_label(mapping = aes(label = sprintf("%0.1f%%", freq))) +
        labs(x = "Número de prefeituras",
             title = sprintf("Ano eleitoral de %s para %s",
                             ano_eleitoral,
                             unidade_federativa)) +
        expand_limits(x = c(NA, 1.1 * max(tb_count$n)))
}

##' tb_test <- filter_data(tb, br_municipal, "MS", 2000)
##' make_barplot(tb_test$tb_count, "MS", 2000)
##' rm(tb_test)

make_cloropleth <- function(tb_estado,
                            unidade_federativa = "MS",
                            ano_eleitoral = 2000) {
    ggplot() +
        geom_sf(data = tb_estado,
                mapping = aes(geometry = geom,
                              fill = factor(Partido_lump)),
                color = "white",
                size = 0.15,
                show.legend = TRUE) +
        labs(subtitle = sprintf("Municípios conforme partido do prefeito eleito em %s",
                                ano_eleitoral),
             size = 8,
             title = sprintf("Votações para %s",
                             unidade_federativa)) +
        theme_minimal() +
        labs(fill = "Partido")
}

##' tb_test <- filter_data(tb, br_municipal, "MS", 2000)
##' make_cloropleth(tb_test$tb_estado, "MS", 2000)
##' rm(tb_test)

make_table <- function(tb_count, tb_estado) {
    tbl <- reactable(
        tb_count,
        pagination = FALSE,
        columns = list(
            n = colDef(
                name = "Prefeituras",
                defaultSortOrder = "desc",
                cell = function(value) {
                    width <- paste0(value * 100 / max(tb_count$n), "%")
                    value <- format(value, big.mark = ",")
                    value <- format(value, width = 9, justify = "right")
                    bar <- div(
                        class = "bar-chart",
                        style = list(marginRight = "6px"),
                        div(class = "bar",
                            style = list(width = width,
                                         backgroundColor = "#131991"))
                    )
                    div(class = "bar-cell",
                        span(class = "number", value),
                        bar)
                }
            ), # n
            freq = colDef(
                name = "Porcentagem",
                defaultSortOrder = "desc",
                cell = JS("function(cellInfo) {
                               // Format as percentage
                               const pct = (cellInfo.value).toFixed(1) + '%'
                               // Pad single-digit numbers
                               let value = pct.padStart(5)
                               // Show % on first row only
                               if (cellInfo.viewIndex > 0) {
                                 value = value.replace('%', ' ')
                               }
                               // Render bar chart
                               return (
                                 '<div class=\"bar-cell\">' +
                                   '<span class=\"number\">' + value + '</span>' +
                                   '<div class=\"bar-chart\" style=\"background-color: #e1e1e1\">' +
                                     '<div class=\"bar\" style=\"width: ' + pct + '; background-color: #0a7350\"></div>' +
                                   '</div>' +
                                 '</div>'
                               )
                               }"
                          ),
                html = TRUE
            ) # freq
        ), # columns
        details = function(index) {
            partido <- tb_count$Partido[index]
            partido_data <- tb_estado[
                tb_estado$Partido == partido,
                c("Município"), drop = FALSE]
            # htmltools::div(style = "padding: 16px",
            #                reactable(partido_data, outlined = TRUE))

            remainder <- length(partido_data$Município) %% 4
            if (remainder > 0) {
                y <- c(partido_data$Município, rep(NA_character_, 4 - remainder))
            } else {
                y <- c(partido_data$Município)
            }
            u <- as.data.frame(matrix(y, ncol = 4))
            htmltools::div(style = "padding: 16px",
                           reactable(u,
                                     defaultColDef = colDef(
                                         header = function(value) "Município"),
                                     outlined = FALSE))
        }
    )
    return(tbl)
}

##' tb_test <- filter_data(tb, br_municipal, "MS", 2000)
##' make_table(tb_test$tb_count, tb_test$tb_estado)
##' rm(tb_test)

#-----------------------------------------------------------------------
