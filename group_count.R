#===分组计算的方法===
#
#对年份月份进行分组计算AirTime的平均值
#第一种：for循环
library(nycflights13)
library(dplyr)
flights %>% View()
df<-flights
df$Year_Month <- factor(paste(df$Year, df$Month, sep = "-" ))
date <- c()
Time_mean <- c()

for (i in unique(df$Year_Month)){
  
  tmp_df <- df[df$Year_Month == i,]   # 提取指定年月的所有行
  tmp_mean <- mean(tmp_df$AirTime, na.rm = T)
  date <- c(date, i)
  Time_mean <- c(Time_mean, tmp_mean)
  
}
res <- data.frame(date=date, Time_mean=Time_mean);res
#
#第二种：split-lapply-do.call
df$Year_Month <- factor(paste(df$Year, df$Month, sep = "-" ))
df_list <- split(df, f=df$Year_Month)         #按照Year_Month的值拆分成对应列表
temp_mean_list <- lapply(df_list, function(x) mean(x$AirTime, na.rm = T))
temp_mean_list
res<-do.call(rbind, temp_mean_list) #do.call:将一个列表的值按行排列
res<-as.data.frame(res)
#
#第三种方法：split-sapply
df$Year_Month <- factor(paste(df$Year, df$Month, sep = "-" ))
df_list2 <- split(df, f=df$Year_Month)
temp_mean_list2 <- sapply(df_list2, function(x) mean(x$AirTime, na.rm = T) )
glimpse(temp_mean_list2)
#
#第三种方法：dplyr
df %>%
  group_by(Year, Month) %>% 
  summarise(Time_mean = mean(AirTime, na.rm = TRUE)) %>%
  View()
#
#第四种方法：aggregate
out <- aggregate(df$AirTime, by=list(df$Year, df$Month), FUN=mean, na.rm=TRUE);out
res<-aggregate(AirTime~Year+Month, flights, mean);res


