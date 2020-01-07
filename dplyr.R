install.packages("nycflights13")
detach("package:nycflights13")
detach("package:hflights")
remove.packages("nycflights13")
remove.packages("hflights")
library(hflights)
(.packages())
library(nycflights13)
library(dplyr)
#flights的数据
flights

#============对列的操（选择和重命名）====================
#选择指定列
flights %>% select(carrier,flight)
#隐藏指定列
flights %>% select(-month,-day)
#隐藏范围内的列
flights %>% select(-(dep_time:arr_delay))
#影藏含某个关键词的列
flights %>% select(-contains("time"))
#使用一个字符向量来选择列
cols<-c("carrier","flight","tailnum")
flights %>% select(one_of(cols))
#选择某列更换其名字，不显示其他列(提取tailnum将其rname为tail，不显示其他列)
flights %>% select(tail = tailnum)
#选择谋列更换其名字，显示其他列
flights %>% rename(tail = tailnum)
flights %>% rename(MONTH = month, DAY = day)
subset(flights, Cancelled==1) %>% View()
                                                                                                                                                                
#===========对行的操作(filter,between,slice,sample_n,top_n,distinct)==
#选择满足条件的某些行
flights %>% filter(dep_time >= 600, dep_time <= 605)
flights %>% filter(between(dep_time, 600, 605)) 
flights %>% filter(!is.na(dep_time))   #过滤掉NA
#通过位置选择某些行
flights %>% slice(1000:1005)
flights %>% group_by(month, day) %>% slice(1:3)  #group后选择每个group的第一行到第三行
flights %>% group_by(month, day) %>% sample_n(3) #每个group随机选三个数,注意group:先按第一个参数group再按第二个参数group
flights %>% group_by(month, day) %>% top_n(3, dep_delay) #每个group调出最大的3列但是没有排序
flights %>% group_by(month, day) %>% top_n(3, dep_delay) %>% arrange(desc(dep_delay)) #排序
#选择独一无二的行
flights %>% select(origin, dest) %>% unique() #两个组合在一起是独一无二的
flights %>% select(origin, dest) %>% distinct() #官方说比unique效率更高
flights %>% select(origin, dest) %>% distinct #简易写法

#==========添加新的变量:mutate, treatmute, add_rownames============
flights %>% mutate(speed = distance/air_time*60)  #保留所有列
flights %>% transmute(speed = distance/air_time*60) #只保留新添加的
mtcars %>% head #看一眼mtcars
mtcars %>% add_rownames("model") %>% head()  #把行名添加到一个向量
mtcars %>% tbl_df()  #去除行名

#==========形成group然后计算=================
flights %>% group_by(month) %>% summarise(cnt = n()) #
flights %>% group_by(month) %>% tally()
flights %>% count(month)
#排序
flights %>% group_by(month) %>% summarise(cnt = n()) %>% arrange(desc(cnt))
flights %>% group_by(month) %>% tally(sort=TRUE)
flights %>% count(month,sourt=TRUE)
#计算
flights %>% group_by(month) %>% summarise(dist = sum(distance))
flights %>% group_by(month) %>% tally(wt = distance)
flights %>% count(month, wt = distance)
flights %>% group_by(month) %>% group_size() #返回的是一个向量 
flights %>% group_by(month) %>% n_groups() #看一波有多少个组
flights %>% group_by(month, day) %>% summarise(cnt = n()) %>% arrange(desc(cnt)) %>% print(n = 40)  #排序 print(n = #):显示#行

#=========创建data frames:data_frame========
data_frame(a = 1:6, b = a*2, c = 'string', 'd+e' = 1) %>% glimpse  #glimpse类似于str
data.frame(a = 1:6, c = 'string', 'd+e' =1)   #b不能定义

#===============joining(merging)tables======
a<-data_frame(color = c("green","yellow","red"), num = 1:3)
b<-data_frame(color = c("green","yellow","pink"),size = c("S","M","L"));a;b
inner_join(a, b)         #只显示公有的观测
full_join(a, b)          #合并所有观测，缺省值NA表示
left_join(a, b)          #只显示a中的观测，缺省值NA表示（含b中的变量）
right_join(a, b)         #只显示b中的观测，缺省值NA表示（含a中的变量）
semi_join(a, b)          #显示a中数据，再显示和b公有的观测
anti_join(a, b)          #显示a中数据，去掉和b公有的观测
b<-b %>% rename(col = color) #将b中color更换为col
inner_join(a, b, by = c("color"="col"))    #按照a中的color，b中的col来merge

#===========print, view==============
flights %>% print(n = 15)   #显示15行
flights %>% print(n = Inf)  #显示所有行，小心死机
flights %>% print(width = Inf) #显示所有列
flights %>% View()  #显示所有列和1000行
options(dplyr.width = Inf, dplyr.print_min = 6)  #自定义
options(dplyr.width = NULL, dplyr.print_min = 10)
''

#=====R的基本方法和dplyr的比较
(.packages())
detach("package:nycflights13")
detach("package:dplyr")
install.packages("hflights")
library(dplyr)
library(hflights)
help(package="dplyr")

head(hflights)
flights<-tbl_df(hflights)
head(flights)
data.frame(head(flights))
flights
flights[flights$Month==1 & flights$DayofMonth==1, ]
subset(flights,Month =1, DayofMonth =1)
filter(flights, Month == 1, DayofMonth == 1)
filter(flights, UniqueCarrier =="AA" | UniqueCarrier == "UA") %>% print(n = 400)
filter(flights, UniqueCarrier %in% c("AA","UA")) %>% print(n = 400)

flights[,c("DepTime","ArrTime","FlightNum")]
select(flights, DepTime, ArrTime, FlightNum)
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))

filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)   #推荐下一种写法
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  filter(DepDelay > 60)
flights %>% 
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))


x1<-1:5;x2<-2:6
sqrt(sum((x1-x2)^2))
(x1-x2)^2 %>% sum() %>% sqrt()

flights$Speed<-flights$Distance / flights$AirTime*60
flights[,c("Distance","AirTime","Speed")]
flights<-flights %>% select(-Speed,-speed)
flights %>%
  mutate(Speed = Distance/AirTime*60 ) %>%
  select(Distance, AirTime, Speed)


#base R approaches to calculate the average arrival delay to each destination
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean)) #将Dest变形，然后对Dest所对应的所有ArrDelay的值取平均值
library(reshape2)     #？？？研究一波如何用reshape2做做
a<-with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE))

#grouped by Dest,and then summarise each group by taking the mean of ArrDelay
flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm=TRUE)) 
  
#for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted)

#for each carrier,calculate the minimum and maximum arrival and departure delays
flights %>% 
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm = TRUE), max(., na.rm = TRUE)), 
                 matches("Delay"))

#for each day of the year,count the total number of flights and sort in descending order | alse by tally
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flights_count = n()) %>% 
  arrange(desc(flights_count))
#rewrite more simply with the 'tally' function
flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = TRUE)

#for each destination, count the total number fo flights and the number of distinct planes that flew there
flights %>%
  group_by(Dest) %>%
  summarise(flights_count = n(), plane_count= n_distinct(TailNum))

#for each destination ,show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

#for each carrier,calculate which two days of the year they had their longest departure delays 
#note:smallest (not longset) value is ranked as 1, so you have to use `desc` to rank by largest value
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay))
#rewrite more simply with `top_n` function
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

#for each month, calculate the number of flights and the change from the previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count= n()) %>%
  mutate(change = flight_count - lag(flight_count))
#rewrite more smply with the `tally` function
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))


#==================other useful convenience functions================
#randomly sample a fixed number of rows,without replacement
flights %>% sample_n(10) %>% View()
#view the structure of an object
glimpse(flights)

#connect to the 




























