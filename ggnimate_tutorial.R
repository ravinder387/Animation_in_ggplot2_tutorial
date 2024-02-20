library(ggplot2)
library(gganimate)
library(gapminder)
library(lubridate)

# 1. To animate factor variable
ggplot(mpg, aes(class)) + 
  geom_bar() +
  transition_states(class)


# 2. To animate continuous variable
## linear move
df <- data.frame(x = 1:4, y = 1:4, f = 1:4)

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  transition_time(f)

## zig-zag move
df <- data.frame( 
  x = c(1,2,3,4), 
  y = c(1,4,1,4), 
  f = c(1,2,3,4)
)

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  transition_time(f)

# 3. gapminder
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

# 4. To animate date object
day <- c("2018/10/15", "2018/10/16", "2018/10/17", 
         "2018/10/18", "2018/10/19", "2018/10/20",
         "2018/10/21", "2018/10/22", "2018/10/23",
         "2018/10/24", "2018/10/25", "2018/10/26")
df <- data.frame(day = as.Date(day),
                 pneumatic=c(4.2,6.8,8.8,1.5,6.5,10,3.2,9,1,5.5,8.2,2.5),
                 hydraulic = c(3,4.2,5,4,3.3,5.1,3.1,5.2,4.5,3.1,4.5,3))
ggplot(data=df, aes(x=day, group=1)) +
  geom_line(aes(y=pneumatic, colour='pneumatic')) +
  geom_line(aes(y=hydraulic, colour='hydraulic')) +
  scale_colour_manual("", 
                      breaks = c('pneumatic', 'hydraulic'),
                      values = c("red", "blue")) +
  ylab("Machine Pressure") +
  transition_reveal(day)


