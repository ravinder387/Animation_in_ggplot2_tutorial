library(ggplot2)
library(ggforce)

df <- data.frame(x = c(1:10),
                 y = c(1:10))

ggplot(df, aes(x,y)) +
  geom_point() +
  geom_circle(aes(x0=7.9, y0=9.7, r=1),
              linetype='dashed',
              color='red',
              fill='lightblue',
              lwd=1.1,
              inherit.aes = F) +
  coord_fixed()

# print
x0 = 7.9
y0 = 9.7
for(i in 1:8){
  p = ggplot(df, aes(x,y)) +
    geom_point() +
    geom_circle(aes(x0=x0, y0=y0, r=1),
                linetype='dashed',
                color='red',
                fill='lightblue',
                lwd=1.1,
                inherit.aes = F) +
    coord_fixed()
  print(p)
  x0 = x0 -1
  y0 = y0 -1
}

# print
x0 = 7.9
y0 = 9.7
for(i in 1:8){
  p = ggplot(df, aes(x,y)) +
    geom_point() +
    geom_circle(aes(x0=x0, y0=y0, r=1),
                linetype='dashed',
                color='red',
                fill='lightblue',
                lwd=1.1,
                inherit.aes = F) +
    coord_fixed()
  print(p)
  Sys.sleep(2)
  x0 = x0 -1
  y0 = y0 -1
}



