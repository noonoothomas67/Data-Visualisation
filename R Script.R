library(readr)
broken_rails_and_buckled_rails <- read_csv("broken rails and buckled rails.csv")
View(broken_rails_and_buckled_rails)
rail_data <- data.frame(
  Year = c("2002-03","2003-04","2004-05","2005-06","2006-07","2007-08",
           "2008-09","2009-10","2010-11","2011-12","2012-13","2013-14",
           "2014-15","2015-16","2016-17","2017-18","2018-19","2019-20",
           "2020-21","2021-22","2022-23","2023-24","2024-25"),
  Time_Index = 1:23,
  Broken_Rails = c(444,334,322,316,192,181,165,169,182,129,180,120,
                   95,104,88,74,86,93,82,68,99,61,53),
  Buckled_Rails = c(9,137,32,56,85,4,17,25,29,12,10,19,
                    14,9,7,14,25,12,7,13,29,4,4)
)
head(rail_data)

library(ggplot2)
ggplot(rail_data, aes(x = Time_Index)) +
  geom_line(aes(y = Broken_Rails, colour = "Broken Rails"), linewidth = 1) +
  geom_line(aes(y = Buckled_Rails, colour = "Buckled Rails"), linewidth = 1) +
  scale_colour_manual(
    values = c("Broken Rails" = "#1f78b4",
               "Buckled Rails" = "#e31a1c")
  ) +
  labs(
    title = "Trends in Broken and Buckled Rail Failures (2002–2025)",
    x = "Time (Annual Index)",
    y = "Number of Failures",
    colour = "Failure Type"
  ) +
  theme_minimal()  

library(ggplot2)  
ggplot(rail_data, aes(x = Broken_Rails, y = Buckled_Rails)) +
  geom_point(colour = "#6a3d9a", size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = TRUE, colour = "#33a02c") +
  labs(
    title = "Relationship Between Broken and Buckled Rail Failures",
    x = "Number of Broken Rails",
    y = "Number of Buckled Rails"
  ) +
  theme_minimal()

library(ggplot2)

ggplot(rail_data, aes(x = Broken_Rails)) +
  geom_histogram(
    bins = 10,
    fill = "#1f78b4",
    colour = "white",
    alpha = 0.8
  ) +
  labs(
    title = "Distribution of Broken Rail Failures",
    x = "Number of Broken Rails",
    y = "Frequency"
  ) +
  theme_minimal()

library(ggplot2)
library(tidyr)
rail_long <- rail_data %>%
  pivot_longer(
    cols = c(Broken_Rails, Buckled_Rails),
    names_to = "Failure_Type",
    values_to = "Failures"
  )
ggplot(rail_long, aes(x = Failure_Type, y = Failures, fill = Failure_Type)) +
  geom_boxplot(alpha = 0.8) +
  scale_fill_manual(
    values = c("Broken_Rails" = "#1f78b4",
               "Buckled_Rails" = "#e31a1c")
  ) +
  labs(
    title = "Comparison of Broken and Buckled Rail Failures",
    x = "Failure Type",
    y = "Number of Failures"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
