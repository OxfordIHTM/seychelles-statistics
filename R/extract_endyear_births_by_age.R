#'
#' Extract endyear births by age group
#' 

extract_births_by_age <- function(bulletin_text, page) {
  year <- names(bulletin_text) |>
    stringr::str_extract(pattern = "[0-9]{4}$")

  df_text <- bulletin_text[[1]]

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  end_line <- grep(pattern = "^Total", x = df)

  df <- df |>
    (\(x) x[end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame() |>
    (\(x) x[ , 2:(ncol(x) - 1)])()

  if (!year %in% c(2021, 2024)) {
    df <- df |>
      dplyr::mutate(`Not Stated` = "0")
  }

  df <- df |>
    dplyr::mutate(year = as.integer(year), .before = 1) |>
    setNames(
      nm = c(
        "year", "<15", "15-19", "20-24", "25-29",
        "30-34", "35-39", "40-44", "45+", "Not Stated"
      )
    ) |>
    tidyr::pivot_longer(
      cols = 2:(ncol(df) + 1), names_to = "age_group", values_to = "births"
    ) |>
    dplyr::mutate(
      age_group = factor(
        x = age_group, 
        levels = c(
          "<15", "15-19", "20-24", "25-29",
          "30-34", "35-39", "40-44", "45+", "Not Stated"
        )
      ),
      births = as.integer(births)
    ) |>
    tidyr::complete(year)

  df
}
