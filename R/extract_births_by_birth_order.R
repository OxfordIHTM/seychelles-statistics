#'
#' Extract births by child number
#' 

extract_births_by_birth_order <- function(bulletin_text, page) {
  year <- names(bulletin_text) |>
    stringr::str_extract(pattern = "[0-9]{4}$")

  df_text <- bulletin_text[[1]]

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
      names_to = "birth_order", values_to = "births"
    ) |>
    dplyr::mutate(
      births = ifelse(births == "-", 0, births) |>
        as.integer(),
      birth_order = factor(
        x = birth_order, levels = c(1:6, "+7", "Not Stated")
      )
    ) |>
    dplyr::mutate(year = as.integer(year), .before = birth_order)

  df
}