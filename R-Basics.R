#----Selecting a specific row/column or both: Subsetting/Slicing----
data1[2,2]
data1[,2]
data1$MYCT
data1[,"MYCT"]
data1[1,]
data1[0,0] #Indices in R start from 1 not 0
#Subsetting/Slicing multiple rows and columns
data1[1,2,3,4,5] #Need to assign vector of indices
data1[c(1,2,3,4,5),]
data1[c(1,2,3,4,5),c(1,5)]
data1[c(1,2,3,4,5),c("Vendor","CACH")]
data1[c(1,2,3,4,5),-c(1,5)]
data1[c(1,2,3,4,5),-c("Vendor","CACH")] #Character vectors
data1[1:5,c("Vendor","CACH")] # ?
data1[1:5,c(1,5)] # ?
is.vector(c(1,2,3,4,5))
is.vector(1:5) #Sequence functions in R will generate vectors, so they can be useful in slicing/indexing
#Some import functions also generate lists: Mostly functions that work with web objects like JSON/XML
#----reading JSON----
library(jsonlite)
data2<-fromJSON("F:\\Work\\Jigsaw Academy\\Blogs\\September 15\\Visa.txt")
class(data2)#Not every data import will result in creation of dataframes
str(data2)
#----Saving+Loading Image---
save.image(file="F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\Workspace.RData")
rm(data1,data2,model1)
load("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\Workspace.RData")
#----Importing tabular data----
#Checks needed to ensure that data is imported correctly
#1. Delimiter in the file
#2. How missing values are populated in the data
import1<-read.table("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\sample2.csv",sep=",",header = TRUE)
summary(import1) #Focus on the missing values
str(import1) #Are column data types correct
import2<-read.table("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\sample1.txt")#Why error
import2<-read.table("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\sample1.txt",sep="\t")
import2#What is wrong?
import2<-read.table("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\sample1.txt",sep="\t",header=TRUE)
summary(import2)
str(import2)
import2<-read.table("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\sample1.txt",sep="\t",header=TRUE,na.strings = c(NA,"Missing",""))
#----Working with SQL servers----
#Identify which SQL data base you are working with
#MySql and Postgresql are most popular
#If mysql is the sql engine to be connected then RMySql can be used to connect R to sql
library(RMySQL)
con<-dbConnect(MySQL(),dbname="world",username="root",password="root")
dbListTables(con)
import.sql1<-dbGetQuery(con,"SELECT * FROM city")
class(import.sql1)
dbDisconnect(con)
#One way to connect to SQL is using RODBC, this will work with other SQL distribution such as Postgresql, SQL Server and not just MySQL
library(RODBC)
connection<-odbcConnect("mysql",uid="root",pwd="root") #dsn has to be specified, this will be linked to only one database in sql server. dsn can be changed by accessing control panel, admnistrative tools, odbc data sources
sqlTables(connection)
import.sql2<-sqlFetch(connection,"host_summary")
close(connection)
class(import.sql2)
#----Working with web data----
#Working with web objects JSON and XML#
#Sometimes data is not available in tabular formats: csv, sql servers#
#Particuarly when working with API's
#Glassdoor API, https://www.glassdoor.co.in/developer/index.htm
library(jsonlite)
web1<-fromJSON("http://api.glassdoor.com/api/api.htm?v=1&format=json&t.p=47699&t.k=g9GdVHlQ1eM&action=employers&q=pharmaceuticals&userip=192.168.43.42&useragent=Mozilla/%2F4.0")
class(web1)
str(web1)
#Getting tables from web pages
#Many web pages contain tabular data as comma separated or tab separated
#UCI Abalone data set
web2<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data",header=FALSE)
head(web2)# Column names are missing
#Use the documentation on the page to figure out the column names
name<-c("Sex","Length","Diameter","Height","Whole.Weight","Shuclked.Weight","Viscera.Weight","Shell.Weight","Rings")
names(web2)<-name
head(web2)
str(web2)
#Fetching HTML tables from a webpage
library(XML)
web3<-readHTMLTable("http://www.inflationdata.com/Inflation/Consumer_Price_Index/HistoricalCPI.aspx?reloaded=true")
class(web3)
#One can save the web page locally and still read in the tables
web4<-readHTMLTable("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\Historical Consumer Price Index (CPI).html")
class(web4)
#If analysis on this data has to be done then it should be converted to a dataframe
web4<-as.data.frame(web4)
class(web4)
head(web4)#What is wrong?
write.csv(web4,"F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\cpi.csv",row.names = F)
web5<-read.csv("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\cpi.csv")
head(web5)#Need to skip the first line
web5<-read.csv("F:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Live Classes\\Intro to R\\cpi.csv",skip=1)
head(web5)

#----Checking for missing value----
is.na(Price)
#----which element----
which(is.na(Price))
which(Price==100)
#----Character object----
Names<-c("John","Robert",NA,"Catherine")
Names
length(Names)
#----To view the type of object----
class(Names)
class(Price)
#----Setting the working directory----
setwd("D:\\Data Manipulation with R\\")
getwd()
#----Sequence functions----
Sequence<-seq(1970,2000)
Sequence
Sequence_By<-seq(from=1,to=5,by=0.5)
Sequence_By
rep(1,5)
rep(1:5,2)
rep(1:5,each=2)
#----I want to get this 1,1,1,5,1,5,2,2----
new_seq<-rep(seq(1,2,0.5),each=2)
#----scan variable----
x<-scan()
x

#----Saving an object----
save(Names,file="Names.rda")
#Saving whole workspace
save.image("all_work.RData")

#----How do I load my data back?----
load("Names.rda")

#----Datastructures in R----
#Vector, matrices,dataframes, Lists

#Vector: Most simple strucrure in R. Only one datatype
x<-c(1,2,3,4)
x
#Lists: Recursive vectors. Can handle different data types
y<-list(1,2,3,4)
y
my.list<-list(name=c("Robert","Emma"),age=c(65,54),
              retired=c(TRUE,FALSE))
my.list
my.list$age
my.list["age"]
my.list[["age"]][1]
my.list[[3]]
my.list[[3]][2]
# Matrices : A single table with rows and columns of data
B=matrix(c(2,4,3,1,5,7),
         nrow=3,
         ncol=2)
B
B[1,]
B[,2]
B[1,2]
#----Dataframe : A single table with rows and columns of data----
#Each column can be a different datatype
#Consider the following vectors:
products=c("Bag","shoes","belt","belt")
total_price=c(500,1000,150,200)
color=c("Blue","red","red","blue")
quantity=c(5,2,3,4)
product_details<-data.frame(product,total_price,color,quantity,
                            stringsAsFactors = FALSE)
product_details
class(product_details)
product_details[,2]
product_details[2,]
product_details[2,2]
product_details$product
#----Iris Dataset in the datassets package----
library(datasets)
data()
data(iris)
## Getting the list of  variables
names(iris)
colnames(iris)
## Getting the number of rows and columns
dim(iris)
nrow(iris)
ncol(iris)
## To look at top few or bottom few observations
head(iris)
tail(iris)
## Looking at the structure of datasets
str(iris)
# More about the dataset
?iris
## Checking the type of object
class(iris)
## Attach and detach
head(Species)
head(iris$Species)
attach(iris)
head(Species)
## Importing a csv file
iris=read.csv("Iris.csv",header=T,sep=",")
head(iris)
# Importing a text file
iris<-read.table("Iris.txt",header=T,sep="\t")
head(iris,10)
names(iris)
#Summary of dataset
summary(iris)
# We can check if a given variable is character, numeric, factor
# is.character(), is.factor()
is.character(iris$Species)
is.numeric(iris$Petal.Length)
detach(iris)

#----Logical Subseting
#----Selecting only those rows where brand bought is tropicana----
dat<-oj[oj$brand=='tropicana',]
#----Using Or condition, brand bought is tropicana or dominicks----
dat1<-oj[oj$brand=='tropicana'|oj$brand=='dominicks',]
head(dat1)
#----Using And condition, brand bought is tropicana and no feature advertisement is run----
dat2<-oj[oj$brand=='tropicana' & oj$feat==0,]
head(dat2)
#----Subsetting using which() operator----
index<-which(oj$brand=="dominicks")
head(index)
dat3<-oj[index,]
#----Selecting Columns----
dat4<-oj[,c("week","brand")]
head(dat4)
#----Seleecting+Subsetting----
dat5<-oj[oj$brand=='tropicana' & oj$feat==0,c("week","store")]
head(dat5)
#----Adding new columns----
oj$logInc<-log(oj$INCOME)
dim(oj)
#----Revenue Column----
head(oj$logmove)
head(exp(oj$logmove))
oj$revenue<-exp(oj$logmove)*oj$price
#----Sorting data----
numbers<-c(10,100,5,8)
order(numbers)
order(-numbers)
dat6<-oj[order(oj$week),]
head(dat6)
min(oj$week)
dat7<-oj[order(-oj$week),]
head(dat7)
max(oj$week)
#----Group by summaries----
class(oj$brand)
unique(oj$brand)
#----Mean price of juice across brands----
#Summarize-Price
#Summarize by-Brand (factor)
#Summarize how-Mean
#Syntax aggregate(variable to be summarized, by=list(variable by which grouping is to be done),function)
aggregate(oj$price,by=list(oj$brand),mean)
class(aggregate(oj$price,by=list(oj$brand),mean))
tapply(oj$price,oj$brand,mean)
class(tapply(oj$price,oj$brand,mean))
#----Mean income of people by brand----
Summarize-Income
#----Summarize by-Brand----
#Summarize how-Mean
aggregate(oj$INCOME,by=list(oj$brand),mean)
class(aggregate(oj$INCOME,by=list(oj$brand),mean))
tapply(oj$INCOME,oj$brand,mean)
class(tapply(oj$INCOME,oj$brand,mean))
#----Cross tabulations----
#----Units of different brands sold based on if feature advertisement was run or not----
table(oj$brand,oj$feat)
class(table(oj$brand,oj$feat))
xtabs(oj$INCOME~oj$brand+oj$feat)
#----dplyr----
library(dplyr)
dat8<-filter(oj,brand=="tropicana")
dim(filter(oj,brand=="tropicana"))
dat9<-filter(oj,brand=="tropicana"|brand=="dominicks")
dim(filter(oj,brand=="tropicana"|brand=="dominicks"))
#----Selecting Columns----
dat10<-select(oj,brand,INCOME,feat)
dat11<-select(oj,-brand,-INCOME,-feat)
#----Creating a new column----
dat12<-mutate(oj,logIncome=log(INCOME))
#----Arranging data----
dat13<-arrange(oj,INCOME)
dat14<-arrange(oj,desc(INCOME))
dat14<-arrange(oj,-INCOME)
#----Group Wise summaries----
gr_brand<-group_by(oj,brand)
summarize(gr_brand,mean(INCOME),sd(INCOME))
#----Pipelines----
#----Base R code----
mean(oj[oj$INCOME>=10.5,"price"])
#----dplyr code----
summarize(filter(oj,INCOME>=10.5),mean(price))
oj%>%filter(INCOME>=10.5)%>%summarize(mean(price))
oj%>%filter(price>=2.5)%>%mutate(logIncome=log(INCOME))%>%summarize(mean(logIncome),median(logIncome),sd(logIncome))
#----Date----
strDates="01/20/14"
date1=as.Date(strDates,format="%m/%d/%y")
date1
date=as.Date(strDates,format="%m/%d/%Y")
class(date)
fd<-read.csv("Fd.csv")
dim(fd)
str(fd)
fd$FlightDate<-as.Date(fd$FlightDate,format="%d-%b-%y")
str(fd)
head(months(fd$FlightDate))
unique(months(fd$FlightDate))
head(weekdays(fd$FlightDate))
unique(weekdays(fd$FlightDate))
#Finding time interval
fd$FlightDate[60]-fd$FlightDate[900]
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "weeks")
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "days")
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "hours")
difftime(fd$FlightDate[3000],fd$FlightDate[90])
#----Subsetting data based on time information----
library(dplyr)
#----Subset the data for day=Sunday----
dim(fd)
fd%>%filter(weekdays(FlightDate)=="Sunday")->weekd
dim(weekd)
#----Find the number of flights on Sundays for destination Atlanta----
fd%>%filter(weekdays(FlightDate)=="Sunday",DestCityName=="Atlanta, GA")%>%nrow()
fd%>%mutate(day=weekdays(FlightDate)=="Sunday")%>%
  filter(day==TRUE,DestCityName=="Atlanta, GA")%>%nrow()
#----Find the number of flights on Sundays for all cities----
fd%>%filter(weekdays(FlightDate)=="Sunday")%>%group_by(DestCityName)%>%
  summarize(n=n())%>%arrange(-n)
#----PISIXct and POSIXlt----
date1=as.POSIXct(Sys.time())
class(date1)
unclass(date1)
date2 <- as.POSIXlt(date1)
class(date2)
unclass(date2)
#----Merging data----
#----Joins using Merge----
df1 = data.frame(CustomerId=c(1:6),Product=c(rep("Toaster",3),rep("Radio",3)))
df2 = data.frame(CustomerId=c(2,4,6),State=c(rep("Alabama",2),rep("Ohio",1)))
merge(x = df1, y = df2, by = "CustomerId", all = TRUE)#Outer join:
merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)#Left join
merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)#Right join
merge(x=df1,y=df2,by="CustomerId")#Inner Join/Intersection of both tables
#----Missing values----
a<-c(1,2,3,4,5,6,NA,NA,NA,7,8,9)
is.na(a)
sum(is.na(a))
air<-airquality
head(air)
sum(is.na(air$Ozone))
sum(is.na(air$Solar.R))
summary(air)
#----Imputing Missing values----
air$Ozone[is.na(air$Ozone)]<-45
summary(air)
air$Solar.R[is.na(air$Solar.R)]<-mean(air$Solar.R,na.rm=TRUE)
summary(air)
#----reshape2()----
library(reshape2)
person<-c("Sankar","Aiyar","Singh")
age<-c(26,24,25)
weight<-c(70,60,65)
wide<-data.frame(person,age,weight)
wide
#----Wide to long----
melt(wide,id.vars="person")
melted<-melt(wide,id.vars="person",value.name ="Demo_Value" )
dcast(melted,person~variable,value.var = "Demo_Value")
#----String manipulation----
a<-"Batman"
substr(a,start=2,stop=6)
nchar(a)
tolower(a)
toupper(a)
b<-"Bat-Man"
strsplit(b,split="-")
c<-"Bat/Man"
strsplit(c,split="/")
paste(b,c)
c(b,c)
grep("-",c(b,c))
c(b,c)
grepl("/",c(b,c))
c(c,b)
grepl("/",c(c,b))
b
sub("-","/",b)
d<-"Bat-Ma-n"
sub("-","/",d)
gsub("-","/",d)
#----Replacing nth instance----
string=c("This_is_my_first")
i <- 3 #3rd
sapply(strsplit(string, "_"), function(x) {
  g <- seq_along(x)
  g[g < i] <- i
  paste(tapply(x, g, paste, collapse = "_"), collapse = "-")
})
#----sqldf----
library(sqldf)
#----Using SELECT statement----
oj_s<-sqldf("select brand, income, feat from oj ")
#----Subseting using where statement----
oj_s<-sqldf("select brand, income, feat from oj where price<3.8 and income<10")
#----Order by statement----
oj_s<-sqldf("select store,brand,week,logmove,feat,price, income from oj order by income asc")
#----distinct----
sqldf("select distinct brand from oj")
#----Demo sql functions----
sqldf("select avg(income) from oj")
sqldf("select min(price) from oj")


#Basic R
is.vector(c(1,2,3,4,5))
#read csv
data1<-read.csv("Dataset//customers.csv")

#Some import functions also generate lists: Mostly functions that work with web objects like JSON/XML
library(jsonlite)

#Lists are not only encountered while importing data but also when we work with machine learning algorithms
#linearmodel function do not know yet
model1<-lm(data1$city~data1$state)
