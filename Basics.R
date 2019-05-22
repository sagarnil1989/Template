#Basic R
is.vector(c(1,2,3,4,5))
#read csv
data1<-read.csv("Dataset//customers.csv")

#Some import functions also generate lists: Mostly functions that work with web objects like JSON/XML
library(jsonlite)

#Lists are not only encountered while importing data but also when we work with machine learning algorithms
#linearmodel function do not know yet
model1<-lm(data1$city~data1$state)
