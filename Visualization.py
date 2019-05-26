#Regression model with 1 dependent variable
# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#-----------------------------------------------------------------------------
# Visualising the Training set results
plt.scatter(X_train, y_train, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Training set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()
#-----------------------------------------------------------------------------
# Visualising the Test set results
plt.scatter(X_test, y_test, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Test set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()

#-----------------------------------------------------------------------------
# Visualising the Polynomial Regression results
plt.close()
plt.scatter(X_train, y_train, color = 'red')
plt.plot(X_train, lin_reg_2.predict(poly_reg.fit_transform(X_train)), color = 'blue')
plt.title('Truth or Bluff (Polynomial Regression)')
plt.xlabel('Position level')
plt.ylabel('Salary')
plt.show()
#-----------------------------------------------------------------------------
# Visualising the Polynomial Regression results (for higher resolution and smoother curve)
plt.close()
X_grid = np.arange(min(X_train[0]), max(X_train[0]), 0.1)
X_grid = X_grid.reshape((len(X_grid), 1))
plt.scatter(X_train, y_train, color = 'red')
plt.plot(X_grid, lin_reg_2.predict(poly_reg.fit_transform(X_grid)), color = 'blue')
plt.title('Truth or Bluff (Polynomial Regression)')
plt.xlabel('Position level')
plt.ylabel('Salary')
plt.show()
#-----------------------------------------------------------------------------