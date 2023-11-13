# Express the formula of model
# input: beta_matrix, s
# output: table of coefficient
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
