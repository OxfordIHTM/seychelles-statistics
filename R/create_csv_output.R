#'
#' Create CSV output
#' 

create_csv_data <- function(x, dest) {
  write.csv(x = x, file = dest, row.names = FALSE)

  dest
}