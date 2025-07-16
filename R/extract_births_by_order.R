#'
#' Extract births by order
#' 

extract_births_by_child_number <- function(page, pdf) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  end_line <- grep(pattern = "^Total|^TOTAL", x = df)

  df <- df |>
    (\(x) x[end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame()

  if (ncol(df) == 10) {
    df <- df |>
      (\(x) x[ , c(3:(ncol(x)))])() |>
      setNames(nm = c(1:6, "7+", "Not Stated"))
  } else {
    df <- df |>
      (\(x) x[ , c(3:(ncol(x)))])() |>
      dplyr::mutate(`Not Stated` = "0") |>
      setNames(nm = c(1:6, "7+", "Not Stated"))
  }
    
  df <- df |>
    tidyr::pivot_longer(
      cols = dplyr::everything(),
      names_to = "child_number", values_to = "births"
    ) |>
    dplyr::mutate(
      births = ifelse(births == "-", 0, births) |>
        as.integer()
    ) |>
    dplyr::mutate(year = as.integer(year), .before = child_number)

  df
}