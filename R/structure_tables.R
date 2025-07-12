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


structure_midyear_population_by_age_2021 <- function(data_table) {
  ## Set 1
  set1 <- rbind(
    matrix(data = data_table$text[19:90], ncol = 12), 
    matrix(data = data_table$text[91:162], ncol = 12), 
    matrix(data = data_table$text[163:234], ncol = 12), 
    matrix(data = data_table$text[235:306], ncol = 12)
  )
  
  set2 <- rbind(
    matrix(data = data_table$text[307:354], ncol = 8),
    matrix(data = data_table$text[359:406], ncol = 8)
  )
  
  set3 <- cbind(
    matrix(data = data_table$text[407:424], byrow = TRUE, ncol = 3),
    matrix(data = data_table$text[430:435], byrow = TRUE, ncol = 1)
  )
  
  set4 <- matrix(data = data_table$text[436:459], ncol = 4)
  
  set5 <- matrix(data = data_table$text[355:358], ncol = 4)
  
  full_table <- rbind(
    set1[ , 1:4], set2[ , 1:4], set3, set1[ , 5:8], set2[ , 5:8], set4,
    set1[ , 9:12], set5
  )
  
  full_table[!seq_len(nrow(full_table)) %in% seq(from = 6, to = nrow(full_table), by = 6), ] |>
    data.frame() |>
    (\(x) { names(x) <- c("age", "male", "female", "total"); x })() |>
    dplyr::mutate(
      male = stringr::str_remove_all(male, pattern = ",") |> 
        stringr::str_replace(pattern = "‐", replacement = "-") |>
        as.integer(),
      female = stringr::str_remove_all(female, pattern = ",") |> as.integer(),
      total = stringr::str_remove_all(total, pattern = ",") |> as.integer()
    )
}


structure_midyear_population_by_age_2020 <- function(data_table) {
  ## Set 1
  set1 <- rbind(
    matrix(data = data_table$text[17:88], ncol = 12), 
    matrix(data = data_table$text[89:160], ncol = 12), 
    matrix(data = data_table$text[161:232], ncol = 12), 
    matrix(data = data_table$text[233:304], ncol = 12)
  )
  
  set2 <- rbind(
    matrix(data = data_table$text[305:352], ncol = 8),
    matrix(data = data_table$text[357:404], ncol = 8)
  )
  
  set3 <- cbind(
    matrix(data = data_table$text[405:422], byrow = TRUE, ncol = 3),
    matrix(data = data_table$text[428:433], byrow = TRUE, ncol = 1)
  )
  
  set4 <- matrix(data = data_table$text[434:457], ncol = 4)
  
  set5 <- matrix(data = data_table$text[353:356], ncol = 4)
  
  full_table <- rbind(
    set1[ , 1:4], set2[ , 1:4], set3, set1[ , 5:8], set2[ , 5:8], set4,
    set1[ , 9:12], set5
  )
  
  full_table[!seq_len(nrow(full_table)) %in% seq(from = 6, to = nrow(full_table), by = 6), ] |>
    data.frame() |>
    (\(x) { names(x) <- c("age", "male", "female", "total"); x })() |>
    dplyr::mutate(
      male = stringr::str_remove_all(male, pattern = ",") |> 
        stringr::str_replace(pattern = "‐", replacement = "-") |>
        as.integer(),
      female = stringr::str_remove_all(female, pattern = ",") |> as.integer(),
      total = stringr::str_remove_all(total, pattern = ",") |> as.integer()
    )
}


structure_midyear_population_by_age_2019 <- function(data_table) {
  ## Set 1
  set1 <- rbind(
    matrix(data = data_table$text[17:88], ncol = 12), 
    matrix(data = data_table$text[89:160], ncol = 12), 
    matrix(data = data_table$text[161:232], ncol = 12), 
    matrix(data = data_table$text[233:304], ncol = 12)
  )
  
  set2 <- rbind(
    matrix(data = data_table$text[305:352], ncol = 8),
    matrix(data = data_table$text[357:404], ncol = 8)
  )
  
  set3 <- cbind(
    matrix(data = data_table$text[405:422], byrow = TRUE, ncol = 3),
    matrix(data = data_table$text[428:433], byrow = TRUE, ncol = 1)
  )
  
  set4 <- matrix(data = data_table$text[434:457], ncol = 4)
  
  set5 <- matrix(data = data_table$text[353:356], ncol = 4)
  
  full_table <- rbind(
    set1[ , 1:4], set2[ , 1:4], set3, set1[ , 5:8], set2[ , 5:8], set4,
    set1[ , 9:12], set5
  )
  
  full_table[!seq_len(nrow(full_table)) %in% seq(from = 6, to = nrow(full_table), by = 6), ] |>
    data.frame() |>
    (\(x) { names(x) <- c("age", "male", "female", "total"); x })() |>
    dplyr::mutate(
      male = stringr::str_remove_all(male, pattern = ",") |> 
        stringr::str_replace(pattern = "‐", replacement = "-") |>
        as.integer(),
      female = stringr::str_remove_all(female, pattern = ",") |> as.integer(),
      total = stringr::str_remove_all(total, pattern = ",") |> as.integer()
    )
}


structure_midyear_population_by_age_2018 <- function(data_table) {
  ## Set 1
  set1 <- rbind(
    matrix(data = data_table$text[19:90], ncol = 12), 
    matrix(data = data_table$text[91:162], ncol = 12), 
    matrix(data = data_table$text[163:234], ncol = 12), 
    matrix(data = data_table$text[235:306], ncol = 12)
  )
  
  set2 <- rbind(
    matrix(data = data_table$text[307:354], ncol = 8),
    matrix(data = data_table$text[359:406], ncol = 8)
  )
  
  set3 <- matrix(data = data_table$text[407:454], ncol = 8)
  
  set4 <- matrix(data = data_table$text[355:358], ncol = 4)
  
  full_table <- rbind(
    set1[ , 1:4], set2[ , 1:4], set3[ , 1:4], set1[ , 5:8], set2[ , 5:8], set3[ , 5:8],
    set1[ , 9:12], set4
  )
  
  full_table[!seq_len(nrow(full_table)) %in% seq(from = 6, to = nrow(full_table), by = 6), ] |>
    data.frame() |>
    (\(x) { names(x) <- c("age", "male", "female", "total"); x })() |>
    dplyr::mutate(
      male = stringr::str_remove_all(male, pattern = ",") |> 
        stringr::str_replace(pattern = "‐", replacement = "-") |>
        as.integer(),
      female = stringr::str_remove_all(female, pattern = ",") |> as.integer(),
      total = stringr::str_remove_all(total, pattern = ",") |> as.integer()
    )
}

