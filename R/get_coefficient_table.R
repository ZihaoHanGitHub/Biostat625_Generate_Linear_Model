#'@name get_coefficient_table
#'
#'@title Get Coefficient Table of your model
#'
#'@description  Last step of a linear regression model, generate the coefficient and dependent vairable corresponding table
#'
#'@param beta_matrix a coefficient matrix corresponding to dependent variable and intercept
#'
#'@param s A formula of your linear model containing the dependent variable and response variable
#'
#'@return A data.frame, column names is Coefficient and Variable, each row corresponding to each Variables name and value of coefficient
#'
#'@examples
#'get_coefficient_table(beta_matrix,Y~X1+X2+X3)
#'
#'@export
#'
get_coefficient_table <- function(beta_matrix,s){
  var_vect <- get_depen_var(s)
  rounded_beta_matrix <- round(beta_matrix, digits = 5)
  Y <- var_vect[1]
  X <- var_vect[-1]
  coefficients <- data.frame()
  X <- c(('Intercept'),X)
  coefficient_table <- data.frame(Coefficients = rounded_beta_matrix, Variable = X)
  return(coefficient_table)
}
