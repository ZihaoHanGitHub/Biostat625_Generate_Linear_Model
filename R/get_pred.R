#Use the Model already fitted to predict/calculate
# input: Model, New dataset
# Output: Response Variable
get_pred <- function(model,new_X){
  new_X = as.matrix(cbind(1,new_X))
  beta_matrix <- as.matrix(model$Coefficients)
  Y <- new_X %*% beta_matrix
  return(Y)
}
