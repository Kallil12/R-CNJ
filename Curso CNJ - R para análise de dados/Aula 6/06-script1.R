library(tidyverse)

## Com read.table
da <- read.table("dados/JF_Secao_25_Ago_2020.csv", sep = ";",
                 dec = ",", header = TRUE, encoding = "latin1")
str(da)
## Com read.csv2
da <- read.csv2("dados/JF_Secao_25_Ago_2020.csv",
                encoding = "latin1")
str(da)
## Com readr::read_csv2
da <- read_csv2("dados/JF_Secao_25_Ago_2020.csv")
str(da)
## Especificando o encoding
da <- read_csv2("dados/JF_Secao_25_Ago_2020.csv",
                locale = locale(encoding = "latin1"))
str(da)
## Para tirar o spec e problems
attr(da, "spec") <- NULL
attr(da, "problems") <- NULL
## OU, de uma só vez (um subset vazio)
da <- da[]
str(da)
summary(da)

str(da)
names(da)

sapply(da, function(x) any(is.na(x)))


da$chave

db <- da %>%
    separate(col = "chave",
             into = c("Trib", "UF", "Ano"),
             sep = "_",
             remove = FALSE,
             convert = TRUE)

str(db)

unique(db$secao)
unique(db$UF)
unique(db$Trib)
unique(db$dsc_tribunal)

table(db$ano)

db %>% count(UF, secao)
with(db, all.equal(UF, secao))

db %>% count(Trib, sigla)
with(db, all.equal(Trib, sigla))

db %>% count(Ano, ano)
with(db, all.equal(Ano, ano))

ggplot(db, aes(x = eff)) +
    geom_histogram(bins = 20)

ggplot(db, aes(x = Trib, y = eff)) +
    geom_point() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(db, aes(x = Trib, y = eff)) +
    geom_boxplot()

ggplot(db, aes(x = reorder(Trib, eff), y = eff)) +
    geom_boxplot()

ggplot(db, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(~ Trib)

ggplot(db, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(~ Trib) +
    coord_flip()

ggplot(db, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(Ano ~ Trib) +
    coord_flip()

ggplot(db, aes(x = eff)) +
    geom_histogram(bins = 20) +
    facet_grid(Ano ~ Trib)

ggplot(db, aes(x = eff)) +
    geom_boxplot() +
    facet_grid(Ano ~ Trib) +
    coord_flip()

ggplot(db, aes(x = UF, y = eff)) +
    geom_boxplot()

db %>%
    filter(UF != "total") %>%
    ggplot(aes(x = UF, y = eff)) +
    geom_boxplot() +
    scale_x_discrete(guide = guide_axis(angle = 90))

ggplot(db, aes(x = Ano, y = eff,
               fill = Trib)) +
    geom_col()


ggplot(db, aes(x = mag, y = serv)) +
    geom_point()

ggplot(db, aes(x = mag, y = serv, color = Trib)) +
    geom_point()

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib) +
    geom_smooth(method = "lm", se = FALSE)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib, scales = "free")

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib, scales = "free") +
    geom_smooth(method = "lm", se = FALSE)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~UF, scales = "free")

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~UF, scales = "free") +
    geom_smooth(se = FALSE)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Ano)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib) +
    geom_smooth(method = "lm", se = FALSE)

ggplot(db, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib, scales = "free") +
    geom_smooth(method = "lm", se = FALSE)
