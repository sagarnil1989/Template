#library----
library(dplyr)
library(plyr)
library(tidyr)
library(dummies)
#na_finder_columnwise----
na_finder_columnwise <- function(dataframe) {
  m <- sapply(dataframe, function(x) {
    data.frame(
      no_of_na=sum(is.na(x)), 
      total_rows=length(x), 
      percentage_of_miss_percolumn=sum(is.na(x))/length(x)*100
    )
  })
  d <- data.frame(t(m))
  d <- sapply(d, unlist)
  d <- as.data.frame(d)
  d$variable <- row.names(d)
  row.names(d) <- NULL
  d <- cbind(d[ncol(d)],d[-ncol(d)])
  return(d[order(d$percentage_of_miss_percolumn,decreasing = TRUE), ])
}
#Analysis of Marketing Dataset- Flix bus----
dataset = read.csv('Dataset//marketing_dataset-FlixBus.csv',sep=";",na.strings = "unknown")
#meaningful column name----
names(dataset)[names(dataset) == "default"] = "HasCreditCard"
names(dataset)[names(dataset) == "y"] = "ResponseToCampaign"
#Missing value test----
str(dataset)
sum(is.na(dataset))#929
na_finder_columnwise(dataset)
#age value invalidaity----
max(dataset$age)
min(dataset$age)#valid data
#Omiting all rows with na value  # not the best solution
dataset=na.omit(dataset)
table(dataset$poutcome)

sagar=dummy.data.frame(dataset,drop=TRUE)

