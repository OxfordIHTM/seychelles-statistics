#'
#' Extract endyear births by district
#' 

extract_births_by_district <- function(page, pdf) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^District", x = df) + 1
  end_line <- grep(pattern = "^Total", x = df) - 1

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_remove(pattern = "\\([0-9]{1,2}\\)|\\( [0-9]{1,2}\\)") |>
    (\(x) x[x != ""])() |>
    stringr::str_replace(pattern = "\\s{50,}", replacement = ",0,0,0,0,0,0,0,0,") |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame() |>
    (\(x) x[ , c(1, ncol(x))])()

  df <- df |>
    setNames(nm = c("district", "births")) |>
    dplyr::mutate(year = as.integer(year), .before = district) |>
    dplyr::mutate(
      district = dplyr::case_when(
        district == "La Digue & Inner Islands" ~ "La Digue and Inner Islands",
        district == "La Digue & Inner Islands" ~ "La Digue and Inner Islands",
        district == "Perseverance" ~ "Ile Perseverance",
        .default = district
      ) |>
        factor(levels = c(districts, "Not Stated"))
    ) |>
    tidyr::complete(year, district)

  df
}
