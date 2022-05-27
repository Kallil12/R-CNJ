#-----------------------------------------------------------------------
#
#         Dashboards e relatórios dinâmicos com R
#
#                                            Prof. Dr. Walmes M. Zeviani
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Este arquivo gera `br_municipal.rds` que contém dados para fazer os
# mapas e `eleicao_prefeito.rds` com os dados de eleições para prefeito.

#-----------------------------------------------------------------------
# Pacotes.

library(geobr)
library(readxl)
library(tidyverse)

# Indica o diretório para o usuário Walmes.
if (Sys.info()["user"] == "walmes") {
    setwd("./ShinyApps/eleicoes_prefeito_1/assets")
}

#-----------------------------------------------------------------------
# Leitura dos arquivos.

# Lista os arquivos `*.xls` do diretório.
xls <- dir(pattern = "*.xls")
xls

# Lê as duas tabelas.
tbs <- map(xls, ~read_xls(.))
str(tbs)

#-----------------------------------------------------------------------
# Juntar as primeiro e segundo turno para determinar o partido que
# ganhou a eleição.

# Empilhar no eixo dos anos.
tbs <- map(tbs,
           function(tb) {
               tb %>%
                   pivot_longer(cols = -c(1:3),
                                names_to = "Ano",
                                values_to = "Partido")
           })

##' tbs[[2]] %>%
##'     drop_na(Partido)

# Teste.
# tb1 <- tibble(id = 1:4, val = 10 * 1:4)
# tb2 <- tibble(id = 4:8, val = 10 * 4:8)
# anti_join(tb1, tb2)
# anti_join(tb2, tb1)

# Junta 1 e 2 turnos.
tb <- full_join(tbs[[1]],
                tbs[[2]],
                by = c("Sigla", "Codigo", "Município", "Ano"),
                suffix = c("_1_turno", "_2_turno"))

# Determina o partido vencedor.
tb <- tb %>%
    mutate(Partido = ifelse(is.na(Partido_2_turno),
                            yes = Partido_1_turno,
                            no = Partido_2_turno),
           Ano = as.integer(Ano),
           Codigo = as.integer(Codigo),
           Partido_1_turno = NULL,
           Partido_2_turno = NULL) %>%
    filter(Ano >= 1990)
str(tb)

tb %>%
    xtabs(~Partido + Ano, data = .)

saveRDS(tb, "eleicao_prefeito.rds")

#-----------------------------------------------------------------------
# Baixa os polígonos dos municípios.

# Lista os anos diponíveis.
list_geobr() %>%
    filter(geography == "Municipality") %>%
    mutate(years = str_split(years, ", ")) %>%
    unnest(years) %>%
    mutate(years = as.integer(years)) %>%
    filter(years > 1980)

if (!file.exists("br_municipal.rds")) {
    br_municipal <- read_municipality(code_muni = "all", year = 2016)
    saveRDS(br_municipal, file = "br_municipal.rds")
} else {
    br_municipal <- readRDS(file = "br_municipal.rds")
}

str(br_municipal)

#-----------------------------------------------------------------------
# Confere os municípios que não tem polígono.

sort(unique(tb$Ano))

tb %>%
    # filter(Ano == 2000) %>%
    distinct(Sigla, Codigo, Município) %>%
    anti_join(select(br_municipal, code_muni),
              by = c("Codigo" = "code_muni"))

# ATTENTION: isso tem que ser resolvido usando as malhas compatíveis com
# cada ano eleitoral. Aqui será usado 2016 para tudo por simplicidade.

#-----------------------------------------------------------------------
