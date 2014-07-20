simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=".")
}


best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  # Get data
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
  outcome_state[[look_for]] <- as.numeric(outcome_state[[look_for]]) 
  hosp <- subset( outcome_state, !is.na(get(look_for)))
  hosp <- subset( hosp, get(look_for) == min(hosp[[look_for]]) )
  return(hosp[["Hospital.Name"]])
}