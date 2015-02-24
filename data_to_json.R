#'@title 
#'Data To JSON
#'
#'@description 
#'This function convert data to JSON format
#'
#'@details
#'This function converts data to JSON format that can be used in Shiny and Highcharts
#'
#'@param data data.frame that contains data
#'@param col_to_json columns that should be converted to JSON
#'@param col_names names of the columns
#'
#'@examples
#'data <- data.frame(one = runif(5), two = runif(5))
#'data <- to_json(data, col_to_json=c('one', 'two'))
#'
#'@export

data_to_json <- function(data, col_to_json=NULL, col_names=NULL) {
  
  if(!is.null(col_to_json)) {
    if(length(col_to_json)==1) {
      data <- data[col_to_json] 
    } else {
      data <- data[,col_to_json] 
    }
  }
  
  lapply(1:nrow(data), function(i) { 
    res <- as.list(data[i,]) 
    names(res) <- col_names
    return(res)
  })
}