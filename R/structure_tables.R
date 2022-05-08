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

# structure_midyear_demo_2021 <- function(data_table) {
#   data_table |>
#     (\(x) x[5:nrow(x), ])() |>
#     stringr::str_split(pattern = " ") |>
#     unlist() |>
#     stringr::str_remove_all(pattern = ",") |>
#     as.numeric() |>
#     matrix(nrow = length(1986:2021), ncol = 8) |>
#     data.frame() |>
#     (\(x) 
#       { 
#         names(x) <- c(
#           "year", "population", "live_births", "deaths", "infant_deaths", 
#           "marriages_residents", "marriages_visitors", "marriages_total"
#         )
#         
#         x
#       }
#     )()
# }


structure_midyear_demo_2021 <- function(data_table) {
  data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |> 
    (\(x) x[6:41])() |>
    stringr::str_split(pattern = " ", simplify = TRUE) |>
    (\(x) x[x != ""])() |>
    stringr::str_remove_all(pattern = ",") |>
    as.vector(mode = "numeric") |>
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



# structure_endyear_demo_2021 <- function(data_table) {
#   x <- data_table |>
#     (\(x) x[3:nrow(x), ])() |>
#     stringr::str_split(pattern = "\r") |> 
#     unlist() |> 
#     stringr::str_remove_all(pattern = ",") |>
#     as.numeric() |>
#     matrix(nrow = length(1986:2021), ncol = 6)
#   
#   y1 <- x[ , 2] |>
#     stringr::str_split(pattern = "(?<=.{5})", n = 2) |>
#     (\(x) do.call(rbind, x))()
#   
#   y2 <- y1[ , 2] |>
#     stringr::str_split(pattern = "(?<=.{4})", n = 2) |>
#     (\(x) do.call(rbind, x))()
#   
#   y3 <- y2[ , 2] |>
#     stringr::str_split(pattern = "(?<=.{3})", n = 2) |>
#     (\(x) do.call(rbind, x))()
# 
#   data.frame(x[ , 1], 
#              as.numeric(y1[, 1]), 
#              as.numeric(y2[ , 1]), 
#              as.numeric(y3[ , 1]), 
#              as.numeric(y3[ , 2]),
#              x[ , 3:6]) |>
#     (\(x) 
#      { 
#        names(x) <- c(
#          "year", "population", "live_births", "deaths", "infant_deaths", 
#          "marriages_residents", "marriages_visitors", "marriages_total",
#          "divorces"
#        )
#        
#        x
#     }
#     )()
# }


structure_endyear_demo_2021 <- function(data_table) {
  data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |> 
    (\(x) x[6:41])() |>
    stringr::str_split(pattern = " ", simplify = TRUE) |>
    (\(x) x[x != ""])() |>
    stringr::str_remove_all(pattern = ",") |>
    as.vector(mode = "numeric") |>
    matrix(nrow = length(1986:2021), ncol = 9) |>
    data.frame() |>
    (\(x) 
     { 
       names(x) <- c(
         "year", "population", "live_births", "deaths", "infant_deaths", 
         "marriages_residents", "marriages_visitors", "marriages_total", 
         "divorces_total"
       )
       
       x
    }
    )()
}



################################################################################
#
#'
#' Structure raw data - components of population change
#' 
#' @param data_table Matrix of components of population change from extracted 
#'   tables from PDF
#'
#
################################################################################

structure_midyear_pop_change_2021 <- function(data_table) {
  data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |>
    (\(x) x[c(6:34)])() |>
    (\(x) x[c(1:3, 5:8, 10:19, 21, 23:29)])() |>
    stringr::str_split(
      pattern = "                               |             |           |         |     |    ", 
      simplify = TRUE
    ) |>
    stringr::str_remove_all(pattern = ",") |>
    (\(x) 
     c(
       x[1:25] |>
         stringr::str_split(pattern = " ", simplify = TRUE) |>
         (\(x) c(x[ , 1], x[ , 2]))(),
       x[26:length(x)] |> 
         stringr::str_remove_all(pattern = " ") |>
         stringr::str_replace_all(pattern = "‐", replacement = "-")
      )
    )() |>
    #matrix(nrow = 25, ncol = 7) |>
    (\(x) 
     data.frame(
       x[1:25],
       matrix(
         data = as.numeric(x[26:length(x)]),
         nrow = 25,
         ncol = 6
       )
     )
    )() |>
    (\(x) 
     { 
       names(x) <- c(
         "month", "year", "population_start", "live_births", 
         "deaths", "migration", "population_end"
       )
       
       x
    }
    )()
}



structure_endyear_pop_change_2021 <- function(data_table) {
  data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |>
    (\(x) x[c(6:33)])() |>
    (\(x) x[c(1:7, 9:18, 20:28)])() |>
    stringr::str_split(
      pattern = "                   |                  |             |           |            |       ", 
      simplify = TRUE
    ) |>
    stringr::str_remove_all(pattern = ",") |>
    (\(x) 
     c(
       x[1:26] |>
         stringr::str_split(pattern = " ", simplify = TRUE) |>
         (\(x) 
           c(
             x[ , 1], 
             x[ , 2] |> 
               stringr::str_replace(pattern = "\\(1\\)", replacement = "")
           )
         )(),
       x[27:length(x)] |> 
         #stringr::str_remove_all(pattern = "‐") |> 
         as.numeric()
     )
    )() |>
    #matrix(nrow = 26, ncol = 7) |>
    (\(x) 
      data.frame(
        x[1:26],
        matrix(
          data = as.numeric(x[27:length(x)]),
          nrow = 26,
          ncol = 6
        )
      )
    )() |>
    (\(x) 
     { 
       names(x) <- c(
         "month", "year", "population_start", "live_births", 
         "deaths", "migration", "population_end"
       )
       x
    }
    )()
}


################################################################################
#
#'
#' Structure raw data - demographic rates
#' 
#' @param data_table Matrix of demographic rates from extracted tables from PDF
#'
#
################################################################################

structure_endyear_demo_rates_2021 <- function(data_table) {
  data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |>
    (\(x) x[7:42])() |>
    stringr::str_split(pattern = " ") |>
    unlist() |>
    (\(x) x[x != ""])() |>
    as.numeric() |>
    matrix(nrow = length(1986:2021), ncol = 8, byrow = TRUE) |>
    data.frame() |>
    (\(x) 
      { 
        names(x) <- c(
          "year", "population_growth_natural", "population_growth_migration",
          "birth_rate", "death_rate", "infant_mortality_rate", 
          "civil_marriage_rate", "divorce_rate"
        )
        
        x
      }
    )()
}



################################################################################
#
#'
#' Structure raw data - population estimates by age
#' 
#' @param data_table Matrix of population estimates by age from extracted 
#'   tables from PDF
#'
#
################################################################################

structure_midyear_population_by_age_2021 <- function(data_table) {
  x <- data_table |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |>
    (\(x) x[4:45])()
  
  y <- x[c(1:5, 7:11, 13:17, 19:23)] |>
    stringr::str_split(
      pattern = "             |            |        |       |     |    |   "
    ) |>
    unlist() |>
    (\(x) x[x != ""])() |>
    stringr::str_replace_all(pattern = "‐", replacement = "-") |>
    stringr::str_remove_all(pattern = ",") |>
    as.numeric() |>
    matrix(nrow = 20, ncol = 12, byrow = TRUE) |>
    (\(x) 
      {
        x1 <- x[ , 1:4]
        x2 <- x[ , 5:8]
        x3 <- x[ , 9:12]
        rbind(x1, x2, x3) |>
          data.frame() |>
          (\(x) { names(x) <- c("age", "males", "females", "total"); x })()
      }
    )()

  z <- x[c(25:29, 31:35, 37:41)] |>
    stringr::str_split(
      pattern = "             |            |        |       |     |    |   ", 
      simplify = TRUE
    ) |>
    (\(x) x[ , 2:13])() |>
    (\(x) { x[15, 2:8] <- x[15, 3:9]; x })() |>
    (\(x) { x[14, 10:12] <- x[14, 9:11]; x })() |>
    (\(x) { x[14, 9] <- "TOTAL"; x })() |>
    (\(x) { x[15, 9] <- ""; x })() |>
    unlist() |>
    #(\(x) x[x != ""])() |>
    #(\(x) x[c(1:116, 120:length(x))])() |>
    stringr::str_remove_all(pattern = ",| TOTAL") |>
    #as.numeric() |>
    matrix(nrow = 15, ncol = 12) |>
    (\(x) 
      {
        x1 <- x[ , 1:4]
        x2 <- x[ , 5:8]
        x3 <- x[ , 9:12]
        y <- rbind(x1, x2, x3)
        y[y != ""] |>
          (\(x)
            {
              data.frame(
                x[1:32],
                x[33:length(x)] |>
                  as.numeric() |>
                  matrix(nrow = 32, ncol = 3)
              )
            }
          )() |>
          (\(x) 
            { 
              names(x) <- c("age", "males", "females", "total")
              x 
            }
          )()
      }
    )()
    
  rbind(y, z) |>
    (\(x) x[1:nrow(x) - 1, ])()
}
