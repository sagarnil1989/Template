import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#-----------------------------------------------------------------------------
# Predicting the Test set results
y_pred = regressor.predict(X_test)
#-----------------------------------------------------------------------------
# Fitting Simple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)
#-----------------------------------------------------------------------------
# Fitting Multiple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)
#-----------------------------------------------------------------------------
# Building optimal model using backward elimination
#Step 1: Select a significance level to stay in the model(0.05)
#Step 2: Fit the full model with all predictors
#Step 3: Consider the predictor with highest P-value. If P>SL, go to STEP 4, otherwise goto FIN
#Step 4: Remove the predictor
#Step 5: Fit model without this variable
#In this model constant is zero so have to initialize x0 as 1
import statsmodels.formula.api as sm
X=np.append(arr=np.ones((50,1)).astype(int),values=X, axis=1)# adding array of 1s in the first column
#Step1:
X_opt= X[:,[0,1,2,3,4,5]]
regressor_OLS=sm.OLS(endog=y, exog=X_opt).fit()
regressor_OLS.summary()
#Step: Removing x2 with maximum p-value
X_opt= X[:,[0,1,3,4,5]]
regressor_OLS=sm.OLS(endog=y, exog=X_opt).fit()
regressor_OLS.summary()
#Removing x1 with maximum p-value
X_opt= X[:,[0,3,4,5]]
regressor_OLS=sm.OLS(endog=y, exog=X_opt).fit()
regressor_OLS.summary()
#Removing x2 with maximum p-value
X_opt= X[:,[0,3,5]]
regressor_OLS=sm.OLS(endog=y, exog=X_opt).fit()
regressor_OLS.summary()
#Removing x2 with p-value 0.06
X_opt= X[:,[0,3]]
regressor_OLS=sm.OLS(endog=y, exog=X_opt).fit()
regressor_OLS.summary()
#-----------------------------------------------------------------------------
# Fitting Polynomial Regression to the dataset
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree = 2)
X_poly = poly_reg.fit_transform(X_train)
poly_reg.fit(X_poly, y_train)
from sklearn.linear_model import LinearRegression
lin_reg_2 = LinearRegression()
lin_reg_2.fit(X_poly, y_train)
y_pred = lin_reg_2.predict(X_poly)
#-----------------------------------------------------------------------------
# Fitting the SVR Model to the dataset ( Feature Scaling is required)-check feature scaling
from sklearn.svm import SVR
regressor=SVR(kernel='rbf', gamma='auto')
regressor.fit(X,y)
# Predicting a new result
y_pred = sc_y.inverse_transform(regressor.predict(sc_X.transform(np.array([[6.5]]))))
#transform func need array
#-----------------------------------------------------------------------------
# Fitting Decision Tree Regression to the dataset
from sklearn.tree import DecisionTreeRegressor
regressor = DecisionTreeRegressor(random_state = 0)
regressor.fit(X, y)
#-----------------------------------------------------------------------------
# Fitting Random Forest Regression to the dataset
from sklearn.ensemble import RandomForestRegressor
regressor = RandomForestRegressor(n_estimators = 10, random_state = 0)
regressor.fit(X, y)