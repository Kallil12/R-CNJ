source("config/setup.R")
## source("config/custom_css.R")

## source("config/setup_knitr.R") # muda pelo do Walmes
source("config/setup.R")
## source("config/custom_css.R")
opts_chunk$set(fig.path = "figures/09-purrr")
library(RefManageR)
BibOptions(check.entries = FALSE,
           bib.style = "authoryear",
           cite.style = "authoryear",
           style = "markdown",
           hyperlink = FALSE,
           dashed = FALSE)
bib <- ReadBib("config/refs.bib", check = FALSE)
xaringanExtra::use_xaringan_extra("tachyons")
## knitr::opts_chunk$set(out.width = "80%")

cap <- "R for Data Science, a principal referência sobre o emprego da linguagem R em ciência de dados."
knitr::include_graphics(c("./img/r-for-data-science-front-cover.jpg"))

href <- "https://oliviergimenez.github.io/intro_tidyverse/#7"
cap <- paste0("Workflow de ciência de dados com o {tidyverse}. Fonte: ",
              shiny::tags$a(href, href = href), "")
knitr::include_graphics("./img/01_tidyverse_data_science.png")

library(purrr)
packageDescription(
  pkg = "purrr",
  fields = c("Title", "Version", "Author", "Description", "Imports"))

options(width = 60)
library(tidyverse)
x <- list(1:5,
          c(4, 5, 7),
          c(98, 34, -10),
          c(2, 2, 2, 2, 2))
map(x, sum)

## options(width = 40)
ls("package:purrr") %>%
    str_subset("^map_")

map_dbl(x, sum)
map_chr(x, paste, collapse = " ")

x <- list(1:5,
          c(4, 5, 7),
          c(98, 34, -10),
          c(2, 2, 2, 2, 2))
map(x, sum)

simple_map <- function(x, f, ...) {
    out <- vector("list", length(x))
    for (i in seq_along(x)) {
        out[[i]] <- f(x[[i]], ...)
    }
    out
}

simple_map(x, sum)

map_dbl(x, function(x) length(unique(x)))
map_dbl(x, ~ length(unique(.x)))

set.seed(1)
map(1:3, function(x) runif(n = x))
set.seed(1)
map(1:3, ~ runif(n = .x))

## Mantém apenas elementos da lista onde todos
## os valores sejam maiores do que zero
keep(x, .p = ~all(. > 0))

## Discarta todos os elementos da lista, menos
## aqueles que não possuem todos maiores do que zero
discard(x, .p = ~all(. > 0))

# Função predicativa: retorna TRUE ou FALSE.
is_ok <- function(x)  length(x) > 3
map_if(x, .p = is_ok, .f = sum)

map_at(x, .at = c(2, 4), .f = sum)

map_dbl(x, sum)
map(x, sum) %>%   # retorna uma lista
    flatten_dbl() # aplana

y <- list(3, 5, 0, 1)
map2(x, y, function(x, y) x * y)

z <- list(-1, 1, -1, 1)
pmap(list(x, y, z),
     .f = function(x, y, z) x * y * z)

invoke(sample, x = 1:5, size = 2)
invoke(runif, n = 3)

invoke_map(runif, list(n = 2, n = 4))
invoke_map(c("runif", "rnorm"), n = 3)

# Função que pode provocar `Error`.
my_fun <- function(x) {
    if (all(x > 0)) {
        sum(log(x))
    } else {
        stop("x must be > 0")
    }
}

## Sem tratar, o comando para no erro
map_dbl(x, my_fun)
## Com tratamento, retorna o que por possível
map_dbl(x,
        .f = possibly(my_fun,
                      otherwise = NA))

# Captura as mensagens de erro e resultados.
u <- map(x[c(3:4)], safely(my_fun))
str(u)
# Captura avisos, notificações e resultados.
u <- map(x[c(3:4)], quietly(sum))
## str(u)

# Para ser didático.
juros <- function(valor, taxa = 0.025) {
    valor * (1 + taxa)
}

# Rendimento por 4 meses.
juros(10) %>% juros() %>% juros() %>% juros()

# A conta de forma mais simples.
10 * (1 + 0.025)^(1:4)

# O outuput retorna como input.
reduce(rep(0.025, 4), juros, .init = 10)

# Essa mantém os resultados intermediários.
accumulate(rep(0.025, 4), juros, .init = 10)

## # Aninha uma tabela dentro de outra.
## u <- iris %>%
##     as_tibble() %>%
##     select(Sepal.Length,
##            Sepal.Width,
##            Species) %>%
##     rename(x = 1, y = 2) %>%
##     nest(-Species)
## u

## tb_fit <- u %>%
##     summarise(
##         cor = map(data, cor),
##         fit = map(data, ~lm(y ~ x, data = .)),
##         R2 = map(fit, ~summary(.)$r.squared)) %>%
##     unnest(R2)
## tb_fit

apropos("^\\w*apply") %>%
    append(c("replicate", "ave",
             "aggregate", "Reduce",
             "Filter"))

## ## Para gerar o PDF
## xaringanBuilder::build_pdf("05-tidyverse-graficos.Rmd")
