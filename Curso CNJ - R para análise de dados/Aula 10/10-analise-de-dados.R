##======================================================================

## Análise geral das bases de dados do CNJ
## Prof. Fernando de Pol Mayer (LEG/DEST/UFPR)

## As três bases analisadas são:

## 1)
## Base de dados: JF_Secao_25_Ago_2020.csv
## Enviada por: CNJ

## 2)
## Base de dados: planiha regeor_fev 2022.xlsx
## Enviada por: Juliana Lanaro Ribeiro (STM)

## 3)
## Base de dados: "Base de Dados Justiça Estadual 2020 CNJ.xlsx"
## Enviada por: Laercio Alcantara da Silva (TJRO)

##======================================================================

##======================================================================
## Base de dados: JF_Secao_25_Ago_2020.csv
## Enviada por: CNJ
##======================================================================

library(tidyverse)
library(readxl)

## Diferentes formas de importação

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

## Verifica NAs
sapply(da, function(x) any(is.na(x)))
da %>%
    select(where(~any(is.na(.))))

## Separa chave
da$chave
db <- da %>%
    separate(col = "chave",
             into = c("Trib", "UF", "Ano"),
             sep = "_",
             remove = FALSE,
             convert = TRUE)
str(db)

## Confere
unique(db$secao)
unique(db$UF)
unique(db$Trib)
unique(db$dsc_tribunal)

## Deixa apenas estados
dc <- db %>%
    filter(UF != "2º Grau", UF != "1º Grau", UF != "total")
unique(dc$secao)
unique(dc$UF)
unique(dc$Trib)
unique(dc$dsc_tribunal)

table(dc$ano)

dc %>% count(UF, secao) %>% print(n = 27)
with(dc, all.equal(UF, secao))

dc %>% count(Trib, sigla)
with(dc, all.equal(Trib, sigla))

dc %>% count(Ano, ano)
with(dc, all.equal(Ano, ano))

unique(dc$sigla)
table(dc$sigla)
dc %>% count(sigla)
dc %>% count(sigla) %>% summarise(sum = sum(n))
addmargins(table(dc$sigla))
prop.table(table(dc$sigla))
addmargins(prop.table(table(dc$sigla)))

##----------------------------------------------------------------------
## Subsets

dc$eff[dc$ano == 2019]
dc %>%
    filter(ano == 2019) %>%
    select(eff) %>%

dc$eff[dc$sigla == "TRF1"]
dc %>%
    filter(sigla == "TRF1") %>%
    select(eff)

dc$eff[dc$ano == 2019 & dc$sigla == "TRF1"]
dc %>%
    filter(ano == 2019 & sigla == "TRF1") %>%
    select(eff)

dc$eff[dc$sigla == "TRF2" | dc$sigla == "TRF3"]
dc %>%
    filter(sigla == "TRF2" | sigla == "TRF3") %>%
    select(eff)

dc$eff[dc$sigla == "TRF2" | dc$sigla == "TRF3" | dc$sigla == "TRF4"]
dc %>%
    filter(sigla == "TRF2" | sigla == "TRF3" | sigla == "TRF4") %>%
    select(eff)

dc$eff[dc$sigla %in% c("TRF2", "TRF3", "TRF4")]
dc %>%
    filter(sigla %in% c("TRF2", "TRF3", "TRF4")) %>%
    select(eff)

##----------------------------------------------------------------------
## Gráficos
ggplot(dc, aes(x = eff)) +
    geom_histogram(bins = 20)

ggplot(dc, aes(x = Trib, y = eff)) +
    geom_point() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(dc, aes(x = Trib, y = eff)) +
    geom_boxplot()

ggplot(dc, aes(x = reorder(Trib, eff), y = eff)) +
    geom_boxplot()

ggplot(dc, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(~ Trib)

ggplot(dc, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(~ Trib) +
    coord_flip()

ggplot(dc, aes(x = eff)) +
    geom_boxplot() +
    facet_wrap(Ano ~ Trib) +
    coord_flip()

ggplot(dc, aes(x = eff)) +
    geom_histogram(bins = 20) +
    facet_grid(Ano ~ Trib)

ggplot(dc, aes(x = eff)) +
    geom_boxplot() +
    facet_grid(Ano ~ Trib) +
    coord_flip()

ggplot(dc, aes(x = UF, y = eff)) +
    geom_boxplot()

dc %>%
    filter(UF != "total") %>%
    ggplot(aes(x = UF, y = eff)) +
    geom_boxplot() +
    scale_x_discrete(guide = guide_axis(angle = 90))

ggplot(dc, aes(x = Ano, y = eff,
               fill = Trib)) +
    geom_col()

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point()

ggplot(dc, aes(x = mag, y = serv, color = Trib)) +
    geom_point()

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib) +
    geom_smooth(method = "lm", se = FALSE)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib, scales = "free")

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Trib, scales = "free") +
    geom_smooth(method = "lm", se = FALSE)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~UF, scales = "free")

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~UF, scales = "free") +
    geom_smooth(se = FALSE)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_wrap(~Ano)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib) +
    geom_smooth(method = "lm", se = FALSE)

ggplot(dc, aes(x = mag, y = serv)) +
    geom_point() +
    facet_grid(Ano ~ Trib, scales = "free") +
    geom_smooth(method = "lm", se = FALSE)

rm(list = ls())
##======================================================================
## Base de dados: planiha regeor_fev 2022.xlsx
## Enviada por: Juliana Lanaro Ribeiro (STM)
##======================================================================

da <- read_excel("dados/planiha regeor_fev 2022.xlsx")
str(da)
names(da)

da <- read_excel("dados/planiha regeor_fev 2022.xlsx",
                 col_types = c("numeric", "text", "numeric",
                               "text", "text", "numeric", "text",
                               rep("numeric", 4)))
str(da)
names(da)

da <- da %>%
    rename(
        "ug" = "UG Executora",
        "nome_ug" = "Nome UG Executora",
        "ptres" = "PTRES",
        "cat_gasto" = "Categoria Gasto",
        "desc_cat_gasto" = "Descricao Cat Gastos",
        "nat_despesa" = "Natureza Despesa",
        "desc_nat_despesa" = "Descricao Nat Despesa",
        "provisao" = "PROVISAO RECEBIDA",
        "desp_emp" = "DESPESAS EMPENHADAS (CONTROLE EMPENHO)",
        "desp_pagas" = "DESPESAS PAGAS (CONTROLE EMPENHO)",
        "restos" = "RESTOS A PAGAR PAGOS (PROC E N PROC)"
    )

## Verifica NAs
sapply(da, function(x) any(is.na(x)))
da %>%
    select(where(~any(is.na(.))))

da %>%
    select(where(~any(is.na(.)))) %>%
    summarise(across(everything(), ~sum(is.na(.))))

da %>%
    select(where(~any(is.na(.)))) %>%
    summarise(across(everything(), ~sum(is.na(.))/nrow(da)))

da %>%
    select(where(is.character)) %>%
    map(~unique(.x))

##----------------------------------------------------------------------
## nome_ug
da %>%
    group_by(nome_ug) %>%
    summarise(soma = sum(provisao, na.rm = TRUE))

da %>%
    group_by(nome_ug) %>%
    filter(nome_ug != "SUPERIOR TRIBUNAL MILITAR") %>%
    summarise(soma = sum(provisao, na.rm = TRUE))

da %>%
    group_by(nome_ug) %>%
    filter(nome_ug != "SUPERIOR TRIBUNAL MILITAR") %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    summarise(total = sum(soma))

## Remove SUPERIOR TRIBUNAL MILITAR por estar em outra escala
## e tambem as duas ultimas por serem 0
da <- da %>%
    filter(nome_ug != "SUPERIOR TRIBUNAL MILITAR",
           nome_ug != "FUNDACAO UNIVERSIDADE DE BRASILIA - FUB",
           nome_ug != "PREFEITURA MILITAR DE BRASILIA")
da

##----------------------------------------------------------------------
unique(da$desc_cat_gasto)
da %>%
    group_by(desc_cat_gasto) %>%
    summarise(soma = sum(provisao, na.rm = TRUE))


library(patchwork)

g1 <- ggplot(da, aes(x = provisao, y = desp_emp)) +
    geom_point()
g2 <- ggplot(da, aes(x = provisao, y = desp_pagas)) +
    geom_point()
g3 <- ggplot(da, aes(x = provisao, y = restos)) +
    geom_point()
g4 <- ggplot(da, aes(x = desp_emp, y = desp_pagas)) +
    geom_point()
g5 <- ggplot(da, aes(x = desp_emp, y = restos)) +
    geom_point()
g6 <- ggplot(da, aes(x = desp_pagas, y = restos)) +
    geom_point()

(g1 + g2 + g3)/(g4 + g5)/g6

##----------------------------------------------------------------------
## Provisao
da %>%
    drop_na(provisao) %>%
    summarise(med = mean(provisao),
              median = median(provisao),
              min = min(provisao),
              max = max(provisao),
              dp = sd(provisao))

ggplot(da, aes(x = provisao)) +
    geom_histogram(bins = 20)

ggplot(da, aes(x = provisao)) +
    geom_boxplot()

ggplot(da, aes(x = nome_ug, y = provisao)) +
    geom_boxplot() +
    scale_x_discrete(guide = guide_axis(angle = 90))

ggplot(da, aes(x = provisao)) +
    geom_histogram(bins = 15) +
    facet_wrap(~nome_ug, scales = "free")

da %>%
    group_by(nome_ug) %>%
    summarise(soma = sum(provisao, na.rm = TRUE))

da %>%
    group_by(nome_ug) %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    ggplot(aes(x = nome_ug, y = soma)) +
    geom_col()

da %>%
    group_by(nome_ug) %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    ggplot(aes(x = reorder(nome_ug, soma), y = soma)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 45))

da %>%
    group_by(nome_ug, desc_cat_gasto) %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    print(n = 21)

##----------------------------------------------------------------------
## Provisao x despesas pagas
ggplot(da, aes(x = provisao, y = desp_pagas)) +
    geom_point()

ggplot(da, aes(x = provisao, y = desp_pagas, color = nome_ug)) +
    geom_point()

ggplot(da, aes(x = provisao, y = desp_pagas)) +
    geom_point() +
    geom_smooth(method = "lm") +
    facet_wrap(~ nome_ug, scales = "free")

da %>%
    group_by(nome_ug) %>%
    summarise(soma_prov = sum(provisao, na.rm = TRUE),
              soma_desp = sum(desp_pagas, na.rm = TRUE))

da %>%
    group_by(nome_ug) %>%
    summarise(soma_prov = sum(provisao, na.rm = TRUE),
              soma_desp = sum(desp_pagas, na.rm = TRUE)) %>%
    pivot_longer(cols = -nome_ug,
                 names_to = "vars",
                 values_to = "vals")

da %>%
    group_by(nome_ug) %>%
    summarise(soma_prov = sum(provisao, na.rm = TRUE),
              soma_desp = sum(desp_pagas, na.rm = TRUE)) %>%
    pivot_longer(cols = -nome_ug,
                 names_to = "vars",
                 values_to = "vals") %>%
    ggplot(aes(x = reorder(nome_ug, vals), y = vals, fill = vars)) +
    geom_col(position = "dodge") +
    scale_x_discrete(guide = guide_axis(angle = 45))

##----------------------------------------------------------------------
## desc_nat_despesa
da %>%
    group_by(desc_nat_despesa) %>%
    summarise(soma = sum(provisao, na.rm = TRUE))

da %>%
    group_by(desc_nat_despesa) %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    ggplot(aes(x = reorder(desc_nat_despesa, soma), y = soma)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 45))

da$desc_nat_despesa %>%
    fct_count() %>%
    mutate(p = n/sum(n)) %>%
    arrange(desc(p))

da$desc_nat_despesa %>%
    fct_lump_prop(prop = 0.1, other_level = "Outros") %>%
    fct_count() %>%
    mutate(p = n/sum(n)) %>%
    arrange(desc(p))

da$desc_nat_despesa2 <- da$desc_nat_despesa %>%
    fct_lump_prop(prop = 0.1, other_level = "Outros")

da %>%
    group_by(desc_nat_despesa2) %>%
    summarise(soma = sum(provisao, na.rm = TRUE))

da %>%
    group_by(desc_nat_despesa2) %>%
    summarise(soma = sum(provisao, na.rm = TRUE)) %>%
    ggplot(aes(x = reorder(desc_nat_despesa2, soma), y = soma)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 45))

rm(list = ls())
##======================================================================
## Base de dados: "Base de Dados Justiça Estadual 2020 CNJ.xlsx"
## Enviada por: Laercio Alcantara da Silva (TJRO)
##======================================================================

library(tidyverse)
library(readxl)

## Importa
url <- "dados/Base de Dados Justiça Estadual 2020 CNJ.xlsx"
## Especifica o range de linhas e colunas a serem lidas
da <- read_excel(url, range = "A3:Q31")
str(da)
summary(da)

## Verifica NAs
sapply(da, function(x) any(is.na(x)))
da %>%
    select(where(~any(is.na(.))))

## Verifica estados
da %>%
    count(Estados) %>%
    print(n = 28)

## Remove TJ por ser nacional
db <- da %>%
    filter(Estados != "TJ")
str(db)

ggplot(db, aes(x = eff)) +
    geom_histogram(bins = 10)

ggplot(db, aes(x = Estados, y = eff)) +
    geom_point() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência") +
    theme_bw()

ggplot(db, aes(x = Estados, y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(db, aes(x = reorder(Estados, eff), y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(db, aes(x = reorder(Estados, -eff), y = eff)) +
    geom_col() +
    scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência")

ggplot(db, aes(x = reorder(Estados, eff), y = eff)) +
    geom_col() +
    ## scale_x_discrete(guide = guide_axis(angle = 90)) +
    ylab("Eficiência") +
    coord_flip()

ggplot(db, aes(x = pop, y = pib,
               color = Estados)) +
    geom_point()

db %>%
    filter(pop > 3e7) %>%
    select(Estados, pop)

db %>%
    filter(pop < 2e8) %>%
    ggplot(aes(x = pop, y = pib,
               color = Estados)) +
    geom_point()

db %>%
    filter(pop < 2e8) %>%
    ggplot(aes(x = log(pop), y = log(pib), color = Estados)) +
    geom_point()

db %>%
    filter(pop < 2e8) %>%
    ggplot(aes(x = log(pop), y = log(pib))) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(db, aes(x = log(pop), y = log(pib))) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(db, aes(x = pop, y = mag, color = Estados)) +
    geom_point()

ggplot(db, aes(x = dpj, y = mag, color = Estados)) +
    geom_point()

ggplot(db, aes(x = dpj, y = drh, color = Estados)) +
    geom_point()

ggplot(db, aes(x = mag, y = serv, color = Estados)) +
    geom_point()

ggsave("grafico.png")

rm(list = ls())
