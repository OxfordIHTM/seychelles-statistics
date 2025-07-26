#'
#' Extract endyear births by sex
#' 

extract_endyear_births_by_sex <- function(bulletin_text, page) {
  year <- names(bulletin_text) |>
    stringr::str_extract(pattern = "[0-9]{4}")
  #year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- bulletin_text[[1]]
  #df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^Males", x = df)
  end_line <- grep(pattern = "^Females", x = df)

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
      setNames(nm = c("sex", 2012:2016))
  } else {
    df <- df |>
      (\(x) x[ , c(1, ncol(x))])() |>
      setNames(nm = c("sex", year))
  }

  df <- df |>
    tidyr::pivot_longer(
      cols = dplyr::matches("[0-9]{4}"), 
      names_to = "year", 
      values_to = "births"
    ) |>
    dplyr::relocate(year, .before = sex) |>
    dplyr::mutate(
      dplyr::across(.cols = c(year, births), .fns = as.integer),
      sex = stringr::str_remove(string = sex, pattern = "s$") |>
        factor(levels = c("Female", "Male"))
    ) |>
    dplyr::arrange(sex, year)

  df
}