library(tidyverse)
library(readxl)

url <- "dados/Base de Dados Justiça Estadual 2020 CNJ.xlsx"
da <- read_excel(url)
## Abra o arquivo para ver que a planilha não tem apenas a tabela
str(da)

## Especifica o range de linhas e colunas a serem lidas
da <- read_excel(url, range = "A3:Q31")
str(da)

summary(da)

sapply(da, function(x) any(is.na(x)))

ggplot(da, aes(x = eff)) +
    geom_histogram(bins = 10)

ggplot(da, aes(x = Estados, y = eff)) +
    geom_point() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência") +
    theme_bw()

ggplot(da, aes(x = Estados, y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(da, aes(x = reorder(Estados, eff), y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(da, aes(x = reorder(Estados, -eff), y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(da, aes(x = reorder(Estados, eff), y = eff)) +
    geom_col() +
    ## scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência") +
    coord_flip()

ggplot(da, aes(x = pop, y = pib,
               color = Estados)) +
    geom_point()

da %>%
    filter(pop > 3e7) %>%
    select(Estados, pop)

da %>%
    filter(pop < 2e8) %>%
    ggplot(aes(x = pop, y = pib,
               color = Estados)) +
    geom_point() +
    geom_smooth(method = "lm")

da %>%
    filter(pop < 2e8) %>%
    ggplot(aes(x = log(pop), y = log(pib))) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(da, aes(x = log(pop), y = log(pib))) +
    geom_point() +
    geom_smooth(method = "lm")

ggsave("grafico.png")
