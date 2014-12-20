library(dplyr)
library(tidyr)
library(ggplot2)

# Load CSV data
pm_data <- read.csv('data/player_plus_minus.csv')

# Remove player first names to shorten labels
pm_data$short_name <- gsub("^[a-z]+", "", pm_data$player_name, perl=TRUE, ignore.case=T)

# Sort short names.  Think this is wrong?
pm_data$short_name <- factor(pm_data$short_name, levels = unique(pm_data$short_name))


# Draw a grid of teams and players
#
# TODO: How do I sort the players by mean plus_minus?
# TODO: How do I change the confidence band of the box plot?
# TODO: How do I change the color of negative values?
ggplot(pm_data, aes(x=plus_minus, y=reorder(short_name, plus_minus, mean))) +
  geom_boxplot(fill="#6B46CA", color="#462990", outlier.shape=NA) +
  ggtitle('Individual Plus/Minus per team') +
  ylab('Player') +
  xlab('Plus-Minus 25th-75th percentile range') +
  facet_wrap(~ team_abbreviation, scales="free_y")
