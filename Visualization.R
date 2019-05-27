#----Visualising the Training set results-------
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Training set)') +
  xlab('Years of experience') +
  ylab('Salary')


#----Visualising the Test set results-------------
library(ggplot2)
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Test set)') +
  xlab('Years of experience') +
  ylab('Salary')


#----Visualsing Linear function------------------------
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
           colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Linear Regression)') +
  xlab('Level') +
  ylab('Salary')




#----Visualising the Polynomial Regression results------
# install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset)),colour = 'blue') +
  #we are passsig dataset dirrectly without exponents as we have done that already in the regression
  #In the real life problem we may have to do it manually
  ggtitle('Truth or Bluff (Polynomial Regression)') +
  xlab('Level') +
  ylab('Salary')

#----Visualising the Regression Model results (for higher resolution and smoother curve)----
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(poly_reg,
                                        newdata = data.frame(Level = x_grid,
                                                             Level2 = x_grid^2,
                                                             Level3 = x_grid^3,
                                                             Level4 = x_grid^4))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Polynomial Regression)') +
  xlab('Level') +
  ylab('Salary')
#----Visualising the SVR results----
# install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Truth or Bluff (SVR)') +
  xlab('Level') +
  ylab('Salary')

#----Visualising the SVR results (for higher resolution and smoother curve)----
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (SVR)') +
  xlab('Level') +
  ylab('Salary')
#----Visualising the Decision Tree Regression results (higher resolution)----
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Decision Tree Regression)') +
  xlab('Level') +
  ylab('Salary')

# Plotting the tree
plot(regressor)
text(regressor)

#----Visualising the Random Forest Regression results (higher resolution)----
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Random Forest Regression)') +
  xlab('Level') +
  ylab('Salary')

#----Visualising Logistic Regression----
# Visualising the Training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
# Visualising the Test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
#----Plotting maps using Plotly---
#----List of packages:----
library(plotly)
library(ggmap)
setwd("D\\vis plotly\\")
#This public data contains vehicle accidents by US States for the year 2012
v<-read.csv("Dataset//vehicle_acc.csv")
head(v)
dim(v)
str(v)
#----Data preparation----
v$State <- as.character(v$State)
v$MV.Number = as.numeric(v$MV.Number)
#----Use geocode function to get the states----
#install.packages("ggmap")
library(ggmap)
for (i in 1:nrow(v)) {
  latlon = geocode(v[i,1])
  v$lon[i] = as.numeric(latlon[1])
  v$lat[i] = as.numeric(latlon[2])
}
#----Bubble maps----
final_data = v
names(final_data)
#----rename the names----
colnames(final_data) = c('state','collisions_percent','collisions_no','lon','lat')
#Add a new column
final_data$hover <- paste("collisions:", final_data$collisions_no,'state:',final_data$state)
#----Use cut function to create bins----
final_data$q <- with(final_data, cut(collisions_no, quantile(collisions_no), include.lowest = T))
levels(final_data$q) <- paste(c("1st", "2nd", "3rd", "4th"), "Quantile")
final_data$q <- as.ordered(final_data$q)
#----List all the details related to nature of the map to the object g----
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray85"),
  subunitwidth = 1,
  countrywidth = 1,
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white")
)
plot_ly(final_data, lon = lon, lat = lat, text = hover,
        marker = list(size = sqrt(collisions_no/2)),
        color = q, type = 'scattergeo', locationmode = 'USA-states') %>%
  layout(title = '2012 US city collisions', geo = g)
#----Choropleth Maps----
#----give state boundaries a black border----
l <- list(color = toRGB("black"), width = 2)
#----specify some map projection/options----
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('blue')
)
#----Get the data codes:----
state_code<-read.csv("state_table.csv")
head(state_code)
names(state_code)[1]<-"state"
final_data1<-merge(final_data,state_code,by="state",all.x=TRUE)
names(final_data1)[8]<-"code"
final_data1$code<-as.character(final_data1$code)
final_data<-final_data1
k<-brewer.pal(8,"Pastel2")
plot_ly(final_data, z = collisions_no, text = hover,locations=code, type = 'choropleth',
        locationmode = 'USA-states', color = collisions_no, colors = k  ,
        marker = list(line = l), colorbar = list(title = "Number of vehicle Collisions")) %>%
  layout(title = 'Number of vehicle Collisions<br>(Hover for breakdown)', geo = g)