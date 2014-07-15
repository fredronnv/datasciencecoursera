corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  files <- list.files(path = directory, full.names = TRUE)
  data <- do.call("rbind", lapply(files,read.csv, header = TRUE))
  observations <- complete(directory)
  filtered_observations <- subset(observations, nobs > threshold)
  r_vec <- numeric()
  for ( i in filtered_observations[["id"]] ){
    sulfate <- subset(data, ID == i & !is.na(sulfate) & !is.na(nitrate))[["sulfate"]]
    nitrate <- subset(data, ID == i & !is.na(sulfate) & !is.na(nitrate))[["nitrate"]]
    r_vec <- c(r_vec, cor(sulfate,nitrate))
  }
  
  return(r_vec)
}
