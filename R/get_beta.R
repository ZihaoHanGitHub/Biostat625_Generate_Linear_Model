#'@name get_beta
#'
#'@title Calculate Beta Matrix
#'
#'@description  From your dependent variable and response variable to calculate the beta matrix, or warning you that you input a dataset which is not full ranked
#'
#'@param data the dataset that is already selected by the other function
#'
#'
#'@return Beta Matrix, which is a matrix contains beta_0,beta_1, and so on.
#'
#'@examples
#'get_beta(data)
#'
#'@export
#'
get_beta <- function(data){
  X <- data[,-1]
  X <- cbind(1, X)
  X <- as.matrix(X)
  Y <- data[,1]
  Y <- as.matrix(Y)
  SSX <- t(X)%*%X
  assign("my_global_variable", SSX, envir = .GlobalEnv)
  if(det(SSX)==0){
    stop("Error!Check your dependent Variable, it is not full rank!")
  }else{
    inverse_SSX <- solve(SSX)
    beta_matrix <- (inverse_SSX)%*%t(X)%*%Y
    return(beta_matrix)
  }
}
