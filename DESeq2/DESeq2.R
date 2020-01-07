a<-drug_treat_counts
rownames(a)<-a[,1]
a<-a[,-1]
a
condition<-rep(c("em_","e2_"),each=3)
condition<-rep(rep(condition),6)
condition<-condition[c(-36,-33)]
time<-rep(c("2","8","12","16","32","64"),each=6)
time<-time[c(-36,-33)]
time<-factor(time,
             levels=c("2","8","12","16","32","64")
             )
condition<-factor(condition,
                  levels=c("em_","e2_")
                  )
condition
coldata<-data.frame(rownames=colnames(a),time,condition)
coldata$rownames<-as.character(coldata$rownames)
coldata
library(DESeq2)
dds<-DESeqDataSetFromMatrix(a,
                            colData = coldata,
                            design=~time+condition+time:condition)
dds$group<-factor(paste0(dds$time,dds$condition))
design(dds)<-~group
dds<-DESeq(dds)
resultsNames(dds)
results(dds,contrast=c("group","8em_","12em_"))


install.packages("stringr
                 ")
?sapply


x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
lapply(x, quantile, probs = 1:3/4)
sapply(x, quantile)
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
dimnames(x)[[1]]<-letters[1:8]
apply(x, 2, mean, trim = .2)
col.sums <- apply(x, 2, sum)
col.sums
row.sums <- apply(x, 1, sum)
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))
apply(x, 2, sort)
names(dimnames(x)) <- c("row", "col")
x
x3 <- array(x, dim = c(dim(x),3),
            dimnames = c(dimnames(x), list(C = paste0("cop.",1:3))))
identical(x,  apply( x,  2,  identity))
identical(x3, apply(x3, 2:3, identity))



a<-list(1,2,3,4,5,6,7,8)
b<-a*3




?apply
x <- cbind(x1 = 3, x2 = c(4:1, 2:5)) 
dimnames(x)[[1]]<-letters[1:8]
str(x)
type(x)
mode(x)
class(x)
apply(x, 2, mean, trim = .2)
col.sums <- apply(x, 2, sum)
row.sums <- apply(x, 1, sum)

col.sums
row.sums
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))
stopifnot( apply(x, 2, is.vector))

apply(x, 2, sort)
names(dimnames(x)) <- c("row", "col")
x
x3 <- array(x, dim = c(dim(x),3),
            dimnames = c(dimnames(x), list(C = paste0("cop.",1:3))))
x3
identical(x,  apply( x,  2,  identity))
identical(x3, apply(x3, 2:3, identity))

cave <- function(x, c1, c2) c(mean(x[c1]), mean(x[c2]))
apply(x, 1, cave,  c1 = "x1", c2 = c("x1","x2"))


ID<-c(1,1,2,2)
Time<-c(1,2,1,2)
X1<-c(5,3,6,2)
X2<-c(6,5,1,4)
mydata<-data.frame(ID,Time,X1,X2)
mydata
library(reshape2)
md<-melt(mydata,id=c("ID","Time"))
md








