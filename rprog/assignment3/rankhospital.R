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
}