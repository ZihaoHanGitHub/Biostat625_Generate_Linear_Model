#'@name na_test
#'
#'@title Check N.A in your dataset
#'
#'@description From the variable of your select from the input of argument, check if there is N.A in the data set of variable interested, and also return the data set of variable intereseted
#'
#'@param variable_vector A vector of variable from your formula argument, generate by get_depen_var function
#'
#'@param data The dataset from you input
#'
#'@return A complete dataset with the variables selected, or an error that the dataset contains N.A
#'
#'@examples
#'data <- na_test(variable_vector,data)
#'
#'@export
#'
na_test <- function(variable_vector,data){
  data = data[,variable_vector]
  if (sum(is.na(data))==0) {
    return(data)
  }else{
    stop("Error! Your dataset contains N.A!")
  }
}
