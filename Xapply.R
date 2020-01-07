#=apply,sapply,lapply,tapply,vapply,mapply
#
#apply:
#apply（m，dimcode，f，fargs）
  # m 是一个矩阵。
  # dimcode是维度编号，取1则为对行应用函数，取2则为对列运用函数。
  # f是函数
  # fargs是f的可选参数集
z <- matrix(1:6, nrow = 3);z
f <- function(x) {
  x/c(2, 8)}
apply(z,2,f);apply(z,1,f)  #结果竖放
#
#
#lapply
#lapply（）对列表的每个组件执行给定的函数，并返回另一个列表。
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE));x
lapply(x, mean)
#
#
#sapply():代表simplified [l]apply可以将结果整理以向量，矩阵，列表 的形式输出
sapply(x, mean)   #结果横放(变量)
sapply(x, quantile)
sapply(2:4, seq)
#
#
#vapply():与sapply（）相似，他可以预先指定的返回值类型。使得得到的结果更加安全。
vapply(x, quantile, c(1,2,5,6,8))
?vapply
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE));x
lapply(x, mean)
lapply(x, quantile, probs = 1:3/4)  
sapply(x, quantile)
i39 <- sapply(3:9, seq);i39
sapply(i39, fivenum)
vapply(i39, fivenum,
       c(Min. = 0, "1st Qu." = 0, Median = 0, "3rd Qu." = 0, Max. = 0))
#
#
#tapply（x，f，g）需要向量 x (x不可以是数据框)，因子或因子列表 f 以及函数 g 。
#tapply（）执行的操作是：暂时将x分组，每组对应一个因子水平，得到x的子向量，然后这些子向量应用函数 g
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))
##每中gear类型对应的mpg的平均值
with(mtcars, tapply(mpg, gear, mean, na.rm = TRUE))
mtcars
with(mtcars, aggregate(mtcars, by=list(Group.cyl=cyl, Group.gear=gear), mean))
a<-mtcars
a <-a %>% add_rownames("cars")
library(reshape2)
md<-melt(a, id=c("cars", "gear"))
mtcars;md
dcast(md, gear~variable, mean)

a <- c(24,25,36,37)
b <- c('q', 'w', 'q','w')
tapply(a, b, mean)


#mapply（）多参数版本的sapply()
#第一次计算传入各组向量的第一个元素到FUN，进行结算得到结果
#第二次传入各组向量的第二个元素，得到结果
#第三次传入各组向量的第三个元素…以此类推。
l1 <- list(a = c(1:3), b = c(4:6))
l2 <- list(c = c(7:9), d = c(10:12))
l1;l2
mapply(sum, l1$a, l1$b)
