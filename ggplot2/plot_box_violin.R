source('Utils.R')

# 点图
data('iris')
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_point(position = 'jitter', aes(color = Species))

# errorbar
iris_data <- group_by(iris, Species) %>%
  summarise(Sepal.Length.mean = mean(Sepal.Length),
            Sepal.Length.sd = sd(Sepal.Length))

ggplot(data = iris_data, aes(x = Species, y = Sepal.Length.mean)) +
  geom_point(aes(color = Species)) +
  geom_errorbar(aes(ymin = Sepal.Length.mean - Sepal.Length.sd,
                    ymax = Sepal.Length.mean + Sepal.Length.sd,
                    color = Species),
                size = 0.7,
                width = 0.1)

# 箱线图
data('iris')
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot(aes(fill = Species)) +
  geom_signif(comparisons = list(c('setosa', 'versicolor'),
                                 c('setosa', 'virginica'),
                                 c('versicolor', 'virginica')),
              y_position = c(7.2, 8.2, 7.8),
              map_signif_level = T) +
  scale_fill_npg() +
  theme_classic()

data('iris')
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot(aes(fill = Species)) +
  geom_point(aes(color = Species),
             position = 'jitter') +
  geom_signif(comparisons = list(c('setosa', 'versicolor'),
                                 c('setosa', 'virginica'),
                                 c('versicolor', 'virginica')),
              y_position = c(7.2, 8.5, 8.2),
              map_signif_level = T) +
  scale_fill_npg() +
  scale_color_npg() +
  theme_classic()

# 小提琴图
data('iris')
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(aes(fill = Species)) + # color = Species不填充颜色
  geom_boxplot(width = 0.21) +
  geom_signif(comparisons = list(c('setosa', 'versicolor'),
                                 c('setosa', 'virginica'),
                                 c('versicolor', 'virginica')),
              y_position = c(7.2, 8.5, 8.2),
              map_signif_level = T) +
  scale_fill_npg() +
  theme_classic()

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(aes(color = Species),
              width = 0.9,
              size = 0.8) + 
  geom_boxplot(width = 0.21) +
  geom_point(aes(color = Species),
             position = position_jitter(width = 0.18),
             size = 1.5) +
  geom_signif(comparisons = list(c('setosa', 'versicolor'),
                                 c('setosa', 'virginica'),
                                 c('versicolor', 'virginica')),
              y_position = c(7.2, 8.5, 8.2),
              map_signif_level = T) +
  scale_fill_npg() +
  theme_classic()

## 云雨图library(gghalves)
data('iris')
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_half_violin(aes(fill = Species),
                   side = 'r',
                   adjust = 1/2,
                   position = position_nudge(x = 0.2, y = 0)) +
  geom_boxplot(width = 0.12,
               position = position_nudge(x = 0.2, y = 0)) +
  geom_point(aes(color = Species),
             position = position_jitter(width = 0.12),
             size = 1.5) +
  scale_fill_brewer(palette = 'Dark2') +
  scale_color_brewer(palette = 'Dark2') +
  theme_classic() +
  coord_flip() 

# 比较同一个物种的花萼和花瓣长度，用到分面
data('iris')
iris_data <- select(iris, species = Species, 
                    sepal = Sepal.Length, 
                    petal = Petal.Length) %>%
  gather(key = condition, value = length, sepal, petal) 

ggplot(data = iris_data, aes(x = condition, y = length)) +
  geom_boxplot(aes(fill = condition)) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(x = '') +
  facet_grid(~species) +
  scale_fill_d3() +
  theme_test()
  
