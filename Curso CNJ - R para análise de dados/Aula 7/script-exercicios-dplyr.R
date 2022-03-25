library(tidyverse)

url <- "http://leg.ufpr.br/~walmes/data/ninfas.txt"
da <- read_tsv(url)[]
str(da)

## * Ordenação.
## 1. Ordenar pelo valor do terço `superior`.
da %>%
    arrange(superior)
## 2. Ordenar pelo valor do terço `medio` de forma descrescente.
da %>%
    arrange(desc(medio))
## 3. Ordenar pelas datas $>$ variedade $>$ bloco.
da %>%
    arrange(data, variedade, bloco)

## * Filtros.
## 1. Filtrar só para a variedade `BRS 245 RR`.
da %>%
    filter(variedade == "BRS 245 RR")
## 2. Filtrar só para a variedade `BRS 245 RR` e `EMBRAPA 48`.
da %>%
    filter(variedade %in% c("BRS 245 RR", "EMBRAPA 48"))
## 3. Filtrar só para variedades diferentes de `EMBRAPA 48`.
da %>%
    filter(variedade != "EMBRAPA 48")
## 4. Filtrar quando `superior` for maior do que 30 e `inferior` for
## maior do que 20.
da %>%
    filter(superior > 30 & inferior > 20)
## 5. Filtrar para `medio` entre 20 e 50.
da %>%
    filter(medio > 20 & medio < 50)
## 6. Filtrar para avaliações entre 2009-12-24 e 2010-01-11.
da %>%
    filter(data >= "2009-12-24" & data <= "2010-01-11") %>%
    arrange(data)
unique(da$data)
## 7. Filtrar para a soma dos terços maior que 100.
da %>%
    filter(superior + medio + inferior > 100)

da %>%
    mutate(soma = superior + medio + inferior) %>%
    filter(soma > 100)

## * Fatias.
## 1. As linhas 34, 74, 23 e 41.
da %>%
    slice(c(34, 74, 23, 41))
## 2. As 10 primeiras linhas.
da %>%
    slice(1:10)
da %>%
    head(n = 10)
## 3. Da linha 50 até a 63.
da %>%
    slice(50:63)
## 4. As �ltimas 10 linhas.
da %>%
    tail(n = 10)
## 5. Remover as 100 primeiras linhas.
da %>%
    slice(-(1:100))

## * Amostragem.
## 1. Uma amostra de 30 linhas.
da %>%
    sample_n(30)
## 2. Uma amostra de 30 linhas com reposição.
da %>%
    sample_n(30, replace = TRUE)
## 3. Uma amostra de 10% das linhas.
da %>%
    sample_frac(0.1)

## * Seleção de variáveis.
## 1. Selecionar apenas os terços.
da %>%
    select(superior:inferior)
## 2. Remover a variável bloco.
da %>%
    select(-bloco)
## 3. Mudar a ordem das colunas finais para `inferior`, `medio` e
## `superior`.
da %>%
    select(data, variedade, bloco, inferior, medio, superior)

da %>%
    relocate(inferior, medio, superior, .after = last_col())
## 4. Manter as variáveis com nome terminado em `rior`.
da %>%
    select(ends_with("rior"))

da %>%
    select(matches("*rior$"))

## * Modificação/criação de variáveis.
## 1. Criar a variável total somando os terços.
da %>%
    mutate(total = superior + medio + inferior)

da %>%
    rowwise() %>%
    mutate(total = sum(c_across(superior:inferior)))
## 2. Criar a diferença entre o terço superior e inferior.
da %>%
    mutate(dif = superior - inferior)
## 3. Converter bloco e variedade para fator.
da %>%
    mutate(bloco = as.factor(bloco),
           variedade = as.factor(variedade))
## 4. Criar a raiz quadrada do número de ninfas em cada terço.
da %>%
    mutate(across(superior:inferior, sqrt))

da %>%
    summarise(across(superior:inferior, sqrt)) %>%
    set_names(nm = c("s_sqrt", "m_sqrt", "i_sqrt")) %>%
    bind_cols(da, .)

## * Renomear.
## 1. Renomear variedade para tratamento.
da %>%
    rename("tratamento" = "variedade")
## 2. Renomear os terços para versões abreviadas com 3 digitos.
da %>%
    rename_with(.fn = abbreviate, minlength = 3,
                .cols = superior:inferior)
## 3. Passar todas as variáveis para caixa alta.
da %>%
    rename_with(.fn = str_to_upper,
                .cols = everything())
## 4. Abreviar todas as variáveis para nomes com 3 digitos.
da %>%
    rename_with(.fn = abbreviate, minlength = 3,
                .cols = everything())

## * Medidas descritivas gerais.
## 1. Total de ninfas no terço superior.
da %>%
    summarise(soma = sum(superior))
## 2. Total de ninfas em cada um dos terços.
da %>%
    summarise(across(superior:inferior, sum))
## 3. Média e desvio-padrão de ninfas em cada terço.
da %>%
    summarise(across(superior:inferior, c(mean, sd)))

## * Medidas descritivas por extrato.
## 1. Total de registros por variedade.
da %>%
    group_by(variedade) %>%
    count()
## 2. Total de registros por data.
da %>%
    group_by(data) %>%
    count()
## 3. Total de registros por variedade e data.
da %>%
    group_by(variedade, data) %>%
    count()
## 4. Total de ninfas no terço superior por data.
da %>%
    group_by(data) %>%
    summarise(soma = sum(superior))
## 5. Total de ninfas nos 3 terços juntos por data.
da %>%
    rowwise() %>%
    group_by(data) %>%
    summarise(soma = sum(c_across(superior:inferior)))
## 6. Total de ninfas nos 3 terços juntos por variedade, ordene no
## final.
da %>%
    rowwise() %>%
    group_by(variedade) %>%
    summarise(soma = sum(c_across(superior:inferior))) %>%
    arrange(soma)
## 7. Total de ninfas nos 3 terços juntos por data e variedade. Guardar
## em objeto para usar a seguir.
db <- da %>%
    rowwise() %>%
    group_by(data, variedade) %>%
    summarise(soma = sum(c_across(superior:inferior)))
db
## 8. A variedade com mais ninfas em cada data.
db %>%
    group_by(data) %>%
    slice(which.max(soma))
## 9. A data com mais ninfas em cada variedade.
db %>%
    group_by(variedade) %>%
    slice(which.max(soma))
