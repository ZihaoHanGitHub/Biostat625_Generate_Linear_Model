#'@name deter_depen_var
#'
#'@title Determine the dependent variable and response variable
#'
#'@description  Check if the response variable and dependent variables could be find in
#'
#'@param variable_vector a vector of variable names, cut from the original argument
#'
#'@param data original dataset form users
#'
#'@return TRUE or Error Message
#'
#'@examples
#'deter_depen_var(variable_vector,dataset)
#'
#'@export
#'
deter_depen_var <- function(variable_vector,data){
  all_variables_exist <- all(variable_vector %in% names(data))
  if (all_variables_exist) {
    return(TRUE)
  } else {
    stop("Error: Not all variables in variable_vector are present in the data.")
  }
}
