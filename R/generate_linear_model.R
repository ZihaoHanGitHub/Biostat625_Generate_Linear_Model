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
#'generate_linear_model(Y~X1+X2+X3,data)
#'
#'@export
#'
generate_linear_model <- function(s,data){
  if(s == ""){
    message <- "Error! You enter an not valid argument!"
    return(message)
  }else{
    variable_vector <- get_depen_var(s)
    if(deter_depen_var( variable_vector , data )==TRUE){
      df = na_test( variable_vector , data )
      beta_matrix = get_beta( data )
      coefficient_table <- get_coefficient_table( beta_matrix , s )
      print( coefficient_table , row.names = FALSE )
    }
  }
}
