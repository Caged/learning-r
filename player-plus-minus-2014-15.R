library(dplyr)
library(tidyr)
library(ggplot2)

pm_data <- read.csv('data/player_plus_minus.csv')

pm_data$short_name <- gsub("^[a-z]+", "", pm_data$player_name, perl=TRUE, ignore.case=T)

pl_data <- group_by(pm_data, team_abbreviation, player_name) %>%
  summarize(mean = mean(plus_minus), max = max(plus_minus), min = min(plus_minus), sd = sd(plus_minus)) %>%
  arrange(desc(mean))
team_data <- group_by(pm_data, team_abbreviation, player_name)

blazers <- pm_data %>% filter(team_abbreviation == 'CLE')
pm_data$short_name <- factor(pm_data$short_name, levels = unique(pm_data$short_name))


ggplot(pm_data, aes(x=plus_minus, y=short_name)) + 
  geom_boxplot(fill="#6B46CA", color="#462990") + 
  ggtitle('Individual Plus/Minus per team') +
  ylab('Player') +
  xlab('Plus-Minus 25th-75th percentile range') +
  facet_wrap(~ team_abbreviation, scales="free_y")
