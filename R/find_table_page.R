#'
#' Find the page for a specific data table to retrieve
#' 

find_table_page <- function(bulletin_text) {
  grep(pattern = src, x = bulletin_text[[1]]) |>
    (\(x) x[1])()
}


#'
#' Find table page - population 
#' 

find_table_page_pop <- function(bulletin_text) {
  pattern <- "Age\\s{2,}Males\\s{2,}Females\\s{2,}Total"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()  
}


#'
#' Find table page - population by district
#'

find_table_page_pop_district <- function(bulletin_text) {
  pattern <- "DISTRICT POPULATION ESTIMATES|DISTRICT POPULATION|POPULATION BY DISTRICT"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}


#'
#' Find table page - death 
#'

find_table_page_death <- function(bulletin_text) {
  pattern <- "DEATHS BY AGE AND SEX"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}


#'
#' Find table page - birth 
#'

find_table_page_birth <- function(bulletin_text) {
  pattern <- "REGISTERED BIRTHS AND DEATHS|KEY DEMOGRAPHIC INDICATORS"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}


#'
#' Find table page - birth by month 
#'

find_table_page_birth_month <- function(bulletin_text) {
  pattern <- "REGISTERED LIVE BIRTHS BY YEAR, MONTH OF REGISTRATION"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}


#'
#' Find table page - birth by district
#'

find_table_page_birth_district <- function(bulletin_text) {
  pattern <- "BIRTHS BY DISTRICT OF RESIDENCE"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}


#'
#' Find table page - birth by birth order
#'

find_table_page_birth_birth_order <- function(bulletin_text) {
  pattern <- "BIRTHS BY BIRTH ORDER"

  index <- grep(pattern = pattern, x = bulletin_text[[1]], value = TRUE) |>
    grep(pattern = "SEYCHELLOIS", invert = TRUE)

  grep(pattern = pattern, x = bulletin_text[[1]]) |>
    (\(x) x[index])()
}