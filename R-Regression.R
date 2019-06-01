#----Fitting Simple Linear Regression to the Training set----
regressor = lm(formula = Profit ~ YearsExperience,
               data = training_set)


#----Predicting the Test set results(Linear Regression)----
y_pred = predict(regressor, newdata = test_set)


#----Fitting Multiple Linear Regression to the Training set----
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = training_set)
regressor = lm(formula = Profit ~ .,
               data = training_set)
regressor = lm(formula = Profit ~ R.D.Spend,
               data = training_set)
# Building optimal model using backward elimination
#Step 1: Select a significance level to stay in the model(0.05)
#Step 2: Fit the full model with all predictors
#Step 3: Consider the predictor with highest P-value. If P>SL, go to STEP 4, otherwise goto FIN
#Step 4: Remove the predictor
#Step 5: Fit model without this variable
#In this model constant is zero so have to initialize x0 as 1

#Step1:
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,data = training_set)
summary(regressor)
#Step: Removing State with maximum p-value
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend ,data = training_set)
summary(regressor)
#Removing x1 with maximum p-value
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend, data = training_set)
summary(regressor)
#Removing Marketing.Spend with p-value 0.07
regressor = lm(formula = Profit ~ R.D.Spend, data = training_set)
summary(regressor)


#----Fitting Polynomial Regression to the dataset----
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula = Salary ~ .,
              data = dataset)
#----Predicting a new result with Polynomial Regression----
predict(poly_reg, data.frame(Level = 6.5,
                             Level2 = 6.5^2,
                             Level3 = 6.5^3,
                             Level4 = 6.5^4))

#----Fitting SVR to the dataset----
# install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ .,
                data = dataset,
                type = 'eps-regression',
                kernel = 'radial')
# Predicting a new result
y_pred = predict(regressor, data.frame(Level = 6.5))
#----Fitting Decision Tree Regression to the dataset----
# install.packages('rpart')
library(rpart)
regressor = rpart(formula = Salary ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 1))

# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Level = 6.5))


#----Fitting Random Forest Regression to the dataset----
install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor = randomForest(x = dataset[-2],
                         y = dataset$Salary,
                         ntree = 500)

# Predicting a new result with Random Forest Regression
y_pred = predict(regressor, data.frame(Level = 6.5))


#----From Jigsaw Limear Regression----
#----Library----
data<-read.csv("Dataset//DirectMarketing.csv")
library(dplyr)
library(ggplot2)
library(car)
head(data)
#----Do exploratory analysis----#
plot(data$Age,data$AmountSpent,col="red")

#----Checking each variable one by one----
#Combine the Middle and Old levels together as mean and SD almost simlar seen from boxplot
data$Age1<-ifelse(data$Age!="Young","Middle-Old",as.character(data$Age))
data$Age1<-as.factor(data$Age1)
summary(data$Age1)
plot(data$Age1,data$AmountSpent)
plot(data$Gender,data$AmountSpent,col="red")
summary(data$OwnHome)
plot(data$OwnHome,data$AmountSpent,col="red")
summary(data$Married)
plot(data$Married,data$AmountSpent,col="red")
summary(data$Location)
plot(data$Location,data$AmountSpent,col="red")
summary(data$Salary)
#plot scatter plot as default for contibuous variable
plot(data$Salary,data$AmountSpent)#Might be heteroescadasticity
summary(data$Children)
data$Children<-as.factor(data$Children)
plot(data$Children,data$AmountSpent,col="red")
#grouping people with 2-3 childer as single group as they have similar mean and similar SD
data$Children1<-ifelse(data$Children==3|data$Children==2,"3-2",as.character(data$Children))
data$Children1<-as.factor(data$Children1)
summary(data$Children1)
plot(data$Children1,data$AmountSpent,col="red")
summary(data$History)
#Impute Missing values
tapply(data$AmountSpent,data$History,mean)
#1st param- data to be worked on;2nd param- groupby parameter
ind<-which(is.na(data$History))
mean(data[ind,"AmountSpent"])
data%>%filter(History=="Medium")%>%select(AmountSpent)->Amt_M
p<-ggplot(data[ind,],aes(x=AmountSpent))
q<-ggplot(Amt_M,aes(x=AmountSpent))
p+geom_histogram()
q+geom_histogram()
#Create a category called missing
data$History1<-ifelse(is.na(data$History),"Missing",as.factor(data$History))
data$History1<-as.factor(data$History1)
summary(data$History1)
data$History1<-factor(data$History1,labels=c("High","Low","Medium","Missing"))
summary(data$Catalogs)
data1<-data[,-c(1,7,8)]
mod1<-lm(AmountSpent~.,data=data1)
summary(mod1)
#----Creating Linear Regression model----
mod2<-lm(formula = AmountSpent ~ Gender + Location + Salary + Catalogs + Children1 + History1, data = data1)
summary(mod2)
summary(data1)
#----Remove insignificant variabes----
mod3<-lm(formula = AmountSpent ~ Location + Salary + Catalogs + Children1 , data = data1)
summary(mod3)
#----Create dummy variables----
data1$Male_d<-ifelse(data1$Gender=="Male",1,0)
data1$Female_d<-ifelse(data1$Gender=="Female",1,0)
data1$Missing_d<-ifelse(data$History1=="Missing",1,0)
data1$Low_d<-ifelse(data$History1=="Low",1,0)
data1$Med_d<-ifelse(data$History1=="Medium",1,0)
data1$High_d<-ifelse(data$History1=="High",1,0)
mod3<-lm(formula = AmountSpent ~ Male_d + Location + Salary + Catalogs + Children1+Med_d+Low_d , data = data1)
summary(mod3)
mod4<-lm(formula = AmountSpent ~ Location + Salary + Catalogs + Children1+Med_d+Low_d, data = data1)
summary(mod4)
#----Signs----
tapply(data$AmountSpent,data$History,mean)
data1%>%filter(History1!="Medium",History1!="Low")%>%summarize(Mean=mean(AmountSpent)) #inline
tapply(data1$AmountSpent,data1$Location,mean) #inline

#----Assumption checks-----
hist(mod4$residuals)
qqPlot(mod4$residuals)
#Multicollinearity Check
vif(mod4)
#Constant  variance check
plot(mod4$fitted.values,mod4$residuals) #Funnel shape
#----Remidy1: Apply log transform to y variable----
mod5<-lm(formula = log(AmountSpent) ~ Location + Salary + Catalogs + Children1+Med_d+Low_d, data = data1)
summary(mod5)
qqPlot(mod5$residuals)#qqplot looks okay
plot(mod5$fitted.values,mod5$residuals)# Still funnel
summary(mod5)
#----Remidy2: Apply square root transform----
mod6<-lm(formula = sqrt(AmountSpent) ~ Location + Salary + Catalogs + Children1+Med_d+Low_d, data = data1)
summary(mod6)
qqPlot(mod6$residuals)
plot(mod6$fitted.values,mod6$residuals)#Seems okay
vif(mod6)
predicted<-mod6$fitted.values
actual<-sqrt(data1$AmountSpent)
dat<-data.frame(predicted,actual)
p<-ggplot(dat,aes(x=row(dat)[,2],y=predicted))
p+geom_line(colour="blue")+geom_line(data=dat,aes(y=actual),colour="black")

