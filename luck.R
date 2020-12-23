library(dplyr)
library(ggplot2)
n <- 18300
num_sim <- 10000


no_luck <- runif(n,80,100)
name_exp <- 1:100

luck <- runif(n,0,100)

no_luck_exp <- no_luck*95/100
luck_exp <- luck*5/100

selection <- no_luck_exp+luck_exp

data <- data.frame(luck,
                   selection,
                   no_luck)

data <- data[with(data, order(-data$selection)), ]

top_eleven_luck <- data[c(1:11),"luck"]
vector_percent <- top_eleven_luck

for (i in 1:num_sim-1) {
  no_luck <- runif(n,80,100)
  name_exp <- 1:100
  
  luck <- runif(n,0,100)
  
  no_luck_exp <- no_luck*95/100
  luck_exp <- luck*5/100
  
  selection <- no_luck_exp+luck_exp
  
  data <- data.frame(luck,
                     selection,
                     no_luck)
  
  data <- data[with(data, order(-data$selection)), ]
  
  top_eleven_luck <- data[c(1:11),"luck"]
  vector_percent <- c(vector_percent, top_eleven_luck)
}
vector_percent
mean(vector_percent)

set_2_color <- palette("Set 2")
color <- set_2_color[5]

ggplot(data = NULL) +
  geom_histogram(mapping = aes(x=vector_percent), binwidth = .3, color="darkblue", fill="lightblue") +
  geom_vline(aes(xintercept=mean(vector_percent)),
             color="blue", linetype="dashed", size=1) +
  labs(title = "Suerte para lograr Éxito", subtitle = "10 mil simulaciones", y = "Frecuencia", x="Porcentaje de suerte",
       caption = "(basado en el número de personas que llegan a ser astronautas,
       suponiendo que un 5% corresponde a la suerte)") + 
  theme_light()
  
