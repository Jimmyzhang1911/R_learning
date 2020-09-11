source('Utils.R')

# 散点图
data("diamonds")

set.seed(500)
sml_dia <- sample_n(diamonds, size = 500)

ggplot(data = sml_dia, aes(x = carat, y = price)) +
  geom_point(shape = 21, size = 4,
             aes(fill = cut)) +
  geom_smooth(aes(group = 1), method = 'lm') +
  geom_rug(aes(color = cut), length = unit(3, 'mm')) +
  annotate("text", x = 2.5, y = 15, label = "r = 0.917;pvalue = 2.2e-16") +
  scale_fill_npg() +
  scale_color_npg() +
  theme_classic() +
  theme(legend.position = c(0.15, 0.8), legend.background = element_blank())

# 折线图
data('gapminder')

filter(gapminder, country %in% c('China', 'India', 'Japan')) %>%
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line(aes(group = country, color = country)) +
  theme_classic()

filter(gapminder, country %in% c('China', 'India', 'Japan')) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line(size = 1.6) +
  geom_point(shape = 21, size = 3, fill = 'white') +
  scale_color_brewer(palette = 'Set2') +
  theme_minimal_hgrid() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) 

# 配对折线图：
HIV
hiv_data <- gather(HIV, key = Group, value = Value, 3:5) %>%
  separate(col = Value, sep = ' ', into = c('Number', 'Ratio')) %>%
  separate(col = Number, sep = '/', into = c('Num', 'Total')) %>%
  mutate(Ratio = str_remove_all(Ratio, '\\(|\\)')) %>%
  #mutate(Ratio = str_remove(Ratio, '\\)')) %>%
  mutate(Num = as.numeric(Num),
         Total = as.numeric(Total),
         Ratio = as.numeric(Ratio))
hiv_data

p1 <- filter(hiv_data, Group %in% c('Group A', 'Group C')) %>%
  ggplot(aes(x = Group, y = Ratio, color = Triplet)) +
  geom_point(aes(size = Num)) +
  geom_line(aes(group = Triplet), size = 1.25) +
  geom_text_repel(data = filter(hiv_data, Group == 'Group A'),
                  aes(label = str_remove(Triplet, 'Triplet ')),
                  nudge_x = -0.1,
                  min.segment.length = Inf) +
  geom_text_repel(data = filter(hiv_data, Group == 'Group C'),
                  aes(label = str_remove(Triplet, 'Triplet ')),
                  nudge_x = 0.1,
                  min.segment.length = Inf) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2.5)) +
  labs(x = '',
       y = 'HIV infections\n(per 100 persons)') +
  scale_size(range = c(3, 5),
             breaks = c(10, 20, 30, 40),
             labels = c(10, 20, 30, 40),
             limits = c(10, 50)) +
  scale_color_jco() +
  theme_half_open()

p2 <- filter(hiv_data, Group %in% c('Group B', 'Group C')) %>%
  ggplot(aes(x = Group, y = Ratio, color = Triplet)) +
  geom_point(aes(size = Num)) +
  geom_line(aes(group = Triplet), size = 1.25) +
  geom_text_repel(data = filter(hiv_data, Group == 'Group B'),
                  aes(label = str_remove(Triplet, 'Triplet ')),
                  nudge_x = -0.1,
                  min.segment.length = Inf) +
  geom_text_repel(data = filter(hiv_data, Group == 'Group C'),
                  aes(label = str_remove(Triplet, 'Triplet ')),
                  nudge_x = 0.1,
                  min.segment.length = Inf) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2.5)) +
  labs(y = '',
       x = '') +
  scale_size(range = c(3, 5),
             breaks = c(10, 20, 30, 40),
             labels = c(10, 20, 30, 40),
             limits = c(10, 50)) +
  scale_color_jco() +
  theme_half_open()

# 拼图
# library(patchwork)
p1 + p2 + plot_layout(guides = 'collect') +
  plot_annotation(tag_levels = 'A',
                  title = 'My first ggplot2 learning') &
  theme(legend.position = 'right')








