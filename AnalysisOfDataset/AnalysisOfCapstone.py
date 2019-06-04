#Analysis of Capstone-sampletelecomfinal.csv
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#Importing Dataset
dataset = pd.read_csv('Dataset//Capstone-sampletelecomfinal.csv')
dataset.dtypes
dataset.columns
#check missing values
dataset.isnull().sum()
#check frequncy of churn
dataset.churn.value_counts()
#drop CustomerID column
dataset=dataset.drop('Customer_ID',axis=1)
