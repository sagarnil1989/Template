# coding: utf-8
import os
import pandas as pd
from pandas import DataFrame
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')
#Dataset
data1=pd.read_csv("Dataset//hrdata.csv")
data2=pd.read_csv("Dataset//MMix.csv")
data3=pd.read_csv("Dataset//iris.csv")
#Basic check
data3.head()
data2.head()
data3.head()
data1.columns
data1.columns = data1.columns.str.strip()
#Univariate Plots
#Histogram
plt.hist(data1.Income, bins = 10, alpha = 0.5, color = "blue", linewidth=3,orientation = 'horizontal')
print(plt.style.available)
# Density
data1.Income.plot('density', ls='--') #style
plt.xlabel("Income")
plt.title("Density Plot for Income")
plt.rcParams['xtick.labelsize']=8
plt.tight_layout()
plt.show()
# Histogram with Density
ax = data1['Income'].plot(kind='hist',color='lightblue',ylim=(0,400))
ax2 = data1['Income'].plot(kind='density',secondary_y=True,color='blue', ax=ax)
ax.set_ylabel('No. of Employees')
ax2.set_ylabel('Density')
#For better pdf plots - https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.norm.html
type(data1['Income'].plot(kind='hist',color='lightblue',ylim=(0,400)))
# Boxplot
plt.boxplot(data1['Income'] ,  patch_artist=True, vert=True)
data3.plot(kind='box',  color = 'red', subplots=True, layout=(2,2), sharex=False)
plt.tight_layout()
plt.show()
ax = sns.boxplot(data=data3, orient="h", palette="Set2")
bp = plt.boxplot(data1['Income'])
bp
a=bp['fliers'][0]
type(a.get_data()[1])
a.get_data()[1]
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(9, 4))
# rectangular box plot
bplot1 = axes[0].boxplot(data['Age'])
# notch shape box plot
bplot2 = axes[1].boxplot(data['Income'])
plt.show()
plt.savefig('matplotlib.png')
# Bar Chart
plt.bar(data3['Species'], data3['Sepal.Length'], width = 0.3, color = 'pink',  align='center')
plt.bar(data3['Species'], data3['Sepal.Width'], width = 0.3, color = 'lightblue',  align='center')
plt.legend(loc=1)
plt.tight_layout()
plt.show()
plt.barh(data['Gender'], data['Income'], color = 'pink')
# Line Plot
plt.plot(data2['NewVolSales'])
plt.xlabel("Week")
plt.ylabel("Volume Sales in thousands")
plt.title("Volume Sales")
plt.plot(data2['NewVolSales'], c = 'M', ls = "--", marker = "s", ms = 6)
plt.xticks(rotation = 'vertical')
plt.xlabel('Volume Sales in 1000 units')
plt.show()
type(plt.subplots())
fig, ax1 = plt.subplots()
ax1.plot(data2['NewVolSales'])
ax1.set_xlabel('time (w)')
# Make the y-axis label, ticks and tick labels match the line color.
ax1.set_ylabel('Volume Sales')
ax2 = ax1.twinx()
ax2.plot(data2['Radio '], 'r')
ax2.set_ylabel('Radio')
fig.tight_layout()
plt.show()
# Bivariate Plots
# Scatter Plot
plt.scatter(x=data['Age'],y = data['Income'], color = "magenta", alpha = 0.5)
plt.title('Relationship Between Age and Income')
plt.xlabel('Age')
plt.ylabel('Income')
# Plots by Group----
# Seaborn for Faceted plots/ Plotting by groups
sns.FacetGrid(col='Department',col_wrap=50,aspect=1.2,size=4,data=data).map(plt.scatter, 'Age', 'Income', s=20).fig.subplots_adjust(wspace=.3, hspace=.2)
sns.FacetGrid(col='Department',col_wrap=25,aspect=.8,size=4,data=data).map(plt.scatter, 'Age', 'Income')
g = sns.FacetGrid(data, col="MaritalStatus", row= "Gender", col_order=["Single", "Married","Divorced"])
g = g.map(plt.hist, "Income", bins=20, color="m")
g
kws = dict(s=50, linewidth=.5, edgecolor="w")
g = sns.FacetGrid(data, col="MaritalStatus", hue="Gender", palette="Set1",hue_order=["Male", "Female"])
g = (g.map(plt.scatter, "Age", "Income", **kws).add_legend())
# Using Subplots for multiple plots----
# Create a figure with 1x2 subplot and make the left subplot active
plt.subplot(1, 2, 1)
# Plot in blue the % of degrees awarded to women in the Physical Sciences
plt.scatter(data['Age'], data['Income'], color='b')
plt.title('Scatter')
# Make the right subplot active in the current 1x2 subplot grid
plt.subplot(1, 2, 2)
# Plot in red the % of degrees awarded to women in Computer Science
plt.boxplot(data['Income'])
plt.title('Boxplot')
# Use plt.tight_layout() to improve the spacing between subplots
plt.tight_layout()
plt.show()
plt.figure(figsize=(8,5))
plt.subplots_adjust(hspace=0.4,wspace=0.4)
plt.subplot(1, 2, 1)
plt.plot(data2['NewVolSales'], c = 'M', ls = "--", marker = "s", ms = 6)
plt.xticks(rotation = 'vertical')
plt.title('Volume Sales in 1000 units')
plt.subplot(1, 2, 2)
plt.scatter(data2['NewVolSales'], data2['Base Price'], color='blue')
plt.title('NewVolSales vs. Base Price')
plt.tight_layout()
plt.show()
# Displaying Images Using Matplotlib----
img = plt.imread('2058.jpg')
print(img.shape)
plt.imshow(img)
plt.axis('off')
plt.show()
