#Get model formula expression
# input: Model
# ouput: Mathematics Model Formula
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
