source('Utils.R')

# facet_grid双变量分面
data('mtcars')
mtcars_tbl <- rownames_to_column(mtcars, var = 'car') %>%
  mutate(cyl = factor(cyl),
         vs = if_else(vs == 1, 'V', 'L'),
         am = if_else(am == 1, 'A', 'M'))

ggplot(data = mtcars_tbl, aes(x = wt, y = mpg)) +
  geom_point(shape = 21, alpha = 0.5,
             aes(size = disp, fill = cyl)) +
  scale_fill_npg() +
  scale_size(range = c(1, 20)) +
  facet_grid(~cyl) +
  theme_bw()


# facet_wrap单变量
data('diamonds')
diamonds_data <- sample_n(diamonds, size = 500)
ggplot(data = diamonds_data, aes(x = carat, y = price)) +
  geom_point(shape = 21, size = 3.5,
             color = 'black', aes(fill = cut)) +
  scale_fill_aaas() +
  facet_wrap(~color, ncol = 3) +
  theme_bw() +
  theme(legend.position = c(0.8, 0.15))

# facet_matrix多变量
ggplot(data = mtcars_tbl, aes(x = .panel_x, y = .panel_y)) +
  geom_point(shape = 21, size = 3,
             aes(fill = cyl)) +
  scale_fill_d3() +
  facet_matrix(vars(mpg, disp, wt, qsec)) +
  theme_bw()

# 局部放大library(ggforce)
data('iris')
ggplot(data = iris, aes(x = Petal.Length, 
                        y = Petal.Width,
                        color = Species)) +
  geom_point(size = 3) +
  facet_zoom(x = Species == 'versicolor',
             zoom.size = 0.5) +
  scale_color_aaas() +
  theme_classic()

ggplot(data = iris, aes(x = Petal.Length, 
                        y = Petal.Width,
                        color = Species)) +
  geom_point(size = 3) +
  facet_zoom(xlim = c(3.5, 5.3),
             ylim = c(1.3, 2)) +
  scale_color_aaas() +
  theme_classic()

# 画圈圈
ggplot(data = iris, aes(x = Petal.Length, 
                        y = Petal.Width,
                        color = Species)) +
  geom_point(size = 3) +
  geom_mark_hull(aes(label = Species)) +
  scale_color_aaas() +
  theme_classic()

# 图中表
# 子表
small_tbl <- group_by(iris, Species) %>%
  summarise(mean_Length = mean(Petal.Length),
            mean_Width = mean(Petal.Width))
# 位置表
tmp_tbl <- tibble(x = 8, y = 0.2, tb = list(small_tbl)) 
# library(ggpmisc)
ggplot(data = iris, aes(x = Petal.Length, 
                        y = Petal.Width,
                        color = Species)) +
  geom_point(size = 3) +
  geom_mark_hull(aes(label = Species)) +
  geom_table(data = tmp_tbl, aes(x = x, y = y, label = tb)) +
  scale_color_aaas() +
  theme_classic() +
  theme(legend.position = c(0.1, 0.8))

# 图中图
p0 <- ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(fill = Species)) +
  geom_signif(comparisons = list(c('versicolor', 'virginica')),
              map_signif_level = T) +
  scale_fill_aaas() +
  theme_minimal_hgrid() +
  theme(legend.position = 'none',
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        plot.background = element_blank()) # 不知道是什么

tmp_tbl <- tibble(x = 7, y = 0.0025, plot = list(p0))
ggplot(data = iris, aes(x = Petal.Length, 
                        y = Petal.Width,
                        color = Species)) +
  geom_point(size = 3) +
  geom_plot(data = tmp_tbl, aes(x = x, y = y, label = plot)) +
  geom_mark_hull(aes(label = Species)) +
  scale_color_aaas() +
  theme_classic() +
  theme(legend.position = c(0.1, 0.8))  

# 拼图library(patchwork)






