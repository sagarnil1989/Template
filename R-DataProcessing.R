#----Taking care of missing data----
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        dataset$Salary)

#----Encoding categorical data----
#Label encoder
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))
dataset$Purchased = factor(dataset$Purchased,
                           levels = c('No', 'Yes'),
                           labels = c(0, 1))
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

#----Encoding the target feature as factor----
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))



# EDA ---------------------------------------------------------------------

#EDA in R Intution----
#good data: 
#without missing vakues; 
#without outliner
#without duplicate,incomplete,incorrect,invalid values
#covers entire population - check for data suffiency
#accuracy completeness and relevence
#compare summary statisctics with data dictionary
#cross-check table for incorrect value
#Treatment of Missing value
#Impute
#Ignore- delete the row with mising values
#Delete column having missing values
#Treatment of outliners
#replace with maximum or minimum value
#replace with mean when data is screwed
#replace with median when data is non-screwed/have outliner
#Task in EDA
#Transformation of variable
#Seperate numeric and non-numeric features
#Univariant Analysis-1 var at a time, Bivariant Analysis,Multivaraite
#Derived variabbles
#Dummy variable
#cross tabulation
#correlation


#EDA in R Code----
dataset = read.csv('Dataset//Salaries.csv', sep = ',', stringsAsFactors = FALSE)#Data Analysis
dataset = read.csv('Dataset//Salaries.csv', sep = ',')#Data Analysis
sum(is.na(dataset))
str(dataset)
dataset$lgID=as.character(dataset$lgID)
#unique value in column
unique(dataset$yearID)
table(dataset$lgID)/ nrow(dataset)
prop.table(table(dataset$teamID))#percentage of every category
sort(table(dataset$teamID))
plot(sort(table(dataset$teamID)))
par(bg="white")
barplot(sort(table(dataset$teamID)),main="count by team",xlab="team name",ylab="Number",
        col=c("red","green","blue"))
#to see more than 1 plot in plotting area
par(mfrow=c(1,1))
#Bivarient
table(dataset$teamID,dataset$lgID)
table(dataset$teamID,dataset$yearID)
barplot(sort(table(dataset$teamID,dataset$lgID)),main="count by team",xlab="team name",ylab="Number",
        col=c("red","green"))

#salary less than mean
salaries_1=subset(dataset,dataset$salary<mean(dataset$salary))
#missing vale treatment
data("airquality")
head(airquality)
is.na(airquality$Ozone)
which(is.na(airquality$Ozone))
colSums(is.na(airquality))
#Ignore all missing value
airquality_1=na.omit(airquality)
mean(airquality$Ozone, na.rm = TRUE)
airquality$Ozone[is.na(airquality$Ozone)]=mean(airquality$Ozone, na.rm = TRUE)
#check mice func in mice package
#na.roughfix in random forest

data("iris")
table(iris$Species)
iris$setosa=ifelse(iris$Species=="setosa",1,0)
iris$versicolor=ifelse(iris$Species=="versicolor",1,0)
iris$virginica=ifelse(iris$Species=="virginica",1,0)
library(dummies)
temp1=dummy(iris$Species)
iris=cbind(iris,temp1)
#Outliner
#Boxplot, FiveNumberSummary, IQR
boxplot(dataset$salary)
IQR(dataset$salary)
head(mtcars)
IQR(mtcars$mpg)

