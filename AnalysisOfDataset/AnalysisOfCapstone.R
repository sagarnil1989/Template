dataset = read.csv('Dataset//Capstone-sampletelecomfinal.csv',sep = ',')
column_name=colnames(dataset)
dataset()
sum(is.na(dataset))
#----check missing values----
colSums(is.na(dataset))
summary(dataset$churn)
library(plyr)
#----check frequncy of churn----
count(dataset, 'churn')
#----drop CustomerID column----
library(dplyr)
dataset=select(dataset,-Customer_ID)

model=glm(formula = churn~.,
          data=dataset,
          familily=binomial
          )
