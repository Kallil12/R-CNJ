library(tidyverse)

mpg
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# a graphing template:
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

str(mpg)
?mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

?mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

# facets

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth()


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

?geom_smooth

# statistical transformations

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

?geom_bar

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

?stat_summary

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1))

# explain the need to put "group = 1" and why this code is not different from 
# the one above
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop), group = 1))


ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))


ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy))+
  geom_point(position = "jitter")

?geom_jitter
?geom_count


# final ggplot template:

#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(
#    mapping = aes(<MAPPINGS>),
#    stat = <STAT>, 
#    position = <POSITION>
#  ) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>











