source('Utils.R')

# 直方图
data('diamonds')
ggplot(data = diamonds, aes(x = price)) +
  geom_histogram(bins = 20,
                 position = 'dodge',
                 aes(fill = cut)) +
  scale_fill_brewer(palette = 'Set3') +
  scale_y_continuous(expand = c(0, 0)) +
  theme_minimal_hgrid() +
  theme(legend.position = c(0.8, 0.8))

# 密度图
data('diamonds')
ggplot(data = diamonds, aes(x = price)) +
  geom_density(aes(fill = cut),
               alpha = 0.3) +
  scale_fill_aaas() +
  theme_minimal_hgrid() +
  theme(legend.position = c(0.8, 0.8))

ggplot(data = diamonds, aes(x = price)) +
  geom_density(size = 1.5, aes(color = cut)) +
  scale_color_brewer(palette = 'Set3') +
  theme_minimal_hgrid() +
  theme(legend.position = c(0.8, 0.8))

# 山峦图library(ggridges)
ggplot(data = diamonds, aes(x = price, y = cut)) +
  geom_density_ridges(aes(fill = cut)) +
  scale_fill_brewer(palette = 'Set3') +
  xlim(-480, 12000) +
  labs(y = '') +
  theme_minimal_hgrid() +
  theme(legend.position = c(0.55, 0.9),
        legend.direction = 'horizontal')
  