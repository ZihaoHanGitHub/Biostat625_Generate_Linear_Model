#'@name get_depen_var
#'
#'@title Get the variable
#'
#'@description Get the dependent variable name and response variable name from the formula from the users input
#'
#'@param s A formula of a linear regression model, contain the response variable and dependent variable, connect with +
#'
#'@return A vector of your variable name, start with response variable and dependnent variables following.
#'
#'@examples
#'get_depen_var(Y~X1+X2+X3)
#'
#'@export
#'
get_depen_var <- function(s){
  formula_object <- as.formula(s)
  response_variable <- as.character(formula_object[[2]])
  variables <- all.vars(formula_object)[-1]
  variable_vector <- c(response_variable,as.character(variables))
  return(variable_vector)
}
