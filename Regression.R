# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Profit ~ YearsExperience,
               data = training_set)

# Fitting Multiple Linear Regression to the Training set
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
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = training_set)
summary(regressor)
#Step: Removing State with maximum p-value
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend ,
               data = training_set)
summary(regressor)
#Removing x1 with maximum p-value
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = training_set)
summary(regressor)
#Removing Marketing.Spend with p-value 0.07
regressor = lm(formula = Profit ~ R.D.Spend,
               data = training_set)
summary(regressor)


# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Visualising the Training set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Training set)') +
  xlab('Years of experience') +
  ylab('Salary')

# Visualising the Test set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Test set)') +
  xlab('Years of experience') +
  ylab('Salary')

