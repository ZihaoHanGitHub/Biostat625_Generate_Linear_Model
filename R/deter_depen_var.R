# Check if the X and Y could be find in the dataset
# Input: Variable_vector and data
# Output: TRUE or False
deter_depen_var <- function(variable_vector,data){
  all_variables_exist <- all(variable_vector %in% names(data))
  if (all_variables_exist) {
    return(TRUE)
  } else {
    stop("Error: Not all variables in variable_vector are present in the data.")
  }
}
