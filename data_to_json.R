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