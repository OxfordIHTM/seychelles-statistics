#'
#' Extract midyear population for 2023
#' 

extract_midyear_pop_2023 <- function(pdf, page, age_group = FALSE) {
  df <- pdftools::pdf_text(pdf = pdf) |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |> 
    unlist() |> 
    # (\(x) x[5:52])() |>
    (\(x) x[grep(pattern = " 0 ", x = x):grep(pattern = " 30-34 ", x = x)])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{1,}", replacement = ",") |>
    (\(x) x[x != ""])() |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    (\(x) rbind(x[ , 1:4], x[ , 5:8], x[ , 9:12]))() |>
    data.frame() |>
    dplyr::filter(X1 != "") |>
    stats::setNames(nm = c("age", "males", "females", "total")) |>
    dplyr::mutate(
      males = as.integer(males),
      females = as.integer(females),
      total = as.integer(total)
    )

  if (age_group) {
    df <- df |>
      dplyr::filter(stringr::str_detect(age, pattern = "\\-|\\+"))
  } else {
    df <- df |>
      dplyr::filter(
        stringr::str_detect(age, pattern = "\\-|TOTAL", negate = TRUE)
      )
  }
  
  df
}

