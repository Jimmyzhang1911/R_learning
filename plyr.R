install.packages("plyr")
library(plyr)
library(dplyr)
(.packages())
#!!!!!plyr和dplyr部分语法有冲突可以使用detach("package:dplyr")，dplyr的强度应该比plyr的大
#
#===d*ply基本用法===
#a*ply(.data, .margins, .fun, ..., .progress = "none") #margin表示切割方式，1行，2列
##数据集：
a<-matrix(1:21,nrow=3,ncol=7);a
is.array(a)
##基本用法
aaply(.data=a,.margins=1,.fun=mean)
aaply(a,1,mean)       #对行处理
aaply(a,2,mean)       #对列处理
aaply(a,c(1,2),mean)  #对a中的每个元素进行mean处理
#
#
#d*ply(.data, .variables, .fun, ..., .progress = "test")
##数据集
names=c("John","Mary","Alice","Peter","Roger","Phyillis")
age=c(13,15,14,13,14,13)
sex=c("Male","Female","Female","Male","Male","Female")
data=data.frame(names,age,sex)
data
amean<-function(data)
{
  agemean<-mean(data[,2])
  return(agemean)
}
##用法
daply(data,.(age),.fun=amean)
daply(data,.(sex),.fun=amean)
daply(data,.(age,sex),.fun=amean)
daply(data,.(sex,age),.fun=amean)
ddply(data,.(sex),.fun=amean)
dlply(data,.(sex),.fun=amean)
#
#
#l*ply基本用法
#l*ply(.data, .fun, ..., .progress = "test")
##数据集
a=c(1,2,3,4,1,5,7,8,9,4,2)
b=c(1,2,5,7,6,4,8,7)
c=c(4,8,9,1,2,3,1)
list=list(a,b,c);list
##用法
llply(list,mean)
laply(list,mean) #array横着
ldply(list,mean) #dataframe竖着，且会自动调节rownames(1,2,3...)和colnames(V1,V2...)


#splat()：与使用众多的参数不同，该函数把原函数中多个参数打包为一个list作为参数， 然后输出新的函数 
head(mtcars,5)
hp_per_cyl <- function(hp, cyl, ...) hp / cyl 
splat(hp_per_cyl)(mtcars[1,]) 
splat(hp_per_cyl)(mtcars)

#each()：用一系列的函数作用在输入的数据上，并返回一个已命名的向量 
a=c(1,2,3,4,1,5,7,8,9,4,2) 
each(min,max,mean)(a) 
each(length,mean,var)(rnorm(100)) 
fun<-function(x)c(min = min(x), max = max(x),mean=mean(x));fun(a)

#colwise()：把作用于数据框行向量的函数（如mean，median）转化为作用于数据框列向量的函数，
            #可以结合base R 的函数使用，与d*ply一起使用时十分方便。
head(baseball,5)
nmissing<-function(x)sum(is.na(x));colwise(nmissing)(baseball)
f<-colwise(nmissing);f(baseball) #colwise将nmissing包装成一个新的函数
###按year进行分组
ddply(baseball,.(year),colwise(nmissing)) 
ddply(baseball,.(year),colwise(nmissing,.(sb,cs,so)))
ddply(baseball,.(year),colwise(nmissing,c("sb","cs","so"))) 
ddply(baseball,.(year),colwise(nmissing,~sb+cs+so))

#arrange()：按照列给数据框排序
#arrange(df, .(var1), .(var2)…)：df为数据框；.var是要按照排序的变量
#例子：让mtcars数据集里面的车子按照气缸和排量排序 
mtcars 
arrange(mtcars,cyl,disp) 
arrange(mtcars,disp,cyl)
cars<-cbind(vehicle=rownames(mtcars),mtcars)  #然后按上述操作

#rename()：通过名字修改名字，而不是根据它的位置 
mtcars
detach("package:dplyr")             #!!!请注意：dplyr和plyr的功能有冲突#
rename(mtcars,c(carb="c", wt="b"))  #pylr中rename用法 c(oldneme="newname",...)
mtcars %>% rename(a = cyl, b = hp)  #dplyr中rename用法 newname=oldname

#count(df， vars=NULL, wt_var=NULL) 数变量中观测值出现的个数
  # df是要处理的数据框
  # vars是指定要进行数数的变量
  # wt_var是指定作为权重的变量
mtcars
count(mtcars,"gear")  #plyr要打引号，结果会返回一个freq  c("A","b"...)
subset(count(mtcars,"gear"), freq > 10)
detach("package:plyr")
library(dplyr)
fun<-function(a)sum(a[,2])
mtcars %>% filter(wt >=3, carb > 4) %>% fun() #dplyr
detach("package:dplyr");library(plyr)

#match_df():从一个数据框中提取与另一个数据框中相同的行 
##match_df(x, y, on=NULL) 
  # x是原始的需要提取的数据框
  # y是用来找出相同行的另一个数据框
  # on是指定 要来比对的变量，默认为比较两个数据框中所有的变量
#将baseball中id数重复的超过25次的提取出来
count<-subset(count(baseball, "id"), freq > 25)
count
res<-match_df(baseball, count, on="id");res
library(plyr)
detach("package:plyr");library(dplyr)
data
#dplyr的使用：
a<-data %>% group_by(id) %>% count() %>% filter(n>25);inner_join(a, data) %>% View() 

#join()函数
#join(x, y, by=NULL, type=“left”, match=“all”)
  # x，y是两个数据框
  # by是指定要联合的变量默认值为所有的变量
  # type是指定联合的方式

x1<-c(1,2,3,4)
x2<-c(5,6,7,8) 
x<-data.frame(x1,x2);x
y1<-x1*10
y<-data.frame(y1,x2);y 
y[,2]=c(1,2,6,7);y
x;y
join(x,y,by="x2")
join(x,y,"x2",type="inner") 
join(x,y,"x2",type="right") 
join(x,y,"x2",type="full")
y[,2]=c(6,6,6,6);x;y 
join(x,y,"x2",type="inner",match="all") 
join(x,y,"x2",type="inner",match ="first")
