source("R/get_depen_var.R")
source("R/deter_depen_var.R")
source("R/na_test.R")
source("R/get_beta.R")
source("R/get_coefficient_table.R")
source("R/get_formula.R")
source("R/get_pred.R")
# Main function of calculate model
# input: string(s), and data
# output: Model expression
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
