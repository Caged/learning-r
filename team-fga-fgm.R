library(dplyr)
library(tidyr)
library(ggplot2)

raw_data <- read.csv('data/players_base.csv')
data <- filter(raw_data, season == '2014-15', permode == 'totals') %>%
  select(team_abbreviation, player_name, fga, fgm) %>%
  group_by(team_abbreviation) %>%
  summarize(total_fga = sum(fga), total_fgm = sum(fgm)) %>%
  arrange(desc(total_fga))

data$team_abbreviation <- factor(data$team_abbreviation, levels = unique(data$team_abbreviation))
dat2 <- gather(data, variable, value, -team_abbreviation)

ggplot(dat2, aes(x = team_abbreviation, y = value, width = .7, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values=c("#469FCA", "#466BCA"), name="Type", labels=c("FGA", "FGM")) +
  xlab('Team') +
  ylab('Total') +
  ggtitle('Team Shots') +
  theme(
    legend.title = element_blank(), 
    plot.title = element_text(size = 16, vjust = 2, family = "Gotham Light"),
    panel.background = element_rect(fill = '#ffffff')
  )

