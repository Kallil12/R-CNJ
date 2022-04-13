source("config/setup_knitr.R")

for(i in 1:5){
    print(i)
}

## for(<índice> in <valores>){
##     <comandos>
## }

x <- 100:200
for(j in 1:5){
    print(x[j])
}

for(i in c(2, 9, 4, 6)){
    print(i^2)
}

for(veiculos in c("carro", "ônibus", "trem", "bicicleta")){
    print(veiculos)
}

library(tidyverse)
da <- tibble(
    matricula = c(256, 487, 965,
                  125, 458, 874, 963),
    nome = c("João", "Vanessa", "Tiago",
             "Luana", "Gisele", "Pedro",
             "André"),
    curso = c("Mat", "Mat", "Est", "Est",
              "Est", "Mat", "Est"),
    prova1 = c(80, 75, 95, 70, 45, 55, 30),
    prova2 = c(90, 75, 80, 85, 50, 75, NA),
    prova3 = c(80, 75, 75, 50, NA, 90, 30),
    faltas = c(4, 4, 0, 8, 16, 0, 20))
## Substitui NA por 0
da <- da %>%
    mutate(across(prova1:prova3,
                  ~replace_na(., 0)))
da

## Aqui vamos criar uma nova coluna no dataframe, contendo apenas o
## valor 0
da$media <- 0 # note que aqui será usada a regra da reciclagem, ou
                 # seja, o valor zero será repetido até completar todas
                 # as linhas do dataframe
## Estrutura de repetição para calcular a média
for(i in 1:nrow(da)){
    ## Aqui, cada linha i da coluna media sera substituida pelo
    ## respectivo valor da media caculada
    da$media[i] <- sum(da[i, c("prova1", "prova2", "prova3")])/3
}
## Confere os resultados
da

## Armazenamos o número de linhas no dataframe
nlinhas <- nrow(da)
## Identificamos as colunas de interesse no cálculo da média, e
## armazenamos em um objeto separado
provas <- c("prova1", "prova2", "prova3")
## Sabendo o número de provas, fica mais fácil dividir pelo total no
## cálculo da média
nprovas <- length(provas)
## Cria uma nova coluna apenas para comparar o cálculo com o anterior
da$media <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    da$media[i] <- sum(da[i, provas])/nprovas
}
## Confere
da

## Cria uma nova coluna apenas para comparação
da$media <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    da$media[i] <- mean(as.numeric(da[i, provas]))
}
## Confere
da

## A única diferença é que aqui precisamos transformar cada linha em um
## vetor de números com as.numeric(), pois
da[1, provas]
## é um data.frame:
class(da[1, provas])

## help.search("coefficient of variation")

cv <- function(x){
    desv.pad <- sd(x)
    med <- mean(x)
    cv <- desv.pad/med
    return(cv)
}

sd(as.numeric(da[1, provas]))/mean(as.numeric(da[1, provas]))

cv(as.numeric(da[1, provas]))

## Cria uma nova coluna para o CV
da$CV <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    da$CV[i] <- cv(as.numeric(da[i, provas]))
}
## Confere
da

med.pond <- function(notas, pesos){
    ## Multiplica o valor de cada prova pelo seu peso
    pond <- notas * pesos
    ## Calcula o valor total dos pesos
    peso.total <- sum(pesos)
    ## Calcula a soma da ponderação
    sum.pond <- sum(pond)
    ## Finalmente calcula a média ponderada
    saida <- sum.pond/peso.total
    return(saida)
}

sum(da[1, provas] * c(3, 3, 4))/10

med.pond(notas = da[1, provas], pesos = c(3, 3, 4))

## Cria uma nova coluna para a média ponderada
da$MP <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    da$MP[i] <- med.pond(da[i, provas], pesos = c(3, 3, 4))
}
## Confere
da

## Atribuindo pesos iguais para as provas como padrão
med.pond <- function(notas, pesos = rep(1, length(notas))){
    ## Multiplica o valor de cada prova pelo seu peso
    pond <- notas * pesos
    ## Calcula o valor total dos pesos
    peso.total <- sum(pesos)
    ## Calcula a soma da ponderação
    sum.pond <- sum(pond)
    ## Finalmente calcula a média ponderada
    saida <- sum.pond/peso.total
    return(saida)
}

## Cria uma nova coluna para a média ponderada para comparação
da$MP <- 0
## A estrutura de repetição fica
for(i in 1:nlinhas){
    da$MP[i] <- med.pond(da[i, provas])
}
## Confere
da

x <- 100:200
for(j in 1:5) {
    if(x[j] <= 103) {
        print(cbind(x = x[j], msg = "Menor ou igual a 103"))
    }
}

x <- 100:200
for(j in 1:5){
    if(x[j] <= 103){
        print(cbind(x = x[j], msg = "Menor ou igual a 103"))
    } else{
        print(cbind(x = x[j], msg = "Maior do que 103"))
    }
}

## if(<condição>){
##     <comandos que satisfazem a condição>
## } else{
##    <comandos que não satisfazem a condição>
## }

## Nova coluna para armazenar a situacao
da$res <- NA # aqui usamos NA porque o resultado será um
             # caracter
## Estrutura de repetição
for(i in 1:nlinhas){
    ## Estrutura de seleção (usando a média ponderada)
    if(da$MP[i] >= 70){
        da$res[i] <- "aprovado"
    } else{
        da$res[i] <- "reprovado"
    }
}
da

## Vetor com uma sequência de 1 a 1.000.000
x <- 1:1e6
## Calcula o quadrado de cada número da sequência em x usando for()
y1 <- numeric(length(x)) # vetor de mesmo comprimento de x que vai
                         # receber os resultados
for(i in 1:length(x)){
    y1[i] <- x[i]^2
}

## Calcula o quadrado de cada número da sequência em x usando a regra da
## reciclagem
y2 <- x^2
## Confere os resultados
identical(y1, y2)

## ## Vetor com uma sequência de 1 a 1.000.000
## x <- 1:1e6
## 
## ## Cria um objeto de armazenamento com o mesmo tamanho do resultado
## st1 <- system.time({
##     out1 <- numeric(length(x))
##     for(i in 1:length(x)){
##         out1[i] <- x[i]^2
##     }
## })
## st1
## 
## ## Cria um objeto de tamanho "zero" e vai "crescendo" esse vetor
## st2 <- system.time({
##     out2 <- numeric(0)
##     for(i in 1:length(x)){
##         out2[i] <- x[i]^2
##     }
## })
## st2
## 
## ## Cria um objeto de tamanho "zero" e cresce o vetor usando a função c()
## ## NUNCA faça isso!!
## st3 <- system.time({
##     out3 <- numeric(0)
##     for(i in 1:length(x)){
##         out3 <- c(out3, x[i]^2)
##     }
## })
## st3
## 
## identical(out1, out2, out3)
## 
## save(st1, st2, st3, file = "system_times.rda")

## ## Tempo de execução usando for()
## y1 <- numeric(length(x))
## st1 <- system.time(
##     for(i in 1:length(x)){
##         y1[i] <- x[i]^2
##     }
## )
## 
## ## Tempo de execução usando a regra da reciclagem
## st2 <- system.time(
##     y2 <- x^2
## )

load("system_times.rda")
rbind(st1, st2)

## ## Vetor com uma sequência de 1 a 1.000.000
## x <- 1:1e6
## 
## ## Cria um objeto de armazenamento com o mesmo tamanho do resultado
## st1 <- system.time({
##     out1 <- numeric(length(x))
##     for(i in 1:length(x)){
##         out1[i] <- x[i]^2
##     }
## })
## 
## ## Cria um objeto de tamanho "zero" e vai "crescendo" esse vetor
## st2 <- system.time({
##     out2 <- numeric(0)
##     for(i in 1:length(x)){
##         out2[i] <- x[i]^2
##     }
## })
## 
## ## Cria um objeto de tamanho "zero" e cresce o vetor usando a função c()
## ## NUNCA faça isso!!
## st3 <- system.time({
##     out3 <- numeric(0)
##     for(i in 1:length(x)){
##         out3 <- c(out3, x[i]^2)
##     }
## })
## 
## identical(out1, out2, out3)

rbind(st1, st2, st3)

knitr::include_graphics("img/R_club.jpg")

da$media <- apply(X = da[, provas], MARGIN = 1, FUN = mean)
da

da$MP <- apply(X = da[, provas], MARGIN = 1, FUN = med.pond)
da

da$MP <- apply(X = da[, provas], MARGIN = 1,
               FUN = med.pond, pesos = c(3, 3, 4))
da

da$MP <- apply(X = da[, provas], MARGIN = 1,
               FUN = weighted.mean, w = c(3, 3, 4))
da

da$CV <- apply(X = da[, provas], MARGIN = 1, FUN = cv)
da

## ifelse(<condição>, <valor se verdadeiro>, <valor se falso>)

da$res <- ifelse(da$MP >= 70, "aprovado", "reprovado")
da

## Médias por LINHA: média das 3 provas para cada aluno
apply(X = da[, provas], MARGIN = 1, FUN = mean)
## Médias por COLUNA: média de cada uma das 3 provas para todos os
## alunos
apply(X = da[, provas], MARGIN = 2, FUN = mean)

## sapply simpilifica o resultado para um vetor
sapply(da[, provas],  mean)
## lapply retorna o resultado em formato de lista
lapply(da[, provas],  mean)

## Média da prova 1 por situação
tapply(da$prova1,  da$res, mean)
## Média da prova 2 por situação
tapply(da$prova2,  da$res, mean)
## Média da prova 3 por situação
tapply(da$prova3,  da$res, mean)

## Mesmo resultado da tapply, mas agora em formato de data frame
aggregate(prova1 ~ res, data = da, FUN = mean)
aggregate(prova2 ~ res, data = da, FUN = mean)
aggregate(prova3 ~ res, data = da, FUN = mean)
## Mas aqui podemos passar as 3 colunas de uma vez
aggregate(cbind(prova1, prova2, prova3) ~ res,
          data = da, FUN = mean)


