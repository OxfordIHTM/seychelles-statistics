#'
#' Extract end year deaths by age and sex
#' 

extract_endyear_deaths <- function(pdf, page) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^Under", x = df)
  end_line <- grep(pattern = "^85\\+", x = df)

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    (\(x) x[x != ""])() 

  if (year == 2016) {
    df <- df |>
      stringr::str_replace_all(pattern = "\\s{40,50}", replacement = ",,,") |>
      stringr::str_replace_all(pattern = "\\s{23,30}", replacement = ",,") |>
      stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
      stringr::str_split(pattern = ",", simplify = TRUE) |>
      data.frame()
  }

  if (year == 2017) {
    df <- df |>
      stringr::str_replace_all(pattern = "\\s{35,40}", replacement = ",,") |>
      stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
      stringr::str_split(pattern = ",", simplify = TRUE) |>
      data.frame()
  }

  if (year %in% c(2018, 2019, 2020, 2021, 2023, 2024)) {
    df <- df |>
      stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
      stringr::str_split(pattern = ",", simplify = TRUE) |>
      data.frame()    
  }

  df <- df |>
    dplyr::filter(X1 != "") |>
    (\(x) x[ , c(1, (ncol(x) - 1):ncol(x))])() |>
    setNames(nm = c("age_group", "male", "female")) |>
    dplyr::mutate(
      age_group = stringr::str_replace(
        string = age_group, pattern = " - | ‐ |‐", replacement = "-"
      ) |>
        stringr::str_replace(pattern = "Under ", replacement = "<"),
      male = as.integer(male),
      female = as.integer(female),
      both = male + female
    ) |>
    dplyr::mutate(year = as.character(year), .before = age_group) |>
    tidyr::pivot_longer(
      cols = male:both, names_to = "sex", values_to = "death"
    ) |>
    dplyr::mutate(
      age_group = factor(
        x = age_group, 
        levels = c(
          "<1", "1-4", "5-9", "10-14", "15-19", "20-24",
          "25-29", "30-34", "35-39", "40-44", "45-49", "50-54",
          "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+"
        )
      ),
      sex = factor(x = sex, levels = c("female", "male", "both"))
    ) |>
    dplyr::arrange(year, sex, age_group)

  df
}


                                      