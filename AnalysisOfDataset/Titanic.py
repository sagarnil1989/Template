# -*- coding: utf-8 -*-
#Analysisig=ng Titanic Data
# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#Importing Dataset
data = pd.read_csv('Dataset//titanic//train.csv')
#checking for null value
data.isnull()
data.describe()
