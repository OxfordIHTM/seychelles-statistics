#'
#' Extract endyear births and deaths
#' 

extract_endyear_births_monthly <- function(page, pdf) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^January", x = df)
  end_line <- grep(pattern = "^December", x = df)

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    (\(x) x[x != ""])() |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame()

  if (year == 2016) {
    df <- df |>
      setNames(nm = c("month", 2012:2016))
  } else {
    df <- df |>
      (\(x) x[ , c(1, ncol(x))])() |>
      setNames(nm = c("month", year))
  }

  df <- df |>
    tidyr::pivot_longer(
      cols = dplyr::matches("[0-9]{4}"), 
      names_to = "year", 
      values_to = "births"
    ) |>
    dplyr::relocate(year, .before = month) |>
    dplyr::mutate(
      dplyr::across(.cols = c(year, births), .fns = as.integer),
      month = factor(
        x = month,
        levels = c(
          "January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"
        )
      )
    ) |>
    dplyr::arrange(year)

  df
}