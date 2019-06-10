# Load packages----
library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('mice') # imputation
library('randomForest') # classification algorithm
#Loading and Checking Dataset----
test = read.csv('Dataset//Titanic//test.csv',stringsAsFactors = F,na.strings=c(""))
train = read.csv('Dataset//Titanic//train.csv',stringsAsFactors = F,na.strings=c(""))
full = bind_rows(train, test) # bind training & test data
#check data----
str(full)
#Feature Enginerring----
#Categorical Variable----
#Name----
full$Name
#First Name or Last Name will not have much significance in analysis but the title will give an idea about the class of the society.
full$Title=gsub('(.*, )|(\\..*)', '', full$Name)
full$Surname=gsub('(, .*)', '', full$Name)
#Check title with gender
table(full$Sex,full$Title)
#Rare title with very low count are group in 'rare' category
rare_title <- c('Dona', 'Lady', 'the Countess','Capt', 'Col', 'Don', 
                'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer')
#Assign Mme as Miss
full$Title[full$Title %in% c("Mlle","Ms")]="Miss"
#Assign Mme as Mrs 
full$Title[full$Title=="Mme"]="Mrs"
#Assign rare_title
full$Title[full$Title %in% rare_title]="Rare"
#check
table(full$Sex,full$Title)
#Check if Family sink together
full$Fsize = full$SibSp + full$Parch + 1
table(full$Fsize)
full$Familiy= paste(full$Surname,full$Fsize,sep='_')
# Use ggplot2 to visualize the relationship between family size & survival
ggplot(full[1:891,], aes(x = Fsize, fill = factor(Survived))) +
  geom_bar(stat='count', position='dodge') +
  scale_x_continuous(breaks=c(1:11)) +
  labs(x = 'Family Size') +
  theme_few()
#Family who are single or Family with more than 4 member has less chance of survival
#Thus dividing this category into 3 groups
# Discretize family size
full$FsizeD[full$Fsize == 1] <- 'single'
full$FsizeD[full$Fsize < 5 & full$Fsize > 1] <- 'small'
full$FsizeD[full$Fsize > 4] <- 'large'

# Show family size by survival using a mosaic plot
mosaicplot(table(full$FsizeD, full$Survived), main='Family Size by Survival', shade=TRUE)

#Missing value----
#Now we’re ready to start exploring missing data and rectifying it through imputation. 
#There are a number of different ways we could go about doing this. 
#Given the small size of the dataset, we probably should not opt for deleting either entire observations (rows) or variables (columns) containing missing values. 
#We’re left with the option of either replacing missing values with a sensible values given the distribution of the data, e.g., the mean, median or mode. 
#Finally, we could go with prediction. We’ll use both of the two latter methods and I’ll rely on some data visualization to guide our decisions.
na_finder_columnwise(full)
embark_fare <- full %>%filter(PassengerId != 62 & PassengerId != 830)
full %>%filter(PassengerId == 62 | PassengerId == 830)
# Use ggplot2 to visualize embarkment, passenger class, & median fare
ggplot(embark_fare, aes(x = Embarked, y = Fare, fill = factor(Pclass))) +
  geom_boxplot() +
  geom_hline(aes(yintercept=80), 
             colour='red', linetype='dashed', lwd=2) +
  scale_y_continuous(labels=dollar_format()) +
  theme_few()
#The median fare for a first class passenger departing from Charbourg (‘C’) coincides nicely with the $80 paid by our embarkment-deficient passengers. I think we can safely replace the NA values with ‘C’.
full$Embarked[c(62, 830)] <- 'C'
#missing fare value
which(is.na(full$Fare))
full[1044, ]
#This is is 3rd class passenger departed from Southhampton
ggplot(full[full$Pclass == '3' & full$Embarked == 'S', ], 
       aes(x = Fare)) +
  geom_density(fill = '#99d6ff', alpha=0.4) + 
  geom_vline(aes(xintercept=median(Fare, na.rm=T)),
             colour='red', linetype='dashed', lwd=1) +
  scale_x_continuous(labels=dollar_format()) +
  theme_few()
# As the distribution is screwed its better to replace with median
# Replace missing fare value with median fare for class/embarkment
full$Fare[1044] <- median(full[full$Pclass == '3' & full$Embarked == 'S', ]$Fare, na.rm = TRUE)
#Finally, as we noted earlier, there are quite a few missing Age values in our data. 
#We are going to get a bit more fancy in imputing missing age values. Why? Because we can. 
#We will create a model predicting ages based on other variables.











