#--------R Template for Reading csv----
#dataset<-read.csv("Dataset//marketing_dataset.csv",sep=";",header = TRUE)
#dataset<-read.csv('Dataset//Data.csv')
#dataset = read.csv('Dataset//Salary_Data.csv')
#dataset = read.csv('Dataset//50_Startups.csv')
#dataset = read.csv('Dataset//Position_Salaries.csv')
#dataset = dataset[2:3]
#dataset = read.csv('Dataset//Social_Network_Ads.csv')
#dataset = dataset[3:5]
#dataset = read.csv('Dataset//Market_Basket_Optimisation.csv', header = FALSE)
#for reading a sparce matrix
install.packages('arules')
library(arules)
dataset = read.transactions('Dataset//Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = TRUE)

# -------Splitting the dataset into the Training set and Test set----
# install.packages('caTools')
library(caTools)
set.seed(123)#random state in python
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


#------- Feature Scaling----------------
training_set[, 2:3] = scale(training_set[, 2:3])
test_set[, 2:3] = scale(test_set[, 2:3])

training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

