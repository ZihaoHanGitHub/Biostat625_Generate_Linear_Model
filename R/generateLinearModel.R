#'@name generate_linear_model
#'
#'@title Generate the Linear Model
#'
#'@description  The Main function of this package, it would calculate the fitted (Least Square Estimate) Linear Model from your argument and dataset,
#'in the calculation, it applied the matrix operator to estimate the coefficients and several tests, in the end, this function return a comprehensive dataframe,
#'you can the return part to understand each frame is, and in examples you can understand how to export each frame, also, you can see the tutorial to know it deeper!
#'
#'@param s A argument of your model, which is a formula of your function about response variable and dependent variable
#'
#'@param data original dataset form users
#'
#'@return A coefficient table of this fitted linear model, including the coefficient value, stand error, t test value and p value corresponding to each variable.
#'@return A Mathematics formula of your fitted linear model
#'@return A R squared table for the fitted model, including R square and adjusted R squared
#'@return A Sum of Square table, mainly including the SSR, SSE, and SSY, also the degree of freedom and MSR,MSE,MSY respectively.
#'@return A F table, which is F test, including the F-statistics and p-value, and the degree of freedom
#'@return A confident interval table, which includes the confident interval (95%CI) for each coefficient.
#'
#'@import stats
#'@examples
#'dataset = LinearModelGenerator::data
#'model = generate_linear_model(Depression~Age+Sex+Fatalism,dataset)
#'#call the coefficient table
#'coefficient_table = model$coefficients_table
#'#call the mathematics formula
#'formula = model$Mathematics_formula
#'#call the R Squared table
#'R_squared_table = model$Rsquared_table
#'#call the Sum of Square table
#'SS_table = model$SS_table
#'#call the F_table
#'F_table = model$F_table
#'#call the confident interval
#'CI = model$confident_interval
#'
#'@export
#'
generate_linear_model <- function(s,data){
  if(s == " "){
    message = "Error! You enter an not valid argument!"
    return(message)
  }else{
    formula_object = as.formula(s)
    response_variable = as.character(formula_object[[2]])
    variables = all.vars(formula_object)[-1]
    variable_vector = c(response_variable,as.character(variables))
    if(all(variable_vector %in% names(data))){
      df = data[,variable_vector]
      if(sum(is.na(df))==0){
        n = nrow(df)
        p = ncol(df)
        dfE = n-p
        if(dfE < 0){
          message = "Error!The data rows is not enough to calculate the parameter!"
          return(message)
        }
        X = df[,-1]
        X = cbind(intercept = 1, X)
        X = as.matrix(X)
        Y = df[,1]
        Y = as.matrix(Y)
        SSX = t(X)%*%X
        if(det(SSX)==0){
          message = "Error!Check your dependent Variable, it is not full rank!"
          return(message)
          #stop("Error!Check your dependent Variable, it is not full rank!")
        }else{
          inverse_SSX = solve(SSX)
          beta_matrix = (inverse_SSX)%*%t(X)%*%Y
        }
        Y_name = variable_vector[1]
        X_name = variable_vector[-1]
        #coefficients <- data.frame()
        X_name = c(('(Intercept)'),X_name)

        #Comput the T-test
        Res = Y-X%*%beta_matrix
        SSE = t(Res)%*%Res
        MSE = SSE/dfE
        se_beta = sqrt(diag(inverse_SSX)*c(MSE))
        t_statistics = beta_matrix / se_beta
        p_values = 2 * pt(abs(t_statistics), df = dfE, lower.tail = FALSE)
        #c("Estimate","Std. Error","t value","Pr(>|t|)")
        coefficient_table = data.frame(
          beta_matrix,
          se_beta,
          t_statistics,
          p_values
        )
        #coefficient_table = as.matrix(coefficient_table)
        colnames(coefficient_table) = c("Estimate","Std. Error", "t value", "Pr(>|t|)")
        for (i in 1:p) {
          if (coefficient_table[i, "Pr(>|t|)"] >= 0.1) {
            coefficient_table[i, "Significance"] = "  "
          } else if (coefficient_table[i, "Pr(>|t|)"] >= 0.05) {
            coefficient_table[i, "Significance"] = "."
          } else if (coefficient_table[i, "Pr(>|t|)"] > 0.01) {
            coefficient_table[i, "Significance"] = "*"
          } else if (coefficient_table[i, "Pr(>|t|)"] > 0.001) {
            coefficient_table[i, "Significance"] = "**"
          } else {
            coefficient_table[i, "Significance"] = "***"
          }
        }
        rownames(coefficient_table) = X_name
        Y_mean = mean(Y)
        SSY = t(Y-Y_mean)%*%(Y-Y_mean)
        R_sq = 1 - SSE/SSY
        adj_R_sq = 1 - (MSE)/(SSY/(n-1))
        Rsquared_table = data.frame(
          R_squared = R_sq,
          Adjusted_R_squared = adj_R_sq
        )
        SSR = SSY - SSE
        dfR = (p-1)
        F_statistics = (SSR/dfR)/(MSE)
        p_value = 1 - 2*pf(F_statistics, df1 = dfR, df2 = dfE)
        F_table = data.frame(
          F_statistics,
          dfR,
          dfE,
          p_value
        )
        #F_table = as.matrix(F_table)
        colnames(F_table) = c("value","numdf","dendf","p_value")
        dfY = dfR+dfE
        anova_table = data.frame(
          Row = c("Regression", "Error", "Total"),
          SS = c(SSR,SSE,SSY),
          df = c(dfR,dfE,dfY),
          MS = c(SSR/dfR,SSE/dfE,SSY/dfY)
        )
        X_name_formula = variable_vector[-1]
        beta0 = beta_matrix[1]
        beta = beta_matrix[-1]
        formula_string = paste(Y_name, "~", beta0,"+",
                               paste0(beta, "*", X_name_formula, collapse = " + "))
        model_express = as.formula(formula_string)
        t_95ci = qt(0.975, df = dfE)
        confident_interval_lower = beta_matrix - t_95ci*se_beta
        confident_interval_upper = beta_matrix + t_95ci*se_beta
        confident_interval = data.frame(
          confident_interval_lower = confident_interval_lower,
          confident_interval_upper = confident_interval_upper
        )
        #confident_interval = as.matrix(confident_interval)
        rownames(confident_interval)= c('(Intercept)', 'Age', 'Sex', 'Fatalism')

      }else{
        message = "Error! Your dataset contains N.A!"
        return(message)
        #stop("Error! Your dataset contains N.A!")
      }
    }else{
      message = "Error: Not all variables in variable_vector are present in the data."
      return(message)
      #stop("Error: Not all variables in variable_vector are present in the data.")
    }
  }
  result <- list(
    Mathematics_formula = model_express,
    coefficients_table =coefficient_table,
    Rsquared_table= Rsquared_table,
    SS_table = anova_table,
    F_table = F_table,
    confident_interval = confident_interval
  )
  return(result)
}
