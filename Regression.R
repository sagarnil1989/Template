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

