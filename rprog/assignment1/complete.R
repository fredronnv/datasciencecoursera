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
  complete_subset <- subset(data, !is.na(sulfate) & !is.na(nitrate) & ID %in% id)
  return_data <- aggregate(complete_subset['ID'], by = complete_subset['ID'], length)
  names(return_data) <- c("id", "nobs")
  rd = NULL
  for (i in id){
    rd <- rbind(rd, c(i,return_data[return_data$id==i, 2]))
  }
  colnames(rd) <- c("id","nobs")
  row.names(rd) <- 1:length(id)
  return(data.frame(rd))
}