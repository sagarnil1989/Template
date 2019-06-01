import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#-----------------------------------------------------------------------------
# Taking care of missing data
from sklearn.preprocessing import Imputer
imputer = Imputer(missing_values = 'NaN', strategy = 'mean', axis = 0)
imputer = imputer.fit(X[:, 1:3])
X[:, 1:3] = imputer.transform(X[:, 1:3])

from sklearn.impute import SimpleImputer
imp = SimpleImputer(missing_values=np.nan, strategy="mean")
X = imp.fit_transform(X)
Y = Y.reshape(-1,1)
Y = imp.fit_transform(Y)
Y = Y.reshape(-1)

#-----------------------------------------------------------------------------
# Encoding categorical data

# Label Encoder only converts Charter in Numeric variable but doesnor split onto columns
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[3] = labelencoder_X.fit_transform(X[3])
# Hot Encoder only converts numeric values
onehotencoder = OneHotEncoder(categorical_features = [3])
X = onehotencoder.fit_transform(X).toarray()
# Avoiding Dummy variable trap
X=X[:,1:]

#Encoding Generic-full dataset
dataset=pd.get_dummies(dataset)

#Encoding Generic- only independent variable
X=pd.get_dummies(X)


