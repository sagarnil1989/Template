#Analysising Titanic Dataset
library(gains)
library(dplyr)
library(irr)
library(caret)
library(ggplot2)
train_data = read.csv('Dataset//Titanic//train.csv', header = TRUE)
test_data = read.csv('Dataset//Titanic//test.csv', header = TRUE)
data=bind_rows(train_data,test_data)
#Treating missing values
str(data)
#There are only 177 datasets in Age column out of 891- arround 20%
#Cannot neglect this column need to find a way depending on categories and anotations in name like Mr,Ms,Master
#Lets create meaning data out of Name
data$Title=gsub('(.*, )|(\\..*)', '', data$Name)
