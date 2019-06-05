#row-wise-check
row_na_val=(rowSums(is.na(dataset))
            
            
            na_finder_columnwise(sagar)
            
            #removing uniquie identifiers
            dataset=select(dataset,-Customer_ID)
            na_value_perecent=colSums(is.na(dataset))/prod(dim(dataset)[1])
            col_na_val_mean=colMeans(is.na(dataset))
            
            #lets see its impact on chrun rate
            ggplot(data=dataset, aes(x = dwlltype, fill = factor(churn)))+
              geom_bar(stat='count', na.rm = TRUE,position='dodge') +
              labs(x = 'dwlltype') 
            #But anyways lets drop it
            #Na value reduced to 8445
            dataset=select(dataset,-c(dwlltype))
            
            #----check frequncy of churn----
            table(dataset$churn)
            #count(dataset, 'churn')
            #----drop CustomerID column----
            
            
            #----Analysing each categorical IV with respect to churn----
            #----Mean number of monthly minutes of use----
            #boxplot
            
            plot=hist(dataset$mou_Mean,breaks = seq(0,15000,by=100),xlim = c(0,2000))
            
            ggplot(data=dataset, aes(x = mou_Mean, fill = factor(churn)))+
              scale_x_continuous(limits = c(0,2000))+
              scale_y_continuous(limits = c(0,10))+
              geom_bar(stat='count', na.rm = TRUE,position='dodge',width=100) +
              labs(x = 'Family Size') 
            
            #----active subscribersin family----
            MAX=max(dataset$mou_Mean,na.rm=TRUE)
            table(dataset$churn, dataset$actvsubs)
            #----Logical Regression on Churn as target variable---
            