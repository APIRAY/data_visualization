## Data Visualization or chart
## 1. Number of variable : one, two, more than two vars
## 2. Data type : number , not a number (factor)

## Q : one variable, number
## A : histogram/ density

library(ggplot2)
library(dplyr)

diamonds
View(diamonds)
ggplot(diamonds)
ggplot(data = diamonds,
       mapping = aes(x = price)) +
  geom_histogram()
    
base <- ggplot(data = diamonds,
       mapping = aes(x = price))
## mapping vs. setting
base + geom_histogram()       # defalt 30 bin
base + geom_histogram(bins = 10, 
                      fill = "blue",
                      color = "black")
 
base + geom_density()
base + geom_freqpoly()

## discrete = non-number = factor
## one variable, factor

diamonds %>%
  count(cut)

ggplot(data =diamonds,
       mapping = aes(x = cut)) +
  geom_bar(fill = "salmon", alpha = 0.8)


base2 <- ggplot(data =diamonds,
       mapping = aes(x = cut))

base2 + 
  geom_bar(mapping = aes(fill = cut), 
           alpha = 0.6)

## two variables, nuber x number
## scatter plot

set.seed(42)
small_diamonds <- diamonds %>%
  sample_n(5000)

ggplot(data = small_diamonds,
       mapping = aes(x = price, y = carat)) +
  geom_point(alpha = 0.8, shape = "+")

# Fill color 
# Ex1 
  ggplot(data = small_diamonds,
       mapping = aes(x = price, y = carat, color = cut)) +
  geom_point(alpha = 0.4)
# Ex2
  ggplot(data = small_diamonds,
       mapping = aes(x=price, y=carat)) +
  geom_point(mapping = aes(color = cut),
             alpha = 0.4)

# Filter
  set.seed(42)
  small_diamonds <- diamonds %>%
  sample_n(5000) %>%
  filter(cut == "Good")

  ggplot(data = small_diamonds,
       mapping = aes(x=price, y=carat)) +
    geom_point(mapping = aes(color = cut),
             alpha = 0.7) +
  theme_minimal()

# Summary statistics 
diamonds %>%
  group_by(cut) %>%
  summarise(
    n = n(),
    avg_price = mean(price),
    avg_carat = mean(carat)
  )

# plotly package
  library(plotly)

  plot1 <- ggplot(mtcars, aes(hp, mpg)) +
    geom_point()

  ggplotly(plot1)
  
## ggplot2 : 2D
   ## add more variables
   ## mapped to aesthetic of the chart  
   ggplot(diamonds %>% sample_n(1500),
         aes(x=carat, y=price)) +      
    geom_point(aes(color = clarity,
                   shape = cut),
                   size = 3) +
    theme_minimal()
  
## faceting breaks down big chart
## into small multiples
   ggplot(diamonds %>% sample_n(5000),
          aes(x = carat, y = price)) +
     geom_point(aes(color = cut), alpha = 0.5) +
     #facet_wrap(~ color, ncol = 7)
     facet_grid(cut ~ clarity) ## 40 sub plots
   
## let's look at mtcars
   ggplot(mtcars %>% 
            filter(hp < 130, mpg > 16), 
          aes(hp, mpg)) + 
     geom_point() +
     # geom_smooth (default) -> method = loess 
     # geom_smooth (linear model) -> method = lm  
     geom_smooth(method = "loess", 
                 se = TRUE,
                 color = "red",
                 fill = "#bfb088") +
     theme_minimal() + 

  ## add labels to chart
     labs(title = "Scatter Plot HP x MPG",
          subtitle = "Positive relationship between two variables",
          caption = "Data Source: mtcars dataframe",
          x = "horse power",
          y = "mile per gallon")
   

## dplyr + ggplot
   # prep data  
   diamonds %>%
     filter(carat >= 0.5, 
            price >= 4000,
            cut == "Ideal") %>%
     count(clarity) %>%
     # move data into ggplot + geom_col
     ggplot(aes(clarity, n, fill = clarity)) +  # Add fill = clarity here
     geom_col()
   
## boxplot
   ggplot(diamonds %>% sample_n(1000),
          aes(y=cut, x=price)) +
     geom_boxplot()  
   
## violin plot
   ggplot(diamonds %>% sample_n(1000),
          aes(x=cut, y=price)) +
     geom_violin()
   
   ggplot(diamonds %>% sample_n(1000),
          aes(price)) +
     geom_histogram(aes(fill=cut), alpha=0.4) +
     theme_minimal()
   
## multiple datasets
   premium_di <- diamonds %>%
     filter(cut == "Premium", carat>=2) %>%
     sample_n(500)
   
   good_di <- diamonds %>%
     filter(cut == "Good") %>%
     sample_n(500)
   
   ggplot() +
     geom_point(data = premium_di, 
                mapping = aes(carat, price),
                color = "#a35a7c") +
     geom_point(data = good_di, 
                mapping = aes(carat, price),
                color = "#285922", alpha=0.5) +
     theme_minimal()   
   
## change color manually   
   diamonds %>%
     ggplot(aes(cut, fill = cut)) + 
     geom_bar() + 
     theme_minimal() + 
     scale_fill_manual(values = c(
       "#593524",
       "#915336",
       "#8f794d",
       "#dbc08a",
       "#748ca8"
     ))
   
  mtcars %>%
    ggplot(aes(hp, mpg, colour = hp)) + 
    geom_point(size = 4) +
    theme_minimal() +
    scale_colour_gradient(low = "#12365e",
                          high = "#f2aade")
   
   
   
## Homework
## 1. creat 5 ggplot charrt
## 2. google sheet
View(AirPassengers)

