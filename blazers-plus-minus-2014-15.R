library(dplyr)
library(tidyr)
library(ggplot2)

# Load CSV data
pm_data <- read.csv('data/player_plus_minus.csv')

# Remove player first names to shorten labels
pm_data$short_name <- gsub("^[a-z]+", "", pm_data$player_name, perl=TRUE, ignore.case=T)
blazers_team <- filter(pm_data, team_abbreviation == 'POR')

ggplot(blazers_team, aes(x=reorder(short_name, -plus_minus, mean), y=plus_minus)) +
  geom_boxplot(fill="#6B46CA", color="#462990") +
  ggtitle('Individual Plus/Minus per team') +
  ylab('Player') +
  xlab('Plus-Minus 25th-75th percentile range')