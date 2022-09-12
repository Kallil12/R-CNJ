## ---- include = FALSE---------------------------------------------------------
# opts_chunk$set(eval = FALSE)


## ---- message = FALSE---------------------------------------------------------
#-----------------------------------------------------------------------
# Pacotes.

library(tm)
# library(slam)

library(tidyverse)
library(tidytext)
library(udpipe)
library(wordcloud)
library(RColorBrewer)


## ---- eval = FALSE------------------------------------------------------------
## #-----------------------------------------------------------------------
## # Extração da web.
## 
## library(RCurl)
## library(XML)
## 
## # Protótipo de URL parametrizada para Renault Duster.
## proto <- paste0("https://www.carrosnaweb.com.br/opiniaolista.asp?",
##                 "curpage=%d&fabricante=Renault&modelo=DUSTER&",
##                 "anomod=&donoa=&versao=&ordenacao=1&km=")
## 
## url <- sprintf(proto, 1)
## # browseURL(url)
## 
## extrai <- function(url) {
##     cat("Lendo página:", url, "\n")
##     Sys.sleep(3)
##     lines <- getURL(url, .encoding = "utf-8")
##     h <- htmlParse(file = lines,
##                    asText = TRUE,
##                    # useInternalNodes = TRUE,
##                    encoding = "utf-8")
##     # summary(h)
##     x <- getNodeSet(doc = h,
##                     path = "//td[@rowspan='1']",
##                     fun = xmlValue)
##     x <- unlist(x)
##     x <- str_split(string = x, pattern = "Opinião Geral:")
##     sapply(x, tail, n = 1)
## }
## 
## # Cria as URL e faz a extração do conteúdo das páginas.
## urls <- sprintf(proto, 1:56)
## texto <- map(urls, extrai)
## 
## str(texto)
## 
## txt <- flatten_chr(texto)
## length(txt)
## tail(txt)
## 
## cat(jsonlite::toJSON(txt), file = "opiniao-dono-renault-duster.json")


## -----------------------------------------------------------------------------
#-----------------------------------------------------------------------
# Lendo o JSON.

url <- "http://leg.ufpr.br/~walmes/data/opiniao-dono-renault-duster.json"
txt <- jsonlite::fromJSON(url)
str(txt)


## -----------------------------------------------------------------------------
#-----------------------------------------------------------------------
# Cria o corpus.

cps <- VCorpus(VectorSource(x = txt),
               readerControl = list(language = "pt",
                                    load = TRUE))
cps

# Passa para caixa baixa.
cps <-tm_map(cps, FUN = content_transformer(tolower))
sapply(cps[1:4], content)

# Remove pontuação.
cps <-tm_map(cps, FUN = removePunctuation)
sapply(cps[1:4], content)

# Remove os numerais.
cps <-tm_map(cps, FUN = removeNumbers)
sapply(cps[1:4], content)

# Limpa o excesso de espaços em branco.
cps <-tm_map(cps, FUN = stripWhitespace)
sapply(cps[1:4], content)

# Elimina as stopwords.
stpw <- append(stopwords("portuguese"),
               c("carro", "renault", "duster"))

cps <-tm_map(cps,
             FUN = removeWords,
             words = stpw)
sapply(cps[1:4], content)

# Faz a poda das inflexões.
cps2 <- tm_map(cps, FUN = stemDocument, language = "portuguese")
sapply(cps2[1:4], content)

# Passa para ASCII puro.
acen <- function(x) iconv(x, to = "ASCII//TRANSLIT")
cps2 <- tm_map(cps2, FUN = content_transformer(acen))
sapply(cps2[1:4], content)


## -----------------------------------------------------------------------------
#-----------------------------------------------------------------------
# Cria a matriz de documentos e termos.

# Ponderação TF (default): term frequency (freq. absoluta).
dtm_tf <- DocumentTermMatrix(cps2, control = list(weighting = weightTf))
inspect(dtm_tf)

# Ponderação binária ou indicadora (presença/ausência).
dtm_bn <- DocumentTermMatrix(cps2, control = list(weighting = weightBin))
inspect(dtm_bn)

# Ponderação TF-IDF: term frequency inverse document frequency.
dtm_tfidf <- DocumentTermMatrix(cps2,
                                control = list(weighting = weightTfIdf))
inspect(dtm_tfidf)

# Escolhe uma das ponderações.
dtm <- dtm_tf
dtm

# Obtém os termos mais frequentes.
mft <- findFreqTerms(dtm, lowfreq = 10)
mft

# Encontra termos associados.
ass <- findAssocs(dtm, terms = "consumo", corlimit = 0.2)
ass

ass[[1]] %>%
    enframe() %>%
    ggplot(mapping = aes(x = value, y = reorder(name, value))) +
    geom_col()

# Cria uma tabela com a ocorrência.
u <- sort(slam::col_sums(dtm > 0), decreasing = TRUE)
d <- data.frame(word = names(u), freq = u)


## ---- warning = FALSE---------------------------------------------------------
# Faz a nuvem de palavras.
wordcloud(words = d$word,
          freq = d$freq,
          min.freq = 5,
          max.words = 400,
          random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))


## -----------------------------------------------------------------------------
#-----------------------------------------------------------------------
# Criando a matriz de documentos e termos a partir de dados tabulares.

txt <- txt %>%
    setNames(nm = sprintf("%0.3d", seq_along(txt)))

# Para limpar as strings.
word_clean <- function(x) {
    x <- str_to_lower(x)
    x <- str_remove_all(x, "[^[:alpha:]]")
    return(x)
}
# word_clean(c("asdlajksd5050", "asdkjaskd"))

# Determina a frequencia das palavras em cada documento.
my_text <- txt %>%
    enframe("doc", "text") %>%
    unnest_tokens(output = "word", input = "text") %>%
    mutate(word = word_clean(word)) %>%
    filter(word != "") %>%
    count(doc, word, sort = TRUE)
str(my_text)

# Obtém a ponderação TF-IDF.
my_text <- my_text %>%
    bind_tf_idf(term = word, document = doc, n = n)
head(my_text)

# Os termos mais comuns.
my_text %>%
    arrange(tf_idf)

# Os termos mais raros.
my_text %>%
    arrange(desc(tf_idf))

# Renomeia colunas por exigência da função a seguir.
my_text <- my_text %>%
    rename(doc_id = "doc", term = "word", freq = "n")

# Cria a matriz de documentos e termos.
dtm <- udpipe::document_term_matrix(my_text)
str(dtm)

# Outras opções de ponderação.
# dtm <- document_term_matrix(my_text, weight = "freq")
# dtm <- document_term_matrix(my_text, weight = "tf_idf")
# dtm <- document_term_matrix(my_text, weight = "bm25")


## ---- message=FALSE, error=FALSE, warning=FALSE-------------------------------
#-----------------------------------------------------------------------
# Versões dos pacotes e data do documento.

devtools::session_info()
Sys.time()

