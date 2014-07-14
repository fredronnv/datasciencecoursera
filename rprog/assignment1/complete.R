complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  files <- list.files(path = directory, full.names = TRUE)
  data <- do.call("rbind", lapply(files,read.csv, header = TRUE))
  r_data <- NULL
  for (i in id){
    s_data <- subset(data, ID == i)
    n = nrow(s_data)
    if ( n > 0 ){
      n_complete <- nrow(subset(s_data, !is.na(sulfate) & !is.na(nitrate)))
      r_data <- rbind(r_data, c(i, n_complete))
    }
  }
  
  if ( !is.null(r_data) ){
    colnames(r_data) <- c("id", "nobs")
  }
  return(data.frame(r_data))
}