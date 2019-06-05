dataset = read.csv('Dataset//Capstone-sampletelecomfinal.csv',sep = ',')
#----Analysing an overview----
column_name=colnames(dataset)
str(dataset)
sum(is.na(dataset))
#----check missing values----
col_na_val=(colSums(is.na(dataset)))
row_na_val=(rowSums(is.na(dataset)))
typeof(col_na_val)
col_list=list(col_na_val)
summary(dataset$churn)
#wrkwoman has 11590 missing value out of 13259=87%
#solflag has 12999 missing values out of 13259=98%
#retdays has 12825 missing values out of 13259=97%
#proptype has 9432 missing values out of 13259=71%
#div_type has 10782 missing values out of 13259=81%
#cartype has 9010 missing values out of 13259=81%
dataset=select(dataset,-c(wrkwoman,solflag,retdays,proptype,div_type,cartype))
#occu1~9693
#children~8704
#numbcars~6492
dataset=select(dataset,-c(occu1,children,numbcars))
#mailordr~8426
#dwllsize~4099
#mailresp~8235
dataset=select(dataset,-c(mailordr,dwllsize,mailresp))
#dwlltype could be significant IDV but with 4099 missing value it had to be dropped
#lets see its impact on chrun rate
ggplot(data=dataset, aes(x = dwlltype, fill = factor(churn)))+
  geom_bar(stat='count', na.rm = TRUE,position='dodge') +
  labs(x = 'dwlltype') 
#But anyways lets drop it
#Na value reduced to 8445
dataset=select(dataset,-c(dwlltype))
library(plyr)
#----check frequncy of churn----
table(dataset$churn)
#count(dataset, 'churn')
#----drop CustomerID column----
library(dplyr)
dataset=select(dataset,-Customer_ID)
#----Analysing each categorical IV with respect to churn----
#----Mean number of monthly minutes of use----
#boxplot

plot=hist(dataset$mou_Mean,breaks = seq(0,15000,by=100),xlim = c(0,2000))

ggplot(data=dataset, aes(x = mou_Mean, fill = factor(churn)))+
  scale_x_continuous(limits = c(0,2000))+
  scale_y_continuous(limits = c(0,10))+
  geom_bar(stat='count', na.rm = TRUE,position='dodge',width=100) +
  labs(x = 'Family Size') 

#----active subscribersin family----
MAX=max(dataset$mou_Mean,na.rm=TRUE)
table(dataset$churn, dataset$actvsubs)
#----Logical Regression on Churn as target variable---
