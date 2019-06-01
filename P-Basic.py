#coding: utf-8
#Pandas datastructures
#Series
#Creating series
#Accessing data in series
#Adding data in a series
#Deleting data from a series
#Changing the dtypes in a series
l1=range(11)
print (list(l1))
#Add one to each element
l1+1
#Write a loop
l2=[]
for l in l1:
    l2.append(l+1)
print (l2)
#List comprehension
[x+1 for x in l1]
#Map
result = map(lambda x:x+1,l1)
print(list(result))
import pandas as pd
from pandas import Series,DataFrame
import numpy as np
#Creating a Series object
#General syntax is:
#s= Series(data,indexindex)
#data:Dictionary, array, scalar
#Series from an array/list
S=Series([1,2,3,4,5])
S
print (S[0])
print (S[2])
print(S.values)
print(S.index)
print (list(S.index))
S=Series([1,2,3,4,5],index=['a','b','c','d','e'])
S
print(S[0])
print(S['a'])
S.index
#Adding one element to the series
S['g']=7
print(S)
#Adding  more than one element to the series
#Use the append method to append a sub series to the bigger series
s=Series([8,9,10],index=['h','i','j'])
S=S.append(s)
S
#Deleting elements from a series
S=S.drop('g')
#More than one element from a series
S=S.drop(['i','j'])
S
#Series from a dictionary
d={'a':3,'b':4}
S1=Series(d)
S1
#We can make changes to a series in place also
S1['a']=4
S1
#Series support vectorization
S+1
S*2
S**2
np.log(S)
S+S1
#Series is built upon numpy arrays, one can efficiently change the dtype of the numpy array and then convert that array into a Series object
SC=Series(['1','2','3','4','5'])
SC
SC.dtype
SC=SC.astype('float64')
SC.dtype
#Corner case
s=Series(['1',2,3,4,np.nan,np.nan])
s=s.astype('int64')
s=s.astype('float64')
type(s)
#DataFrames
#Creating data frames
#Accessing rows and columns of a data frame
#Changing name of a dataframe column
#Basic DataFrame methods
#Changing dtypes of a dataframe column
#When analysing data apart from the ability to work with vectorized data, the ability to work with the tabular data is also required. DataFrames is the tabular datastructure used to work with data.
#Creating a dataframe
#From a dictionary of lists, dictionaries, series
#From a list of dictionaries
d={'Price':[19,22,13,54,65],'Sales':[600,756,587,859,990]}
frame1=DataFrame(d)
print(frame1)
d1={'Price':{'r1':19,'r2':22},'Sales':{'r1':600,'r2':756}}
frame2=DataFrame(d1)
print(frame2)
d2={'Price':Series([19,22,13,54,65]),'Sales':Series([600,756,587,859,990])}
frame3=DataFrame(d2)
print(frame3)

l1=[{'Price':19,'Sales':600,'Qty':30},{'Price':22,'Sales':756,'Qty':65}]
frame4=DataFrame(l1)
print(frame4)
frame3['Sales']
print(frame3['Sales'])
type(frame3['Sales'])
frame3[['Sales','Price']]
print(frame3[['Sales','Price']])
type(frame3[['Sales','Price']])
# Changing names of columns in a DataFrame
frame1
#We can use rename() method to rename a column, rename accepts a dictionary
frame1.rename(columns={'Price':'Base_Price','Sales':'Unit Sales'})
frame1
frame1.rename(columns={'Price':'Base_Price','Sales':'Unit Sales'},inplace=True)
frame1
frame1.columns=['Base_Price','Unit Sales']
frame1
# Basic DataFrame methods
frame3.columns #gives all columns in the dataframe
frame3.head()
frame3.describe()
frame3.info()
frame3.dtypes
#Changing dtypes of a dataframe
#Each column in a dataframe is a series object, we can extract the series object
frame3['Price']=Series(frame3['Price'].values.astype(float))
frame3.dtypes
#A less verbose implementation
frame3['Sales']=frame3['Sales'].astype('float64')
frame3.dtypes
frame5=DataFrame({'col1':['1','2','3','4','5'],'col2':['6','7','8','9','10']})
frame5['col2']=frame5['col2'].astype(np.float)
frame5.dtypes
#loc is label-based, which means that you have to specify rows and columns based on their row and column labels. iloc is integer index based, so you have to specify rows and columns by their integer index like you did in the previous exercise.
#.iloc if you want to positionally index.
print(frame1)
frame1.loc[[3,0]]['Price']
frame3.iloc[[4]]['Price']
df1 = DataFrame({'Price': [14, 32, 43],'Sales': [400, 456, 526]},index=list('abc'))
df1
df1.loc['a']
df1.iloc[0]
df1.loc[['a','c']]
df1.iloc[[0,2]]
#loc and iloc also allow you to select both rows and columns from a DataFrame.
df1.loc[['a', 'c'], 'Price']
df1.iloc[[0, 2]]
dfd.iloc[[0, 2], dfd.columns.get_loc('A')]
dfd.iloc[[0, 2], dfd.columns.get_indexer(['A', 'B'])]
print(df1.iloc[:, 1]) #prints as series
print(df1.loc[:, ['Sales']])
df1.dtypes
print(df1.iloc[:, [1]]) #prints as df
#Create Dataframes from dict
store = ['Walmart','Safeway','Total','Trader_Joe']
sales = [1000,3400,6727,5618]
visitors_per_hr = [139,132,87,73]
Location = ['AL','UT','TX','AR']
list_lab = ['store','sales','visitors_per_hr','Location']
list_cols = [store,sales,visitors_per_hr,Location]
zipped = list(zip(list_lab,list_cols))
print(zipped)
data = dict(zipped)
final = pd.DataFrame(data)
print(final)
# Data Import
import os
os.getcwd()
os.chdir('E:\Python for ML\Data')
# Flat files
# Checking the delimiter
# Checking the header
# Checking how missing values are populated
import pandas as pd
from pandas import Series, DataFrame
import numpy as np
dat=pd.read_csv('sample2.csv',sep=',',header=0)
dat.head()
#We will use pd.read_table() method to do imports
dat1=pd.read_table('sample2.csv',sep=',',header=0)
dat1.head()
dat.dtypes
dat2=pd.read_table('sample1.txt', sep ='\t')
dat2.head()
dat2.dtypes
dat2=pd.read_table('sample1.txt',na_values=['Missing'])
dat2.head()
dat2.dtypes
# Opening Flat files from the web
# Import package
from urllib.request import urlretrieve
# Import pandas
import pandas as pd
# Assign url of file: url
url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'
# Save file locally
urlretrieve(url, 'winequality-red.csv')
import pandas as pd
# Assign url of file: url
url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'
# Read file into a DataFrame: df
df = pd.read_csv(url, sep=';')
# Print the head of the DataFrame
print(df.head())
# Import package
import requests
# Specify the url: url
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
# Packages the request, send the request and catch the response: r
r = requests.get(url)
# Extract the response: text
text = r.text
# Print
print(text)
import json

with open('visa.txt') as json_data:
    d = json.load(json_data)
    print(d)
print (type(d))
import urllib.request, json
with urllib.request.urlopen("http://maps.googleapis.com/maps/api/geocode/json?address=google") as url:
    data = json.loads(url.read().decode())
    print(data)
import pandas as pd
dat=open("F:\\Py\\Data\\visa.txt")
dat=dat.read()
data_json=json.loads(dat)
type(data_json)
data_json.keys()
pd.DataFrame(data_json['data'],columns=[name['label'] for name in data_json['fields']])
[name['label'] for name in data_json['fields']]





