## ---- message = FALSE---------------------------------------------------------
library(tm)
library(slam)
library(text2vec)
library(proxy)
library(RWeka)
library(Matrix)


## -----------------------------------------------------------------------------
cps <- VCorpus(tm::ZipSource("respostas-prova.zip", 
                             mode = "text",
                             pattern = "*.txt"),
               readerControl = list(language = "portuguese"))
names(cps) <- sub(".*(.{3})\\.txt", "\\1", names(cps))
cps

inspect(cps[[3]])


## -----------------------------------------------------------------------------
# Fazendo as operações de limpeza.
cps <- tm_map(cps, FUN = content_transformer(tolower))
cps <- tm_map(cps, FUN = removeNumbers)
cps <- tm_map(cps, FUN = removeWords, words = stopwords("portuguese"))
cps <- tm_map(cps, FUN = stripWhitespace)
cps <- tm_map(cps, FUN = stemDocument, language = "portuguese")
cps <- tm_map(cps, FUN = content_transformer(trimws))


## -----------------------------------------------------------------------------
# Um tokenizador de bi-gramas.
my_tokenizer <- function(x) {
    RWeka::NGramTokenizer(x, control = Weka_control(min = 2, max = 2))
}
tt <- Token_Tokenizer(my_tokenizer)
tt("Minha terra tem palmeiras onde canta o sabiá.")

dtm <- DocumentTermMatrix(cps, control = list(tokenize = tt))
dtm

sample(Terms(dtm), size = 10)
# content(cps[[1]])

# Matriz menos esparsa.
rst <- removeSparseTerms(dtm, sparse = 0.75)
rst


## -----------------------------------------------------------------------------
# Transforma em matriz ordinária.
m <- as.matrix(rst)

# Distância coseno entre documentos.
d_mat <- text2vec::dist2(m, method = "cosine")
str(d_mat)

# De matriz cheia para triangular inferior.
d_mat <- stats::as.dist(d_mat)
str(d_mat)


## -----------------------------------------------------------------------------
# Faz o dendrograma.
hc <- hclust(d_mat, method = "average")
plot(hc, hang = -1)

# ATTENTION: cuidado em fazer isso com dimensões proibitivas.
u <- which(as.matrix(d_mat) == min(d_mat), arr.ind = TRUE)
i <- names(cps) %in% rownames(u)
names(cps)[which(i)]

purrr::walk(
    as.list(cps[which(i)]),
    function(x) {
      u <- content(x)
      cat("-------------------------------",
          strwrap(paste(u, collapse = " "),
                  width = 60),
          sep = "\n")
  })


## ---- message=FALSE, error=FALSE, warning=FALSE-------------------------------
#-----------------------------------------------------------------------
# Versões dos pacotes e data do documento.

devtools::session_info()
Sys.time()

