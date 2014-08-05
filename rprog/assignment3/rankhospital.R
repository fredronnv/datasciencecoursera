rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # First filter for state
  outcome_state <- subset(outcome_data, State == state)
  
  if ( nrow(outcome_state) <= 0 ){
    stop("invalid state")
  }
  
  # Then look at what we're trying to find
  string <- "Hospital.30.Day.Death..Mortality..Rates.from."
  look_for <- paste(string, simpleCap(outcome), sep="")
  if ( !look_for %in% colnames(outcome_data) ){
    stop("invalid outcome")
  }
  outcome_state <- outcome_state[,c(look_for, "Hospital.Name")]
  outcome_state[[look_for]] <- as.numeric(outcome_state[[look_for]])
  outcome_state <- subset(outcome_state, !is.na(get(look_for)))
  
  #if ( num != "best" && num != "worst" && !is.integer(num) ){
  #  stop("invalid num")
  #}
  
  ordered_outcome <- outcome_state[ order(outcome_state[,1], outcome_state[,2]), ]
  
  if( num == "best" ){
    return(ordered_outcome[1,c("Hospital.Name")])
  }
  else if( num == "worst" ){
    return(ordered_outcome[nrow(ordered_outcome),c("Hospital.Name")])
  }else{
    return(ordered_outcome[num,c("Hospital.Name")])
  }
}