library(tidyverse)
library(cowplot) # 组合，主题
library(gapminder) # 数据
library(RColorBrewer)
library(ggsci)
library(ggrepel) # 标签
library(patchwork) # 拼图
library(scales) # 百分比转换
library(ggridges) # 山峦图
library(ggsignif) # p值
library(gghalves) # 云雨图，保留箱线图，小提琴图的一半
library(ggforce) # 分面，局部放大
library(ggpmisc) # 图中图
library(ComplexUpset) # upset图
library(ggcor) # 热图结合相关性

if(T){
  options(repos="http://mirrors.tuna.tsinghua.edu.cn/CRAN/")
  options(BioC_mirror="http://mirrors.tuna.tsinghua.edu.cn/bioconductor/")}

# 配对折线图数据
HIV <- tibble(Triplet = str_c('Triplet', 1:7, sep = ' '),
              From = c(rep('Zambia', 4), rep('South Africa', 3)), 
              `Group A` = c('28/1687 (1.64)', 
                            '33/2086 (1.57)', 
                            '23/1695 (1.36)', 
                            '41/2013 (2.04)', 
                            '36/1507 (2.35)', 
                            '26/1808 (1.43)', 
                            '13/2195 (0.57)'),
              `Group B` = c('19/1979 (0.94)', 
                            '29/2408 (1.20)', 
                            '22/1687 (1.30)', 
                            '19/1698 (1.13)', 
                            '33/1811 (1.80)', 
                            '26/2078 (1.24)', 
                            '10/2488 (0.40)'),
              `Group C` = c('24/2054 (1.17)', 
                            '33/2262 (1.48)', 
                            '29/1811 (1.63)', 
                            '37/1561 (2.39)', 
                            '28/1304 (2.15)', 
                            '32/1375 (2.31)', 
                            '14/2195 (0.59)'))

# 饼图数据
browers_data <- read_csv("mydata/browers.csv", 
                         col_types = cols(share = col_number())) %>%
  arrange(desc(version)) %>%
  mutate(sum_per = cumsum(share))

browers <- group_by(browers_data, browser) %>%
  summarise(share = sum(share)) %>%
  arrange(desc(browser)) %>%
  mutate(sum_share= cumsum(share))

# upset数据
upset_data <- read.table('mydata/Orthogroups.GeneCount.tsv', header = T)


load('mydata/wgcna.rdata') # WGCNA数据
load('mydata/de.rdata') # 复杂火山图数据
load('mydata/prepare.rdata') # 复杂火山图数据

