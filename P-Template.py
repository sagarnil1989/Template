# -*- coding: utf-8 -*-
# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#-----------------------------------------------------------------------------
# Importing the dataset
#dataset = pd.read_csv('Dataset//marketing_dataset.csv', delimiter = ';', header=0)
#data=pd.read_csv('Dataset//Data.csv') #Single Linear Regression
#dataset = pd.read_csv('Dataset//50_Startups.csv') #Multiple Linear Regression
#dataset = pd.read_csv('Dataset//Position_Salaries.csv') #Single Polynomial Regression
dataset = pd.read_csv('Dataset//Social_Network_Ads.csv') #Logistic Regression
#-----------------------------------------------------------------------------

# If we are using supervised model
#X = pd.DataFrame(dataset.iloc[:,1:2].values)
#y = pd.DataFrame(dataset.iloc[:,2].values)
X = dataset.iloc[:, [2, 3]].values
y = dataset.iloc[:, 4].values

#-----------------------------------------------------------------------------
# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 0)


X_train=X
y_train=y

#-----------------------------------------------------------------------------
# Feature Scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
#sc_y only used for continuor=s values of y
sc_y = StandardScaler()
y_train = sc_y.fit_transform(y_train.reshape(-1,1))