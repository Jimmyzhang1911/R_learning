#===paste()===
#
#paste (..., sep = " ", collapse = NULL)
#paste0(..., collapse = NULL)
  #...          :要组和的任意个数的参数
  #sep          :参数之间的分隔符
  #clooapse     :用于消除两个字符串之间的空间。但不是在一个字符串的两个词的空间。
paste0(1:12)
paste(1:12)        # same
as.character(1:12) # same
(nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9))))
paste(month.abb, "is the", nth, "month of the year.")
paste(month.abb, letters)
paste(month.abb, "is the", nth, "month of the year.", sep = "_*_")
paste("1st", "2nd", "3rd", collapse = ", ")
paste("1st", "2nd", "3rd", sep = ", ")
#===end

#===split()===
#
#函数split()可以按照分组因子，把向量，矩阵和数据框进行适当的分组。
  #它的返回值是一个列表，代表分组变量每个水平的观测。
    #这个列表可以使用sapply(),lappy()进行处理（apply – combine步骤），得到问题的最终结果。
#split(x, f, drop = FALSE, ...)
  #x:     一个待分组的向量或者data frame
  #f:     函数，一个factor或者list（如果list中元素交互作用于分组中），以此为规则将x分组
  #drop:  逻辑值，如果f中的某一个level没有用上则被弃用
  #value: 一个储存向量的list，其形式类似于分组完成之后返回的那个list
df$Year_Month <- factor(paste(df$Year, df$Month, sep = "-" ))
df_list2 <- split(df, f=df$Year_Month)
split(d$income, list(d$gender,d$over25)) #将income按照gender、over25分组
#===end

#
#aggregate:聚类，
attach(mtcars)
aggdata<-aggregate(mtcars, by=list(mean.cyl=cyl,mean.gear=gear), FUN=mean, na.rm=TRUE);aggdata
# 按~后的变量进行聚类，然后对~前的变量进行进行fun
aggregate(ArrDelay ~ Dest, flights, mean)
aggregate(mpg~gear+carb, mtcars, mean)

#
## ncol, nrow
ncol(mtcars) #看有多少列
nrow(mtcars) #看多少行



