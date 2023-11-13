# Get the X and Y from the users input argument
# Input: string(s)
# Output: variable_vector
get_depen_var <- function(s){
  formula_object <- as.formula(s)
  response_variable <- as.character(formula_object[[2]])
  variables <- all.vars(formula_object)[-1]
  variable_vector <- c(response_variable,as.character(variables))
  return(variable_vector)
}
