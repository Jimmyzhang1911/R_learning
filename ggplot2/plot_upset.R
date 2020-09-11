source('Utils.R')

# upset图library(ComplexUpset)
upsetdata <- select(upset_data, -Total) 
sample_name <- colnames(upsetdata)[2:5]
upsetdata[2:5] <- upsetdata[2:5] > 0

upset(
  upsetdata,
  sample_name,
  #height_ratio = 0.2, #上下比
  #width_ratio = 0.3, #左右比
  name = 'this is title' #NULL
)
