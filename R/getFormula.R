#'@name get_formula
#'
#'@title Get the formula of your model
#'
#'@description From the main funciton generate coefficient table, to generate the mathematics formula of this model
#'
#'@param model A dataframe, with coefficient and dependent variables.
#'
#'@return A complete mathematics formula of the fitted linear model
#'
#'@examples
#'model <- data.frame(Coefficients = c(-1,1,2,3),Variable = c("Intercept", "X1", "X2", "X3"))
#'get_formula(model)
#'
#'@export
#'
get_formula <- function(model){
  beta <- model$Coefficients
  X <- model$Variable
  beta0<- beta[1]
  beta <- beta[-1]
  X <- X[-1]
  formula_string <- paste("Y", "~", beta0,"+",
                          paste0(beta, "*", X, collapse = " + "))
  model_express <- as.formula(formula_string)
  return(model_express)
}
