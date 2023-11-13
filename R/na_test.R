# check if there is na
# input: data and variable_vector
# Output: the X and Y of data, or Error
na_test <- function(variable_vector,data){
  data = data[,variable_vector]
  if (sum(is.na(data))==0) {
    return(data)
  }else{
    stop("Error! Your dataset contains N.A!")
  }
}
