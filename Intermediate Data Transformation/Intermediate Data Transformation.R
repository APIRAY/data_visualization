library(dplyr)
library(readr)
imdb <- read_csv("imdb.csv", stringAsFactrors = FALSE) #No change text column to Factrors 
View(imdb)

# review structure data
glimpse(imdb)


# print head and tail of data
head(imdb, 10)
tail(imdb, 10)

# select
colnames(imdb)
select(imdb, MOVIE_NAME, RATING)
select(imdb,2,3)

#revise colname
select(imdb, movie_name = MOVIE_NAME,
       released_year = YEAR) # from MOVIE_NAME to movie_name
