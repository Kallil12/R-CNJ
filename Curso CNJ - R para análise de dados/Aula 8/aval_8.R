library(tidyverse)
library(lubridate)

str_detect(starwars$hair_color, "brown")

starwars_hair <- starwars %>%
  str_detect(hair_color, 'brown')

cabelo_marrom <- str_detect(starwars$hair_color, "brown")
cabelo_marrom_tibs <- starwars[cabelo_marrom,]

resultado <- cabelo_marrom_tibs %>%
  filter(mass > 50)


starwars_pele <- str_detect(starwars$skin_color, "brown")
starwars_pele_tibs <- starwars[starwars_pele,]

sum(str_detect(starwars$name, "^[AEIOU]"))

rm(list = ls())
comeca_vogais <-str_detect(starwars$name, "^[aeiowAEIOU]")

starwars[comeca_vogais,]

fator_homeworld <- mutate(starwars$homeworld, as.factor)


starwars <- starwars %>%
  mutate(across(c("homeworld"), as.factor))


starwars$homeworld %>%
  nlevels()

starwars %>%
  count(homeworld, sort = TRUE)

starwars$homeworld %>%
  fct_count(sort = TRUE)


starwars %>%
  filter(homeworld == "Alderaan") %>%
  summarise(media_altura = mean(height))

altura_alderaan <- starwars[starwars$homeworld == "Alderaan",]

altura_alderaan <- starwars[starwars$homeworld == "Alderaan",]

mean(altura_alderaan$height, na.rm = TRUE)

datas_analise <- base::as.Date(lakers$date, format = "%d/%m/%Y")

datas_range <- lubridate::dmy(lakers$date)
diff(datas_range)

max(lakers$date)
min(lakers$date)


data_max <- max(lakers$date)
data_min <- min(lakers$date)

difftime(data_max, data_min, units = "days")
