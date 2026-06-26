library(ggplot2)
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = class))
library(dplyr)
library(nycflights13)
install.packages("nycflights13")
install.packages("dplyr")
library(nycflights13)
not_cancelled <- flights
filter(!is.na(dep_delay))
