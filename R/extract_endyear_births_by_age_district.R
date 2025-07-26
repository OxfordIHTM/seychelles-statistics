#'
#' Extract endyear births by district
#' 

extract_births_by_age_district <- function(bulletin_text, page) {
  year <- names(bulletin_text) |>
    stringr::str_extract(pattern = "[0-9]{4}")

  df_text <- bulletin_text[[1]]

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
    (\(x) x[ , 1:(ncol(x) - 1)])()

  if (!year %in% c(2021, 2024)) {
    df <- df |>
      dplyr::mutate(`Not Stated` = 0L)
  }

  df <- df |>
    setNames(
      nm = c(
        "district", "<15", "15-19", "20-24", "25-29",
        "30-34", "35-39", "40-44", "45+", "Not Stated"
      )
    ) |>
    dplyr::mutate(
      dplyr::across(
        .cols = 2:ncol(df), 
        .fns = function(x) {
          ifelse(x == "-", 0, x) |>
            as.integer()
        }
      )
    ) |>
    dplyr::mutate(year = as.integer(year), .before = district) |>
    tidyr::pivot_longer(
      cols = 3:(ncol(df) + 1), names_to = "age_group", values_to = "births"
    ) |>
    dplyr::mutate(
      age_group = factor(
        x = age_group, 
        levels = c(
          "<15", "15-19", "20-24", "25-29",
          "30-34", "35-39", "40-44", "45+", "Not Stated"
        )
      )
    ) |>
    dplyr::mutate(
      district = dplyr::case_when(
        district == "La Digue & Inner Islands" ~ "La Digue and Inner Islands",
        district == "La Digue & Inner Islands" ~ "La Digue and Inner Islands",
        district == "Perseverance" ~ "Ile Perseverance",
        .default = district
      ) |>
        factor(levels = c(districts, "Not Stated"))
    ) |>
    tidyr::complete(year, district, age_group)

  df
}

#'
#' List of districts
#' 

districts <- c(
  "Anse Aux Pins", "Anse Boileau", "Anse Etoile", "Anse Royale",
  "Au Cap", "Baie Lazare", "Baie Sainte Anne", "Beau Vallon", "Bel Air",
  "Belombre", "Cascade", "English River", "Glacis", "Grand Anse Mahe",
  "Grand Anse Praslin", "Ile Perseverance", "La Digue and Inner Islands",
  "Les Mamelles", "Mont Buxton", "Mont Fleuri", "Other Islands", "Plaisance",
  "Pointe Larue", "Port Glaud", "Roche Caiman", "Saint Louis", "Takamaka"
)