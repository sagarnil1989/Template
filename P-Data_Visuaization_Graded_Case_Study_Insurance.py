#Analysis of Data_Visualization_Graded_Case_Study_Dataset_Insurance.xlsx
#Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sb
# Importing the dataset of xlsx format
xls = pd.ExcelFile('Dataset//Data Visualization Graded Case Study Dataset.xlsx')
data = pd.read_excel(xls, 'Data')
data_desc = pd.read_excel(xls, 'Desc')
data.dtypes
data.head()
#Cleaning up the independent varibales
#Checking for missing values
#converting PolicyNumber to String
data.isnull().sum()# No missing value
#box plot with age on x asix and premium on y axis
ax = sb.boxplot(x='Age', y='Premium', data=data, color='yellow')
ax = sb.boxplot(x='Age', y='IDV', data=data, color='yellow')
#All the group has same mean for Premium so it cannot be differenciated
#All the 52 rows which has value True are mapped to 30 - 40 as its the most frequeny one
data['Age']=data['Age'].replace(True,'30-40')
data['Age']=data['Age'].replace(" ","")

sagar="30 - 40"
sagar=sagar.replace(" ","")

data.columns
data.columns = data.columns.str.strip()
#check the frequency of each value in Age column
data['Age'].value_counts()

data['Age']=data['Age'].replace(" ",'')
#box plot with age on x asix and premium on y axis
ax = sb.boxplot(x='Age', y='Premium', data=data, color='yellow')
#All the group has same mean for Premium so it cannot be differenciated
#All the 52 rows which has value True are mapped to 30 - 40 as its the most frequeny one
data['Age']=data['Age'].replace(True,'30-40')

#Replacing all TRUE value in Age as 18-60
data['Age']=data['Age'].replace('Missing','30-40')
data[['Age1','Age2']] = data.Age.str.split("-",expand=True,)
data['Age1']=pd.to_numeric(data['Age1'])
data['Age2']=pd.to_numeric(data['Age2'])
data['Age']=(data['Age1']+data['Age2'])/2
data=data.drop(['Age1','Age2'], axis=1)
#Column1: Policy number is a uniques identifier so it will have no dependecy on our analysis
data=data.drop(['Policy Number'], axis=1)
data.dtypes
#Age-histogram
plt.hist(data.Age, bins = 10, alpha = 0.5, color = "blue", linewidth=3,orientation = 'vertical')
print(plt.style.available)
