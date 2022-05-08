################################################################################
#
#'
#' Structure raw data - key demographic indicators
#' 
#' @param data_table Matrix of key demographic indicators from extracted tables
#'   from PDF
#'
#
################################################################################

structure_midyear_demo_2021 <- function(data_table) {
  data_table |>
    (\(x) x[5:nrow(x), ])() |>
    stringr::str_split(pattern = " ") |>
    unlist() |>
    stringr::str_remove_all(pattern = ",") |>
    as.numeric() |>
    matrix(nrow = length(1986:2021), ncol = 8) |>
    data.frame() |>
    (\(x) 
      { 
        names(x) <- c(
          "year", "population", "live_births", "deaths", "infant_deaths", 
          "marriages_residents", "marriages_visitors", "marriages_total"
        )
        
        x
      }
    )()
}



structure_endyear_demo_2021 <- function(data_table) {
  x <- data_table |>
    (\(x) x[3:nrow(x), ])() |>
    stringr::str_split(pattern = "\r") |> 
    unlist() |> 
    stringr::str_remove_all(pattern = ",") |>
    as.numeric() |>
    matrix(nrow = length(1986:2021), ncol = 6)
  
  y1 <- x[ , 2] |>
    stringr::str_split(pattern = "(?<=.{5})", n = 2) |>
    (\(x) do.call(rbind, x))()
  
  y2 <- y1[ , 2] |>
    stringr::str_split(pattern = "(?<=.{4})", n = 2) |>
    (\(x) do.call(rbind, x))()
  
  y3 <- y2[ , 2] |>
    stringr::str_split(pattern = "(?<=.{3})", n = 2) |>
    (\(x) do.call(rbind, x))()

  data.frame(x[ , 1], 
             as.numeric(y1[, 1]), 
             as.numeric(y2[ , 1]), 
             as.numeric(y3[ , 1]), 
             as.numeric(y3[ , 2]),
             x[ , 3:6]) |>
    (\(x) 
     { 
       names(x) <- c(
         "year", "population", "live_births", "deaths", "infant_deaths", 
         "marriages_residents", "marriages_visitors", "marriages_total",
         "divorces"
       )
       
       x
    }
    )()
}