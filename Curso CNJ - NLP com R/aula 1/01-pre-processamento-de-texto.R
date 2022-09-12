## ---- message = FALSE---------------------------------------------------------
library(tm)
ls("package:tm")


## -----------------------------------------------------------------------------
# Uma string longa.
x <- "
Minha terra tem palmeiras,
Onde canta o     Sabiá;
As aves, que aqui gorjeiam,
Não    gorjeiam como lá.
Nosso céu tem mais estrelas,
Nossas    várzeas têm mais flores,
Nossos bosques    têm mais vida,
Nossa vida mais amores."

# Caixa baixa.
base::tolower(x) |> cat()

# Remove pontuação.
tm::removePunctuation(x) |> cat()

# Remove espações em branco extras.
tm::stripWhitespace(x) |>
    strwrap(width = 60) |> cat(sep = "\n")

# Remove os números.
tm::removeNumbers(x) |> cat()

# Remove stop words.
tm::removeWords(x, words = c("tem", "o", "a", "mais", "onde")) |> cat()

# Poda.
tm::stemDocument(x, language = "portuguese") |>
    strwrap(width = 60) |> cat(sep = "\n")


## ---- message = FALSE---------------------------------------------------------
library(tm)
library(tidyverse)
library(tidytext)

# Carregar uma lista de listas chamada `ufpr` com notícias envolvendo a
# UFPR entre 2016-09-05 até 2017-03-31.
load(file = "ufpr-news.RData")

class(ufpr)      # Tipo de objeto.
length(ufpr)     # Tamanho da lista.
names(ufpr[[1]]) # Conteúdo.


## -----------------------------------------------------------------------------
#-----------------------------------------------------------------------
# Criando um Corpus.

# Pegar as primeiras notícias.
tb <- ufpr[1:200] %>%
    map(tibble) %>%
    flatten_df()

# Cria um corpus.
cps <- VCorpus(VectorSource(x = tb$str_titulo),
               readerControl = list(language = "pt",
                                    load = TRUE))
cps

# Classe e métodos para a classe.
class(cps)
methods(class = "VCorpus")

# Classe e métodos para a classe.
class(cps[[1]])
methods(class = "PlainTextDocument")

# Conteúdo do elemento.
content(cps[[1]])

# Meta dados do elemento.
meta(cps[[1]])


## -----------------------------------------------------------------------------
# Pode encadear tudo com pipe se quiser.
cps <- tm_map(cps, FUN = content_transformer(tolower))
cps <- tm_map(cps, FUN = removePunctuation)
cps <- tm_map(cps, FUN = removeNumbers)
cps <- tm_map(cps, FUN = stripWhitespace)

# Resultado.
sapply(cps[1:4], content)


## -----------------------------------------------------------------------------
# Remove as stopwords.
stopwords("portuguese")

cps <- tm_map(cps,
              FUN = removeWords,
              words = stopwords("portuguese"))

# Resultado
sapply(cps[1:4], content)


## -----------------------------------------------------------------------------
cps2 <- tm_map(cps,
               FUN = stemDocument,
               language = "portuguese")

# Resultado.
sapply(cps2[1:4], content)


## -----------------------------------------------------------------------------
acen <- function(x) iconv(x, to = "ASCII//TRANSLIT")
cps2 <- tm_map(cps2, FUN = content_transformer(acen))
sapply(cps2[1:4], content)


## -----------------------------------------------------------------------------
# Com "indexed" (default) indica que ficara como tabela mas mantendo
# indexação com os elementos. É melhor para desempenho.
meta(cps2, tag = "ts", type = "indexed") <- tb$ts_publicacao
meta(cps2, tag = "cidade") <- tb$str_cidade
meta(cps2[[2]])
head(meta(cps2), n = 2)


## -----------------------------------------------------------------------------
# Com "local" indica que ficará dentro de cada elemento.
meta(cps2, tag = "ts", type = "local") <- tb$ts_publicacao
meta(cps2[[2]])


## -----------------------------------------------------------------------------
# Matriz de documentos e termos.
dtm <- DocumentTermMatrix(cps2) # Documentos nas linhas.
tdm <- TermDocumentMatrix(cps2) # Termos nas linhas.

# Detalhes.
# tdm
dtm

# Número de documentos e termos (vocabulário).
# dim(dtm)
# dim(tdm)
c(nTerms(tdm), nDocs(tdm))


## -----------------------------------------------------------------------------
# Classe e métodos.
class(dtm)
# methods(class = "DocumentTermMatrix")
methods(class = "TermDocumentMatrix")


## -----------------------------------------------------------------------------
# Algumas linhas e colunas da matriz.
inspect(tdm)


## -----------------------------------------------------------------------------
u <- VCorpus(VectorSource(c("O céu é azul",
                            "A mata é verde",
                            "Mas a rosa é vermelha")))
d <- DocumentTermMatrix(u)
inspect(d)

# Esparsidade (proporção de cédulas com 0 na matriz).
non_zero <- sum(d > 0)
cells <- prod(dim(d))
100 * (1 - (non_zero/cells))


## ---- eval = FALSE, out.width = "100%", fig.height = 10-----------------------
## library(lattice)
## 
## # Converte para matriz ordinária.
## m <- as.matrix(tdm)
## 
## # Reordenar matriz por frequencia dos termos.
## m <- m[order(apply(m, MARGIN = 1, sum), decreasing = TRUE), ]
## m <- t(m)
## 
## # Visualiza a matriz de documentos e termos. Cuidado com as dimensões.
## levelplot(m,
##           xlab = "Documentos",
##           ylab = "Termos",
##           col.regions = gray.colors,
##           scales = list(x = list(rot = 90))) +
##     latticeExtra::layer(panel.abline(h = 2:ncol(m) - 0.5,
##                        v = 2:nrow(m) - 0.5,
##                        col = "white"))


## -----------------------------------------------------------------------------
# Termos com frequencia superior a um valor de corte.
mft <- findFreqTerms(tdm, lowfreq = 10)
mft

# Frequência dos termos.
trm <- as.matrix(dtm[, c("aluno", "isencao", "vestibular")])
colSums(trm > 0) # Frequência.


## -----------------------------------------------------------------------------
# Termos associados por um valor acima de um limite.
# findAssocs(dtm, terms = mft, corlimit = 0.5)
ass <- findAssocs(dtm, terms = "aluno", corlimit = 0.5)
ass

# Correlação de Pearson.
cor(trm)


## -----------------------------------------------------------------------------
# slam: Sparse Lightweight Arrays and Matrices
u <- sort(slam::col_sums(dtm > 0), decreasing = TRUE)

# Esparsidade da matrix.
1 - sum(u)/prod(dim(dtm))

# Espasidade de cada termo.
tsp <- 1 - u/nDocs(dtm)
sum(tsp < 0.95) # Quantos tem menos que o corte.

# Esparsidade da DTM com acúmulo dos termos.
sps <- 1 - cumsum(u)/(nDocs(dtm) * seq_along(u))


## -----------------------------------------------------------------------------
# Remove os termos mais esparsos.
rst <- removeSparseTerms(dtm, sparse = 0.95)
# nTerms(rst)
Terms(rst)


## ----wordcloud, warning = FALSE, message = FALSE------------------------------
library(wordcloud)
library(RColorBrewer)

d <- data.frame(word = names(u),
                freq = u)

wordcloud(words = d$word,
          freq = d$freq,
          min.freq = 1,
          max.words = 200,
          random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))

