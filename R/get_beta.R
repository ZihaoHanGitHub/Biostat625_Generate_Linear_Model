# Calculate the beta of Model
# input: data
# output: beta matrix
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
