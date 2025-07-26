#'
#' Extract endyear births and deaths
#' 

extract_endyear_deaths_total <- function(bulletin_text, page) {
  year <- names(bulletin_text) |>
    stringr::str_extract(pattern = "[0-9]{4}")

  df_text <- bulletin_text[[1]]

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^[0-9]{4}", x = df) |> min()
  #end_line <- grep(pattern = "^Source", x = df)
  end_line <- grep(pattern = "^[0-9]{4}", x = df) |> max()

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_remove(pattern = "\\([0-9]{1,2}\\)|\\( [0-9]{1,2}\\)") |>
    (\(x) x[x != ""])() |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame()
    

  if (year %in% 2016:2017) {
    df <- df |>
      (\(x) x[ , c(1, 2, 3, 5, 7)])()
  } else {
    df <- df |>
      (\(x) x[ , c(1, 2, 3, 4, 5)])()
  }

  if (year != 2016) {
    if (year == 2023) {
      df <- df |>
        dplyr::slice_tail(n = 2)    
    } else {
      df <- df |>
        dplyr::slice_tail(n = 1)
    }
  }

  df <- df |>
    setNames(
      nm = c("year", "population", "births", "deaths", "deaths_infant")
    ) |>
    dplyr::mutate(
      dplyr::across(.cols = year:deaths_infant, .fns = as.integer)
    )

  df
}