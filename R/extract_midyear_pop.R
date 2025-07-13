#'
#' Extract midyear population from PDF files
#' 

extract_midyear_pop <- function(pdf, page) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |> 
    unlist() |> 
    (\(x) x[seq(from = grep(pattern = "^\\s{1,}0\\s{1,}", x = x), to = grep(pattern = "^\\s{1,}30-34\\s{1,}|^\\s{1,}30‐34\\s{1,}", x = x), by = 1)])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{1,}", replacement = ",") |>
    (\(x) x[x != ""])() |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    (\(x) rbind(x[ , 1:4], x[ , 5:8], x[ , 9:12]))() |>
    data.frame() |>
    dplyr::filter(X1 != "") |>
    stats::setNames(nm = c("age", "male", "female", "total")) |>
    dplyr::mutate(
      male = suppressWarnings(as.integer(male)) |>
        (\(x) ifelse(is.na(x), -3, x))(),
      female = as.integer(female),
      total = as.integer(total)
    ) |>
    dplyr::mutate(year = year, .before = age)

  df <- df |>
    dplyr::filter(stringr::str_detect(age, pattern = "^[0-9]{1,2}$|\\+")) |>
    dplyr::mutate(
      age = stringr::str_remove_all(string = age, pattern = "\\+") |>
        as.integer()
    )
  
  df
}

