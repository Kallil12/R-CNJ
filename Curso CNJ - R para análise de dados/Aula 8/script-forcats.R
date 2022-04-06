##======================================================================
## Operações com fatores.

##----------------------------------------------------------------------
## Carrega o pacote.

library(tidyverse)

##----------------------------------------------------------------------
## Dados de população dos estados.

url <- "http://leg.ufpr.br/~walmes/data/jog_europaleague_2014-05-04.txt"
tb <- read_tsv(url)[]
tb

tb %>%
    select(where(is.character)) %>%
    str()

## Converte variáveis para fator.
tb <- tb %>%
    mutate(across(c("TeamName", "PositionText", "RegionCode"),
                  as.factor))

tb %>%
    select(where(is.factor)) %>%
    str()


## Percentual de missing nas variáveis que possem.
tb %>%
    summarise(across(.fns = ~sum(is.na(.))/length(.))) %>%
    select_if(~.>0) %>%
    t()

##----------------------------------------------------------------------
## Contar níveis, exibir rótulos e determinar a frequência.

## Determinar o número de níveis do fator.
tb$PositionText %>%
    nlevels()

## Conhecer rótulo dos níveis do fator.
tb$PositionText %>% fct_unique() # Retorna como fator.
tb$PositionText %>% levels()     # Retorna como character.

## Padroniza nomes.
tb$PositionText <- tb$PositionText %>%
    fct_relabel(.fun = "str_to_title")
tb$PositionText %>%
    levels()

## Conta a ocorrência de cada nível.
tb %>%
    count(PositionText, sort = TRUE)
tb$PositionText %>%
    fct_count(sort = TRUE)

## NOTE: os NA são contados também.
tb %>%
    count(RegionCode, sort = TRUE)
tb$RegionCode %>%
    fct_count(sort = TRUE)

##-----------------------------------------------------------------------
## Mudar a disposição/ordem dos níveis de um fator.

## Coloca os níveis em ordem inversa.
tb$PositionText %>%
    fct_rev() %>%
    levels()

## Aleatoriza a posição dos níveis.
tb$PositionText %>%
    fct_shuffle() %>%
    levels()

## Coloca a ordem conforme a frequência de cada nível.
tb$PositionText %>%
    fct_infreq() %>%
    levels()

tb$PositionText %>%
    fct_infreq() %>%
    fct_rev() %>%
    levels()

## Ordena os níveis conforme estatísticas de outra variável.
with(tb, tapply(Goals, PositionText, sum))
with(tb, tapply(Goals, PositionText, mean))

tb$PositionText %>%
    fct_reorder(.x = tb$Goals, "sum") %>%
    levels()

tb$PositionText %>%
    fct_reorder(.x = tb$Goals, "mean") %>%
    levels()

## Muda a disposição manualmente.
tb$PositionText %>%
    fct_relevel("Goalkeeper", after = 2) %>%
    levels()

##----------------------------------------------------------------------
## Aumentar ou reduzir o número de níveis.

## Cria um fator com o número de gols.
tb$Goals <- factor(tb$Goals, levels = 0:max(tb$Goals))

## Conta a ocorrência.
tb$Goals %>%
    fct_count(prop = FALSE)

tb$Goals %>%
    fct_count(prop = TRUE)


## Aglutina níveis para preservar os `n` mais frequentes.
## Valor negativo de `n` inverte a lógica.
tb$Goals %>%
    fct_lump_n(n = 4, other_level = "4+") %>%
    fct_count(prop = TRUE)


## Preserva os níveis com frequência relativa a partir de `prop`.
## Valor negativo de `prop` inverte a lógica.
tb$Goals %>%
    fct_lump_prop(prop = 0.05, other_level = "Outro") %>%
    fct_count(prop = TRUE)

## Define o mínimo em frequência absoluta.
tb$Goals %>%
    fct_lump_min(min = 60, other_level = "Outro") %>%
    fct_count(prop = TRUE)

## Define a lista de níveis a manter.
tb$Goals %>%
    fct_other(keep = head(levels(tb$Goals), n = 6),
              other_level = "6+") %>%
    fct_count()

## Define a lista de níveis a abadonar.
tb$Goals %>%
    fct_other(drop = tail(levels(tb$Goals), n = -6),
              other_level = "6+") %>%
    fct_count()

## Agrupa níveis.
## Os valores em Goals identificados a direita do = serão recofificados
## para o grupo à esquerda do =
tb$Goals %>%
    fct_collapse("[0, 3]" = as.character(0:3),
                 "[4, 10]" = as.character(4:10)) %>%
    head()
head(tb$Goals)

tb$Goals %>%
    fct_collapse("[0, 3]" = as.character(0:3),
                 "[4, 10]" = as.character(4:10)) %>%
    fct_other(keep = c("[0, 3]", "[4, 10]"),
              other_level = "10+") %>%
    fct_count()

## Níveis que não tiveram ocorrência.
tb$Goals %>%
    fct_count() %>%
    filter(n == 0)

## Abandona níveis previstos mas que não tiveram ocorrência.
tb$Goals %>%
    fct_drop() %>%
    levels()

## Adiciona níveis válidos ao fator (mas não entradas no vetor).
tb$Goals %>%
    fct_expand(as.character(20:25)) %>%
    levels()

##----------------------------------------------------------------------
## Editar os rótulos do fator.

## Aplica uma função aos rótulos.
tb$PositionText %>%
    fct_relabel(toupper) %>%
    levels()

## Adiciona um sulfixo.
tb$PositionText %>%
    fct_relabel(~str_c(., "_new")) %>%
    levels()

## Recodifica manualmente os níveis no fator.
tb$PositionText %>%
    fct_recode("Zagueiro" = "Defender",
               "Goleiro" = "Goalkeeper",
               "Atacante" = "Forward",
               "Meio-campo" = "Midfielder",
               "Substituto" = "Substitute") %>%
    levels()

## Anonimatiza os níveis deixando rótulos numéricos
tb$PositionText %>%
    fct_anon() %>%
    levels()

tb$TeamName %>%
    fct_anon() %>%
    levels()

## Cria um rótulo para níveis que são valores ausentes.
tb$RegionCode %>%
    fct_count(sort = TRUE)

tb$RegionCode %>%
    fct_explicit_na(na_level = "Desconhecido") %>%
    fct_count(sort = TRUE)
