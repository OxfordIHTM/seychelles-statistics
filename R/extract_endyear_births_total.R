#'
#' Extract endyear births and deaths
#' 

extract_endyear_pop_births_deaths_total <- function(page, pdf, 
                                                type = c("population",
                                                         "births",
                                                         "deaths_all",
                                                         "deaths_infant")) {
  type <- match.arg(type)

  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

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

  if (type == "population") {
    df <- df |>
      (\(x) x[ , c(1:2)])()

    nm <- c("year", "population")
  }

  if (type == "births") {
    df <- df |>
      (\(x) x[ , c(1, 3)])()

    nm <- c("year", "births")
  }
  
  if (type == "deaths_all") {
    if (year %in% 2016:2017) {
      df <- df |>
        (\(x) x[ , c(1, 5)])()
    } else {
      df <- df |>
        (\(x) x[ , c(1, 4)])()
    }

    nm <- c("year", "deaths")
  }

  if (type == "deaths_infant") {
    if (year %in% 2016:2017) {
      df <- df |>
        (\(x) x[ , c(1, 7)])()
    } else {
      df <- df |>
        (\(x) x[ , c(1, 5)])()
    }
    
    nm <- c("year", "deaths_infant")
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
    setNames(nm = nm) |>
    dplyr::mutate(
      dplyr::across(.cols = dplyr::everything(), .fns = as.integer)
    )

  df
}