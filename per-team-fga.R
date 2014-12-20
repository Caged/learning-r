library(dplyr)
library(ggplot2)

raw_data <- read.csv('data/players_base.csv')
data <- filter(raw_data, season == '2014-15', permode == 'totals') %>%
  select(team_abbreviation, player_name, fga) %>%
  group_by(team_abbreviation) %>%
  summarize(total_fga = sum(fga)) %>%
  arrange(desc(total_fga))

data$team_abbreviation <- factor(data$team_abbreviation, levels = unique(data$team_abbreviation))

ggplot(data, aes(x=team_abbreviation, y=total_fga, width = .5)) +
  geom_bar(stat = "identity", fill="#6B46CA", color="#462990") +
  xlab('Team') +
  ylab('Total FGA') +
  ggtitle('Total team field goal attempts')

