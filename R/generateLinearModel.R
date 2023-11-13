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
  if(s == " "){
    message <- "Error! You enter an not valid argument!"
    return(message)
  }else{
    n <- nrow(df)
    p <- ncol(df)
    if(n-p>0){

    }
    formula_object <- as.formula(s)
    response_variable <- as.character(formula_object[[2]])
    variables <- all.vars(formula_object)[-1]
    variable_vector <- c(response_variable,as.character(variables))
    if(all(variable_vector %in% names(data))){
      df = na_test( variable_vector , data )
      if(sum(is.na(df))==0){
        n <- nrow(df)
        p <- ncol(df)
        dfE <- n-p
        if(dfE < 0){
          stop("Error!The data rows is not enough to calculate the parameter!")
        }
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

        #Comput the T-test
        Res <- Y_matrix-X_matrix%*%beta_matrix
        SSE <- t(Res)%*%Res
        sigma_squared <- SSE/dfE
        se_beta <- sqrt(diag(inverse_SSX)*c(sigma_squared))
        t_statistics <- beta_matrix / se_beta
        p_values <- 2 * pt(abs(t_statistics), df = dfE, lower.tail = FALSE)
        coefficient_table <- data.frame(
          Coefficients = rounded_beta_matrix,
          Variable = X_name,
          t_value = t_statistics,
          p_value = p_values
        )
        for (i in 1:p) {
          if (coefficient_table[i, "p_value"] >= 0.1) {
            coefficient_table[i, "Significance"] = "  "
          } else if (coefficient_table[i, "p_value"] >= 0.05) {
            coefficient_table[i, "Significance"] = "."
          } else if (coefficient_table[i, "p_value"] > 0.01) {
            coefficient_table[i, "Significance"] = "*"
          } else if (coefficient_table[i, "p_value"] > 0.001) {
            coefficient_table[i, "Significance"] = "**"
          } else {
            coefficient_table[i, "Significance"] = "***"
          }
        }
        SSY <- t(Y_matrix)%*%Y_matrix
        R_sq <- 1 - SSE/SSY
        adj_R_sq <- 1 - (sigma_squared)/(SSY/(n-1))
        Rsquared_table <- data.frame(
          R_squared = R_sq,
          Adjusted_R_squared = adj_R_sq
        )
        SSR = SSY - SSE
        dfR = (p-1)
        F_statistics = (SSR/dfR)/(sigma_squared)
        p_value <- 1 - pf(F_statistics, df1 = dfR, df2 = dfE)
        F_table <- data.frame(
          F_statistics = F_statistics,
          p_value = p_value
        )
        X_name_formula <- variable_vector[-1]
        beta0 <- rounded_beta_matrix[1]
        beta <- rounded_beta_matrix[-1]
        formula_string <- paste(Y_name, "~", beta0,"+",
                                paste0(beta, "*", X_name_formula, collapse = " + "))
        model_express <- as.formula(formula_string)
      }else{
        stop("Error! Your dataset contains N.A!")
      }
    }else{
      stop("Error: Not all variables in variable_vector are present in the data.")
    }
  }
  result <- list(
    Mathematics_formula = model_express,
    coefficients_table =coefficient_table,
    Rsquared_table= Rsquared_table,
    F_table = F_table
  )
  return(result)
}

