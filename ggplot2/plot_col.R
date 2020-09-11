source('Utils.R')

data('mtcars')
head(mtcars)

cars_data <- rownames_to_column(mtcars, var = 'car') %>%
  mutate(cyl = factor(cyl)) 

# 条形图  
ggplot(data = cars_data, aes(x = car, y = mpg)) +
  geom_col(aes(fill = cyl), width = 0.75) +
  scale_fill_npg() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.2))

# 排序：柱子高的在前，低的在后
cars_data <- rownames_to_column(mtcars, var = 'car') %>%
  mutate(cyl = factor(cyl)) %>%
  arrange(desc(mpg)) %>% mutate(car = factor(car , levels = car))
  
ggplot(data = cars_data, aes(x = car, y = mpg)) +
  geom_col(aes(fill = cyl), width = 0.75) +
  scale_fill_npg() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.2))

# 排序：先按照缸数排，之后再按油耗排
cars_data <- rownames_to_column(mtcars, var = 'car') %>%
  mutate(cyl = factor(cyl)) %>%
  arrange(desc(cyl), mpg) %>% mutate(car = factor(car , levels = car))

ggplot(data = cars_data, aes(x = car, y = mpg)) +
  geom_col(aes(fill = cyl), width = 0.75) +
  scale_fill_npg() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.2))

# z-score绘图
cars_data <- rownames_to_column(mtcars, var = 'car') %>%
  mutate(cyl = factor(cyl)) %>%
  mutate(mpg_z = (mpg - mean(mpg)) / sd(mpg)) %>%
  mutate(direction = if_else(mpg_z >= 0, 'high', 'low')) %>%
  arrange(desc(direction), mpg_z) %>% 
  mutate(car = factor(car , levels = car))

ggplot(data = cars_data, aes(x = car, y = mpg_z)) +
  geom_col(aes(fill = direction), width = 0.75) +
  scale_fill_npg() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.2))

## 棒棒糖图
cars_data <- rownames_to_column(mtcars, var = 'car') %>%
  arrange(desc(cyl), mpg) %>% mutate(car = factor(car , levels = car)) %>%
  mutate(cyl = factor(cyl))

ggplot(data = cars_data, aes(x = car, y = mpg)) +
  geom_segment(aes(color = cyl, x = car, y = 0, xend = car, yend = mpg)) +
  geom_point(aes(color = cyl),
             size = 3) +
  scale_color_jco() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.2))

# 柱状图
mydata <- filter(diamonds, cut %in% c('Ideal', 'Premium', 'Good')) %>%
  group_by(color, cut) %>% 
  summarise(count = n()) %>%
  arrange(color, desc(cut)) %>%
  mutate(sum_count = cumsum(count))

ggplot(data = mydata, aes(x = color, y = count)) +
  geom_col(aes(fill = cut), position = 'stack', width = 0.7) +
  geom_text(color = 'white', aes(x = color, 
                                 y = sum_count - 0.5*count, 
                                 label = count)) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_fill_jco() +
  theme_classic()

# 百分比显示方式
mydata <- filter(diamonds, cut %in% c('Ideal', 'Premium', 'Good')) %>%
  group_by(color, cut) %>% 
  summarise(count = n()) %>%
  arrange(color, desc(cut)) %>%
  mutate(per = count / sum(count),
         sum_per = cumsum(per))

ggplot(data = mydata, aes(x = color, y = per)) +
  geom_col(aes(fill = cut), position = 'stack', width = 0.618) +
  geom_text(color = 'white', 
            aes(x = color,
                y = sum_per - 0.5*per, 
                label = scales::percent(per, accuracy = 0.2))) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_fill_jco() +
  theme_classic()

# group_by用法：找出每类缸油耗最低的车子
data('mtcars') 

rownames_to_column(mtcars, var = 'cars') %>%
  group_by(cyl) %>%
  summarise(max_cyl = max(cyl))

rownames_to_column(mtcars, var = 'cars') %>% 
  group_by(cyl) %>%
  filter(mpg == max(mpg))
 

# 饼图
color <- c("#4169E1", "#8B0000", "#008080","#708090", "#FFD700")
ggplot(data = browers, aes(x = '', y = share)) +
  geom_col(aes(fill = browser)) +
  geom_text(data = filter(browers, share > 5),
            size = 3.6,
            aes(y = sum_share - 0.5 * share, 
                label = str_c(browser, '\n', share, '%'))) +
  geom_text_repel(data = filter(browers, share < 5),
                  nudge_x = 0.6,
                  size = 3.6,
                  min.segment.length = 0,
                  aes(y = sum_share - 0.5 * share, 
                      label = str_c(browser, '\n', share, '%'))) +
  scale_fill_manual(values = color) +
  coord_polar(theta = 'y') +
  theme_classic() +
  theme_nothing() 

# 甜甜圈图
color <- c("#4169E1", "#8B0000", "#008080","#708090", "#FFD700")
ggplot(data = browers, aes(x = 2, y = share)) +
  geom_col(aes(fill = browser)) +
  geom_text(data = filter(browers, share > 5),
            size = 3.6,
            aes(y = sum_share - 0.5 * share, 
                label = str_c(browser, '\n', share, '%'))) +
  geom_text_repel(data = filter(browers, share < 5),
                  nudge_y = 7,
                  color = 'black',
                  size = 3.6,
                  min.segment.length = 0,
                  aes(y = sum_share - 0.5 * share, 
                      label = str_c(browser, '\n', share, '%'))) +
  scale_fill_manual(values = color) +
  xlim(1.2, 2.5) +
  coord_polar(theta = 'y') +
  theme_classic() +
  theme_nothing() 

## 甜甜圈图微调标签
ggplot(data = browers, aes(x = 2, y = share)) +
  geom_col(aes(fill = browser),
           width = 1) +
  geom_text(data = filter(browers, share > 5),
            size = 3.6,
            aes(y = sum_share - 0.5 * share, 
                label = str_c(browser, '\n', share, '%'))) +
  geom_text_repel(data = filter(browers, share < 5),
                  nudge_y = 7,
                  color = 'black',
                  size = 3.6,
                  min.segment.length = 0,
                  aes(y = sum_share - 0.5 * share, 
                      label = str_c(browser, '\n', share, '%'))) +
  geom_col(data = browers_data,
           width = 1,
           aes(x = 3, y = share, fill = version)) +
  geom_text(data = filter(browers_data, share > 4), 
            aes(x = 3, y = sum_per - 0.5*share,
                label = str_c(browser, '\n', share, '%'))) +
  geom_text_repel(data = filter(browers_data, share <= 4),
                  nudge_x = 0.2,
                  min.segment.length = 0,
                  aes(x = 3.5, y = sum_per - 0.5*share,
                      label = str_c(browser, '\n', share, '%'))) +
  coord_polar(theta = 'y') +
  scale_fill_igv() +
  theme_nothing()
 