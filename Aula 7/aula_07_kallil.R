# aula 7

df1 <- tibble(
  
  matricula = c(256, 487, 965, 125, 458, 874, 963),
  nome = c("João", "Vanessa", "Tiago", "Luana", "Gisele",
           "Pedro", "André"),
  curso = c("Mat", "Mat", "Est", "Est", "Est", "Mat", "Est"),
  prova1 = c(80, 75, 95, 70, 45, 55, 30),
  prova2 = c(90, 75, 80, 85, 50, 75, NA),
  prova3 = c(80, 75, 75, 50, NA, 90, 30),
  faltas = c(4, 4, 0, 8, 16, 0, 20)
)

df1 %>% arrange(matricula)

df1 %>% arrange(curso, desc(prova1))

df1 %>% select(c("nome","prova1"))
df1 %>% select(-nome, -faltas)
df1 %>% select(prova1:prova3)

df1%>% select(1,4)

df1 %>% select(!where(is.numeric))

df1 %>% select(where(is.numeric))

df1 %>% select(contains("urso"))

df1 %>% select(ends_with("a"))

df1 %>% slice(c(3:4,1:2))

df1 %>% filter(curso == "Est")

df1 %>% filter(nome %in% c("Luana", "Vanessa"))

df1 %>% select(function(x) any(is.na(x)))

df1 %>% filter(faltas == 0, curso == "Est")

df1 %>% filter(faltas == 0 & curso == "Est")

df2 <- df1 %>% mutate(media = (prova1 + prova2 + prova3)/3,
               condicao = ifelse(media >= 70, "Apr", "Rep"))
df2 %>%
  filter(condicao == "Apr" & curso == "Est")

df1 %>%
  sample_n(size = 3, replace = FALSE)

df1 %>%
  rename("mat." = "matricula",
         "flt." = "faltas",
         "nm" = 2)


df1 %>% 
  mutate(across(prova1:prova3, ~replace_na(.,0)))

inter <- c(0, 40, 70, 100)
condi <- c("reprovado", "exame", "aprovado")

tb_final <- df1 %>% 
  mutate(across(starts_with("prova"),
                ~replace_na(.,0))) %>%
  mutate(media = (prova1 + prova2 + prova3)/3,
         result = cut(media,
                      breaks = inter,
                      labels = condi,
                      right = FALSE,
                      include.lowest = TRUE))
tb_longa <- df1 %>%
  pivot_longer(cols = prova1:prova3,
               names_to = "exame",
               values_to = "nota")
df1 %>% 
  summarise(soma = sum(prova1),
            media = mean(prova1),
            max = max(prova1),
            sd = sd(prova1))

tb_longa[tb_longa$exame == "prova1",] %>% 
  summarise(media_geral_p1 = mean(nota),
            maior_nota_p1 = max(nota),
            aluno_p1 = tb_longa$nome[tb_longa$nota == max(nota)]
              
            )
#tb_longa$nome[tb_longa$nota == max(nota)]
tb_longa[tb_longa$exame == "prova1",]

filter(curso == "Est")

df1 %>% count(curso)

df1 %>%
  group_by(curso) %>%
  summarise(across(prova1:prova3, mean, na.rm = TRUE))


novos_dados_df1 <- tibble(
  matricula = c(505, 658, 713),
  nome = c("Guile", "Ryu", "Ken"),
  prova1 = c(65, 75, 75),
  prova2 = c(85, 80, 90),
  faltas = c(0, 2, 2))

df1_dados_extra <-bind_rows(df1,novos_dados_df1)
