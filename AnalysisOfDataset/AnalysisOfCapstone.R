#----library----
library(dplyr)
library(plyr)
library(tidyr)
dataset = read.csv('Dataset//Capstone-sampletelecomfinal.csv',sep = ',')
#----Analysing an overview----
column_name=colnames(dataset)
str(dataset)
summary(dataset$avg6mou)
#---checking target variable distribution----
table(dataset$churn)

#----check missing values----
#checking sum of all na values in dataset
sum(is.na(dataset))#125706
#checking columns where NA could mean a different value
#value of age1 and age2 as zero is NA as customers age cannot be 0
dataset$age1[dataset$age1 == 0] = NA_integer_
dataset$age2[dataset$age2 == 0] = NA_integer_
dataset$ethnic[is.na(dataset$ethnic)] = 'U'
dataset$marital[is.na(dataset$marital)] = 'U'
dataset$hnd_webcap[is.na(dataset$hnd_webcap)]='UNKW'
sum(is.na(dataset))#134434
#column_wise
na_finder_columnwise(dataset)
to_be_dropped_columns<-(filter(na_finder_columnwise(dataset),percentage_of_miss_percolumn>=20))$variable
dataset=select(dataset,-to_be_dropped_columns)
sum(is.na(dataset))#3122
na_finder_columnwise(dataset)
#drop 26 rows with missing values in column-mou_Mean,totmrc_Mean,rev_Range,mou_Range,ovrrev_Mean,rev_Mean,ovrmou_Mean,roam_Mean,da_Mean,da_Range,datovr_Meandatovr_Range 
dataset=filter(dataset,!is.na(mou_Mean))
sum(is.na(dataset))#2779
na_finder_columnwise(dataset)
#dropping 214 rows where value in column forgntvl,mtrcycle,truck,car_buy are missing
dataset=filter(dataset,!is.na(forgntvl))
sum(is.na(dataset))#1805
na_finder_columnwise(dataset)
head(dataset,5)
#taking call on prizm_social_one->Social group letter only refers to Based on degree of population density of area 
#which should be corelated with area or csa: Communications local service area Refers to specific location of the customer, usually indicating city.
table(dataset$area,dataset$prizm_social_one)
table(dataset$prizm_social_one)
#willing create a category 'M' as missing
dataset$prizm_social_one <- as.character(dataset$prizm_social_one)
dataset$prizm_social_one[is.na(dataset$prizm_social_one)] = 'M'
dataset$prizm_social_one <- factor(dataset$prizm_social_one)
sum(is.na(dataset))#1805
na_finder_columnwise(dataset)
#390 values missing for avg6mou and avg6qty
table(dataset$avg6mou)
sagar=filter(dataset,is.na(avg6mou)) 
table(sagar$churn)
ggplot(data=dataset, aes(x = avg6mou, fill = factor(churn)))+
  geom_histogram(binwidth = 500, position = "dodge")
  
#all the avg6mou and avg6qty with NA are filled with avg3mou and avg3qty values
dataset$avg6mou[is.na(dataset$avg6mou)] = dataset$avg3mou
dataset$avg6qty[is.na(dataset$avg6qty)] = dataset$avg3qty
sum(is.na(dataset))#180
na_finder_columnwise(dataset)
#hnd_price
table(dataset$hnd_price,dataset$churn)
sagar=filter(dataset,is.na(hnd_price)) 
table(sagar$churn)
ggplot(data=dataset, aes(x = hnd_price, fill = factor(churn)))+
  geom_histogram(binwidth = 10, position = "dodge")
#As hnd_price is a categirical variable with mode being '149.9899902'
#I am putting all NA values as mode
unique(dataset$hnd_price)
dataset$hnd_price[is.na(dataset$hnd_price)] = 149.9899902
sum(is.na(dataset))#51
na_finder_columnwise(dataset)










#When x is descrete
ggplot(data=dataset, aes(x = income, fill = factor(churn)))+
  geom_bar(stat='count', na.rm = FALSE,position='dodge') +
  labs(x = 'Income', labels=income) 
sagar=dataset=filter(dataset,!is.na(mou_Mean))







#lets see the impact of churn on ethnic/marital/age1
table(dataset$forgntvl,dataset$churn)
dataset=filter(dataset,!is.na(marital))
#lets check avg6mou and avg6qty's missing value
sagar=filter(dataset,is.na(age1))
table(dataset$income)
max(dataset$income)
min(dataset$income)
