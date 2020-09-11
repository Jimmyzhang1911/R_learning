source('Utils.R')

data('mtcars')

m1 <- mtcars[, c('mpg', 'qsec')] # 性能
m2 <- mtcars[, c('cyl', 'disp', 'hp', 'drat', 'wt', 'vs', 'am')] # 车子的属性

# 相关系数矩阵图
quickcor(m2, type = 'full') + # upper,lower,full
  geom_square() # geom_circle2()
  















