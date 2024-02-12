library(plotly)
library(ggplot2)
library(gapminder)
# 1. simple animation
## linear move
df <- data.frame(
  x = c(1,2,3,4), 
  y = c(1,2,3,4), 
  f = c(1,2,3,4)
)

## zig-zag move
df <- data.frame(
  x = c(1,2,3,4), 
  y = c(1,4,1,4), 
  f = c(1,2,3,4)
)
p <- ggplot(df, aes(x,y)) +
  geom_point(aes(frame = f))

ggplotly(p)

df <- data.frame(
  x = c(1,2,3,4), 
  y = c(1,2,3,4), 
  f = c(1)
)
p <- ggplot(df, aes(x, y)) +
  geom_point(aes(frame = f))

ggplotly(p)

df <- data.frame(
  x = c(1,2,3,4), 
  y = c(1,2,3,4), 
  f = c(1,2)
)
p <- ggplot(df, aes(x, y)) +
  geom_point(aes(frame = f))

ggplotly(p)

# 2. gapminder animation
gapminder <- gapminder
p <- ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  scale_x_log10()

fig <- ggplotly(p)

fig <- fig %>% 
  animation_opts(
    1000, easing = "linear", redraw = FALSE
  )

fig
