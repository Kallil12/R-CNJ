##======================================================================
## Operações com datas

##----------------------------------------------------------------------
## Carrega o pacote.

library(tidyverse)
library(lubridate)
## library(nycflights13)

ls("package:lubridate")

today()
now()

class(today())
class(now())

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")

ymd(today())
ymd(today(), tz = "America/Sao_Paulo")

ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01", tz = "America/Sao_Paulo") # Note -02
ymd_hm(str_c(today(), " 08:59"))
ymd_hm(str_c(today(), " 08:59"), tz = "America/Sao_Paulo")

## Idade de uma pessoa que nasceu em 1980-02-15
id <- today() - ymd("1980-02-15")
id
as.duration(id)

## TimeZones
head(OlsonNames())
str_subset(OlsonNames(), "^America")
str_subset(OlsonNames(), "^Australia")

ymd_hm(str_c(today(), " 08:59"), tz = "America/Sao_Paulo")
ymd_hm(str_c(today(), " 08:59"), tz = "Australia/Sydney")
ymd_hm(str_c(today(), " 08:59"), tz = "Australia/NSW")

##----------------------------------------------------------------------
## Jogadores de futebol.

url <- "http://leg.ufpr.br/~walmes/data/jog_europaleague_2014-05-04.txt"
tb <- read_tsv(url)[]
str(tb)

tb %>%
    select(DateOfBirth) %>%
    str()

tb$DateOfBirth %>%
    month(label = TRUE)

tb$DateOfBirth %>%
    month(label = TRUE) %>%
    fct_count()


tb <- tb %>%
    mutate(MonthOfBirth = lubridate::month(DateOfBirth, label = TRUE),
           YearOfBirth = lubridate::year(DateOfBirth),
           # DayWeekOfBirth = base::weekdays(DateOfBirth),
           DayWeekOfBirth = lubridate::wday(DateOfBirth,
                                            label = TRUE, abbr = FALSE),
           QuarterOfBirth = lubridate::quarter(DateOfBirth))

tb <- tb %>%
    mutate(MonthOfBirth = month(DateOfBirth, label = TRUE),
           YearOfBirth = year(DateOfBirth),
           DayWeekOfBirth = wday(DateOfBirth,
                                 label = TRUE, abbr = FALSE),
           QuarterOfBirth = quarter(DateOfBirth))

tb %>%
    select(ends_with("Birth")) %>%
    str()

tb %>%
    drop_na(MonthOfBirth) %>%
    ggplot(mapping = aes(x = MonthOfBirth)) +
    geom_bar()

tb %>%
    drop_na(QuarterOfBirth) %>%
    ggplot(mapping = aes(x = QuarterOfBirth)) +
    geom_bar()

tb %>%
    drop_na(YearOfBirth) %>%
    ggplot(mapping = aes(x = YearOfBirth)) +
    geom_bar()

tb %>%
    drop_na(DayWeekOfBirth) %>%
    ggplot(mapping = aes(x = DayWeekOfBirth)) +
    geom_bar()

##----------------------------------------------------------------------
## Uma string que representa uma data precisa ser convertido para data
## usando as.Date(), as.POSIX(), ISOdate(), strptime(), chron(), etc.

nasc <- c(tukey = "16/06/1915",
          cramer = "25/09/1893",
          fisher = "17/02/1890",
          kendall = "06/09/1907",
          gosset = "13/06/1876",
          pearson = "27/03/1857",
          galton = "16/02/1822",
          gauss = "30/04/1777",
          laplace = "23/03/1749",
          newton = "04/01/1643",
          lagrange = "25/01/1736",
          anscombe = "18/03/1919")

str(nasc)
typeof(nasc)

help(POSIXct, h = "html")

(y <- base::as.Date(nasc, format = "%d/%m/%Y"))
class(y)
typeof(y)

(y <- lubridate::dmy(nasc))
class(y)
typeof(y)

names(y) <- names(nasc)
sort(y)

##----------------------------------------------------------------------
## Após conversão é possível fazer cálculos com datas.

d <- range(y)
d
diff(d)

difftime(max(y), min(y), units = "weeks")
difftime(max(y), min(y), units = "days")
difftime(max(y), min(y), units = "hours")

## NOTE: diferença em meses e anos não tem porque não é regular. Meses
## não tem todos 30 dias. Anos não tem todos 365 dias. Mas você fazer por
## divisão.
## Meses
difftime(max(y), min(y), units = "days")/30
## Anos
difftime(max(y), min(y), units = "days")/30/12


##-----------------------------------------------------------------------
## Extratores.

## Mês.
lubridate::month(y, label = TRUE)
base::months(y)

## Dia da semana.
lubridate::wday(y, label = TRUE)
base::weekdays(y)

## Trimestre.
lubridate::quarter(y)
base::quarters(y)

## Ano.
lubridate::year(y)
as.numeric(base::strftime(y, "%Y"))

## Dia do mês.
lubridate::mday(y)
as.numeric(base::strftime(y, "%d"))

## Dia do ano.
lubridate::yday(y)
as.numeric(base::strftime(y, "%j"))

## Semana do ano.
lubridate::week(y)
as.numeric(base::strftime(y, "%V"))

help(strftime, help_type = "html")

## A as.Date() só serve para datas com menor unidade de tempo sendo o
## dia ou seja, não serve para datas com H:M:S.

##----------------------------------------------------------------------
## Passando de datas para string com formatos de leitura.

format(y, format = "%A, %d de %B de %Y")
strftime(y, format = "%A, %d de %B de %Y")

format(y, format = "%a, %d %b %Y")
strftime(y, format = "%a, %d %b %Y")

format(Sys.time(),
       format = "documento gerado em %d de %B de %Y às %H:%M")
strftime(Sys.time(),
         format = "Hoje é uma %A, dia %d do mês de %B do ano de %Y")

## Dia juliano.
strftime(y, format = "%j")

##-----------------------------------------------------------------------
## Sequencia de datas.

## Com o {base}.
seq(as.Date("1700-01-01"), as.Date("1970-01-01"), by = "year")
seq(as.Date("1700-01-01"), as.Date("1970-01-01"), by = "10 years")
seq(as.Date("1700-01-01"), as.Date("1970-01-01"), by = "100 years")
seq(as.Date("1700-01-01"), as.Date("1970-01-01"), by = "6 months")
as.Date(Sys.time()) + 152

## Cria sequências regulares de datas com {lubridate}.
Sys.Date() %m+% years(0:3)
Sys.Date() %m+% months(0:3)
Sys.Date() %m+% days(0:3)
Sys.Date() %m+% weeks(0:3)
Sys.Date() %m+% weeks(0:3)
