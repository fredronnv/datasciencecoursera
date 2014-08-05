rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # look at what we're trying to find
  string <- "Hospital.30.Day.Death..Mortality..Rates.from."
  look_for <- paste(string, simpleCap(outcome), sep="")
  if ( !look_for %in% colnames(outcome_data) ){
    stop("invalid outcome")
  }
  outcome_filter <- outcome_data[,c(look_for, "Hospital.Name","State")]
  outcome_filter[[look_for]] <- as.numeric(outcome_filter[[look_for]])
  outcome_filter <- subset(outcome_filter, !is.na(get(look_for)))
  
  hospitallist <- NULL
  statelist <- sort(unique(outcome_data[,"State"]))
  
  for (state in statelist){
    outcome_state <- subset(outcome_filter, State == state)
    outcome_state <- outcome_state[,c(look_for, "Hospital.Name")]
    ordered_outcome <- outcome_state[ order(outcome_state[,1], outcome_state[,2]), ]
    if( num == "best" ){
      hospitallist <- c(hospitallist,ordered_outcome[1,c("Hospital.Name")])
    }
    else if( num == "worst" ){
      hospitallist <- c(hospitallist,ordered_outcome[nrow(ordered_outcome),c("Hospital.Name")])
    }else{
      hospitallist <- c(hospitallist,ordered_outcome[num,c("Hospital.Name")])
    }
  }
  df <- data.frame(hospital=hospitallist, state=statelist)
  row.names(df) <- statelist
  return(df)
}