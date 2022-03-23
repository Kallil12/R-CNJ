##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/ninfas.txt"
da <- read_tsv(url)[]
str(da)

db <- da %>%
    pivot_longer(cols = superior:inferior,
                 names_to = "terco",
                 values_to = "valor")
str(db)


##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/oleos.txt"
da <- read_tsv(url)[]
str(da)

da$ind <- 1:nrow(da)

## da %>%
##     mutate(ind2 = 1:nrow(da), .before = 1)

map(da[, 1:3], unique)
map(da[, 1:3], table)
map_lgl(da, function(x) any(is.na(x)))

db <- da %>%
    pivot_longer(cols = a1:a5,
                 names_to = "aval",
                 values_to = "nota")
str(db)


##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/euro_football_players.txt"
da <- read_tsv(url, skip = 27)[]
str(da)

db <- da %>%
    replace_na(list(goal = 0, red = 0, yel = 0))
str(db)

##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/aval_carros_nota.txt"
da <- read_tsv(url)[]
str(da)

db <- da %>%
    pivot_wider(names_from = "item",
                values_from = "nota")
str(db)

##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/duster_venda_260314.txt"
da <- read_tsv(url)[]
str(da)
summary(da)

da %>%
    select_if(is.character) %>%
    map(unique)

da %>%
    select_if(is.character) %>%
    map(table, useNA = "ifany")

da %>%
    select_if(is.numeric) %>%
    map(summary)

map_lgl(da, function(x) any(is.na(x)))

db <- da %>%
    separate(ano,
             into = c("ano", "modelo"),
             convert = TRUE)
str(db)

mean(db$km, na.rm = TRUE)
dc <- db %>%
    replace_na(list(km = mean(db$km, na.rm = TRUE)))
str(dc)

##----------------------------------------------------------------------
url <- "http://leg.ufpr.br/~walmes/data/ipea_habitacao.csv"
da <- read_csv(url)[]
str(da)
names(da)

map(da[, c(1,3)], table)
map(da[, c(1,3)], unique)
map(da[, c(1,3)], function(x) any(is.na(x)))

db <- da %>%
    unite(Município, Sigla, col = "Local",
          sep = "-", remove = FALSE)
str(db)
