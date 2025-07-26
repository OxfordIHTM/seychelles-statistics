#'
#' Find the page for a specific data table to retrieve
#' 

find_table_page <- function(bulletin_text) {
  grep(pattern = src, x = bulletin_text[[1]]) |>
    (\(x) x[1])()
}

find_table_page_pop <- function(bulletin_text) {
  pattern <- "Age\\s{2,}Males\\s{2,}Females\\s{2,}Total"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()  
}


find_table_page_pop_district <- function(bulletin_text) {
  pattern <- "DISTRICT POPULATION ESTIMATES|DISTRICT POPULATION|POPULATION BY DISTRICT"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}

find_table_page_death <- function(bulletin_text) {
  pattern <- "DEATHS BY AGE AND SEX"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}