#'
#' Extract midyear population from PDF files
#' 

extract_midyear_pop <- function(pdf, page, total = FALSE) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |> 
    unlist() |> 
    (\(x) x[seq(from = grep(pattern = "^\\s{1,}0\\s{1,}", x = x), to = grep(pattern = "^\\s{1,}30-34\\s{1,}|^\\s{1,}30‐34\\s{1,}", x = x), by = 1)])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",") |>
    stringr::str_replace_all(pattern = "\\s{1,}", replacement = ",") |>
    (\(x) x[x != ""])() |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    (\(x) rbind(x[ , 1:4], x[ , 5:8], x[ , 9:12]))() |>
    data.frame() |>
    dplyr::filter(X1 != "") 
  
  if (total) {
    df <- df |>
      (\(x) x[ , c(1, 4)])() |>
      stats::setNames(nm = c("age", "population")) |>
      dplyr::filter(stringr::str_detect(age, pattern = "^[0-9]{1,2}$|\\+")) |>
      dplyr::mutate(
        year = as.integer(year), .before = age,
        population = as.integer(population)
      ) |>
      tibble::as_tibble()
  } else {
    df <- df |>
      (\(x) x[ , 1:3])() |>
      stats::setNames(nm = c("age", "male", "female")) |>
      dplyr::filter(stringr::str_detect(age, pattern = "^[0-9]{1,2}$|\\+")) |>
      dplyr::mutate(
        male = suppressWarnings(as.integer(male)) |>
          (\(x) ifelse(is.na(x), -3, x))(),
        female = as.integer(female)
      ) |>
      dplyr::mutate(year = as.integer(year), .before = age) |>
      tidyr::pivot_longer(
        cols = male:female, names_to = "sex", values_to = "population"
      ) |>
      dplyr::mutate(
        sex = stringr::str_to_sentence(sex) |>
          factor(levels = c("Female", "Male")),
        population = as.integer(population)
      )
  }

  df <- df |>
    dplyr::mutate(
      age = factor(x = age, levels = c(0:99, "90+", "95+", "100+"))
    )
  
  if (total) {
    df <- df |>
      dplyr::arrange(year, age)
  } else {
    df <- df |>
      dplyr::arrange(year, sex, age)
  }
  
  df
}

