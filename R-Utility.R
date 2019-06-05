#na_finder_columnwise
na_finder_columnwise <- function(dataframe) {
  m <- sapply(dataframe, function(x) {
    data.frame(
      no_of_na=sum(is.na(x)), 
      total_rows=length(x), 
      percentage_of_miss_percolumn=sum(is.na(x))/length(x)*100
    )
  })
  d <- data.frame(t(m))
  d <- sapply(d, unlist)
  d <- as.data.frame(d)
  d$variable <- row.names(d)
  row.names(d) <- NULL
  d <- cbind(d[ncol(d)],d[-ncol(d)])
  return(d[order(d$percentage_of_miss_percolumn,decreasing = TRUE), ])
}
----------------------------------
#----na_finder_rowwise_notworking----
na_finder_rowwise <- function(dataframe) {
  n <- sapply(t(dataframe), function(x) {
    data.frame(
      no_of_na=sum(is.na(x)), 
      total_rows=length(x), 
      percentage_of_miss_perrow=sum(is.na(x))/length(x)*100
    )
  })
  d <- data.frame(t(n))
  d <- sapply(d, unlist)
  d <- as.data.frame(d)
  d$variable <- row.names(d)
  row.names(d) <- NULL
  d <- cbind(d[ncol(d)],d[-ncol(d)])
  return(d[order(d$percentage_of_miss,decreasing = TRUE), ])
}


sagar=t(dataset)
