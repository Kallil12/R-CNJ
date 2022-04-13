for (j in 1:nrow(iris)){print(mean(j))}


vec_1 <- c(19, 16, 20, 5, 20, 15, 11, 16, 10)
vec_2 <- c(2, 4, 3, 1, 2, 2)
vec_3 <- 1:7

lista <- list(vec_1,vec_2,vec_3)

resultado <- 0

for(tamanhos in lista){
  resultado <- resultado + length(tamanhos)
}
########################

lista_2 <- list(2,10,5)
lista_3 <- lista * lista_2

lista_3 <- list(c(19, 16, 20, 5, 20, 15, 11, 16, 10), c(2, 4, 3, 1, 2, 2), 1:7) * list(2,10,5)

USArrests

resultado_delaware <- 5.9

for(i in 1:3){
  resultado_delaware <- resultado_delaware * 1.01
}