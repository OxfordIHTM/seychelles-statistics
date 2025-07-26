#'
#' Extract births by age group and child number
#' 

extract_births_by_age_birth_order <- function(bulletin_text, page) {
  year <- names(bulletin_text)

  df_text <- bulletin_text[[1]]

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^Under", x = df)
  end_line <- grep(pattern = "^45\\+", x = df)

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame()

  if (ncol(df) == 10) {
    df <- df |>
      (\(x) x[ , c(1, 3:(ncol(x)))])() |>
      setNames(nm = c("age_group", 1:6, "7+", "Not Stated"))
  } else {
    df <- df |>
      (\(x) x[ , c(1, 3:(ncol(x)))])() |>
      dplyr::mutate(`Not Stated` = "0") |>
      setNames(nm = c("age_group", 1:6, "7+", "Not Stated"))
  }
    
  df <- df |>
    dplyr::mutate(
      age_group = ifelse(age_group == "Under 15", "<15", age_group)
    ) |>
    tidyr::pivot_longer(
      cols = `1`:`Not Stated`,
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