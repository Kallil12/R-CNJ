library(tidyverse)
mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv))+
  geom_point() +
  geom_smooth(mapping = aes(group = drv),se = FALSE)

# statistical transformation

library(tidyverse)
diamonds

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))


ggplot(data = diamonds) +
  stat_summary(
    mapping = aes( x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
# exercícios do curso de R do CNJ

oleos_alterado <- oleos %>% pivot_longer(names_to = "novo_a",
                                         cols = a1:a5)
oleos_alterado

analise_test <- oleos_alterado[oleos_alterado$forma == "test",]
analise_test

mean(analise_test$novo_a)

ggplot(data = oleos_alterado)+
  geom_boxplot(mapping = aes(x = bloco, y = novo_a, group = bloco))

                
iris

g <- ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Width))
g + geom_point(mapping = aes(x = Sepal.Length, color = Species)) + geom_lm()

g + geom_boxplot()

g + geom_point(mapping = aes(x = Sepal.Length, color = Species))


install.packages("plotly")