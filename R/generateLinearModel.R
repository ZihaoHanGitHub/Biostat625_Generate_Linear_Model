#'@name generate_linear_model
#'
#'@title Generate the Linear Model
#'
#'@description  The Main function of this package, it would calculate the fitted (Least Square Estimate) Linear Model from your argument and dataset
#'
#'@param s A argument of your model, which is a formula of your function about response variable and dependent variable
#'
#'@param data original dataset form users
#'
#'@return A coefficient table of this fitted linear model
#'
#'@examples
#'df <- data.frame(Y = c(1, 2, 3, 4),X1 = c(2, 7, 4, 5),X2 = c(3, 4, 1, 6),X3 = c(4, 5, 6, 9))
#'generate_linear_model(Y~X1+X2+X3,df)
#'
#'@export
#'
generate_linear_model <- function(s,data){
  if(s == ""){
    message <- "Error! You enter an not valid argument!"
    return(message)
  }else{
    formula_object <- as.formula(s)
    response_variable <- as.character(formula_object[[2]])
    variables <- all.vars(formula_object)[-1]
    variable_vector <- c(response_variable,as.character(variables))
    if(all(variable_vector %in% names(data))){
      df = na_test( variable_vector , data )
      if(sum(is.na(df))==0){
        X <- df[,-1]
        X <- cbind(1, X)
        X <- as.matrix(X)
        Y <- df[,1]
        Y <- as.matrix(Y)
        SSX <- t(X)%*%X
        assign("my_global_variable", SSX, envir = .GlobalEnv)
        if(det(SSX)==0){
          stop("Error!Check your dependent Variable, it is not full rank!")
        }else{
          inverse_SSX <- solve(SSX)
          beta_matrix <- (inverse_SSX)%*%t(X)%*%Y
        }
        rounded_beta_matrix <- round(beta_matrix, digits = 5)
        Y_name <- variable_vector[1]
        X_name <- variable_vector[-1]
        #coefficients <- data.frame()
        X_name <- c(('Intercept'),X_name)
        coefficient_table <- data.frame(Coefficients = rounded_beta_matrix, Variable = X_name)
        print(coefficient_table,row.names=FALSE)
      }else{
        stop("Error! Your dataset contains N.A!")
      }
    }else{
      stop("Error: Not all variables in variable_vector are present in the data.")
    }
  }
}
