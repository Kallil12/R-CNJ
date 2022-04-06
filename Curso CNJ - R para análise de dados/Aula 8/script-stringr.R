##======================================================================
## Operações com strings

##----------------------------------------------------------------------
## Carrega o pacote.

library(tidyverse)

?fruit
set.seed(12345)
x <- sample(fruit, size = 10)
x

## Detectar

## Tem a em qualquer lugar
(id <- str_detect(x, "a"))
x[id]
sum(str_detect(x, "a"))
str_subset(x, "a")

## Começa com a
(id <- str_detect(x, "^a"))
x[id]
sum(str_detect(x, "^a"))
## str_starts(x, "a") # igual
str_subset(x, "^a")

## NÃO começa com a
(id <- str_detect(x, "^a", negate = TRUE))
x[id]
sum(str_detect(x, "^a", negate = TRUE))
## str_starts(x, "a") # igual
str_subset(x, "^a", negate = TRUE)

## Termina com e
(id <- str_detect(x, "e$"))
x[id]
sum(str_detect(x, "e$"))
## str_ends(x, "a") # igual
str_subset(x, "e$")

## Começa com vogal
(id <- str_detect(x, "^[aeiou]"))
x[id]
sum(str_detect(x, "^[aeiou]"))
x[str_starts(x, "[aeiou]")]
str_subset(x, "^[aeiou]")

## Posição no vetor
## a em qualquer lugar
str_which(x, "a")
x[str_which(x, "a")]
## e no final
str_which(x, "e$")
x[str_which(x, "e$")]

## Posição (início/fim) da letra
## Apenas a primeira ocorrência
str_locate(x, "a")
## Todas as ocorrências
str_locate_all(x, "a")

## Total de caracteres
str_count(x, "")
str_length(x)
## Total de vogais
str_count(x, "[aeiou]")
## Total de consoantes. (Nota: [^] é uma lista negada, com caracteres
## "proibidos")
str_count(x, "[^aeiou]")

## Caracteres de 1 a 3
str_sub(x, 1, 3)
## Catacteres de 4 a 8
str_sub(x, 4, 8)
## Somente os 2 últimos caracteres
str_sub(x, -2)
## Todo o termo, menos a última letra
str_sub(x, 1, -2)
## Note que
str_sub(x, 1, -1) # retorna tudo

## Extrai as vogais
str_extract(x, "[aeiou]") # apenas a primeira
str_extract_all(x, "[aeiou]") # todas
## Extrai as consoantes
str_extract(x, "[^aeiou]") # apenas a primeira
str_extract_all(x, "[^aeiou]") # todas

## Tamanhos
str_length(x)
## Inclui espaços em branco
str_pad(x, 12)
str_length(str_pad(x, 12))
## Remove espaços em branco (do início e fim)
str_trim(x)
str_trim(str_pad(x, 12))
## Trunca e coloca ...
str_trunc(x, 8)

## Modificações
## Substituição
str_replace(x, "a", "A") # apenas a primeira
str_replace_all(x, "a", "A") # todas
## Remoção
str_remove(x, "a")
str_remove_all(x, "a")
str_remove_all(x, "[^aeiou]") # remove consoantes
str_remove_all(x, "[aeiou]") # remove vogais
## Muda case
str_to_upper(x)
str_to_title(x)

## Junta e separa
str_c(x, 1:10)
str_c(x, 1:10, collapse = ", ")
str_glue("O valor de pi é {round(pi, 3)}")
str_glue("A fruta que começa com a é {str_subset(x, '^a')}.")
## Separa onde tiver espaço
str_split(x, " ")
str_split(x, "\\s")

## Ordenação
str_order(x)
str_sort(x)
