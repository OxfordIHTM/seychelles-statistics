#'
#' Extract per district midyear population
#' 

extract_midyear_pop_district <- function(pdf, page) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  df_text <- suppressMessages(pdftools::pdf_text(pdf = pdf))

  df <- df_text |>
    (\(x) x[[page]])() |>
    stringr::str_split(pattern = "\n") |>
    unlist()

  start_line <- grep(pattern = "^District", x = df) + 1

  end_line1 <- grep(pattern = "^Takamaka", x = df)
  end_line2 <- grep(pattern = "^Grand Total", x = df)
  end_line <- ifelse(length(end_line2) == 0, end_line1, end_line2 - 1)

  df <- df |>
    (\(x) x[start_line:end_line])() |>
    stringr::str_trim() |>
    stringr::str_remove_all(pattern = ",|\\([0-9]{1}\\)") |>
    stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
    (\(x) x[stringr::str_detect(string = x, pattern = "Total", negate = TRUE)])() |>
    (\(x) x[x != ""])() |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame() |>
    (\(x) x[ , c(1, ncol(x))])() |>
    setNames(nm = c("district", "total"))

  if (any(c("Perseverance", "Ile Perseverance") %in% df$district)) {
    perseverance <- df_text |>
      (\(x) x[[page]])() |>
      stringr::str_split(pattern = "\n") |>
      unlist() |>
      (\(x) x[grep(pattern = "^Perseverance|^Ile", x = x)])() |>
      stringr::str_trim() |>
      stringr::str_remove_all(pattern = ",") |>
      stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
      stringr::str_split(pattern = ",", simplify = TRUE) |>
      data.frame() |>
      (\(x) x[ , c(1, ncol(x))])() |>
      setNames(nm = c("district", "total")) |>
      (\(x) x$total)()

    df$total[df$district %in% c("Perseverance", "Ile Perseverance")] <- perseverance
  }
  
  df <- df |>
    dplyr::mutate(
      district = ifelse(district == "Perseverance", "Ile Perseverance", district)
    )

  if ("Inner Islands" %in% df$district) {
    la_digue <- df_text |>
      (\(x) x[[page]])() |>
      stringr::str_split(pattern = "\n") |>
      unlist() |>
      (\(x) x[grep(pattern = "^\\s{2,}Inner Islands", x = x)])() |>
      stringr::str_trim() |>
      stringr::str_remove_all(pattern = ",") |>
      stringr::str_replace_all(pattern = "\\s{2,}", replacement = ",") |>
      stringr::str_split(pattern = ",", simplify = TRUE) |>
      data.frame() |>
      (\(x) x[ , c(1, ncol(x))])() |>
      setNames(nm = c("district", "total")) |>
      (\(x) x$total)()

    df <- df |>
      dplyr::mutate(total = ifelse(district == "Inner Islands", la_digue, total))
  }

  df <- df[df$total != "", ]

  df <- df |>
    dplyr::mutate(
      district = ifelse(
        stringr::str_detect(df$district, pattern = "La Digue|Inner Islands"),
        "La Digue and Inner Islands", district
      )
    ) |>
    dplyr::mutate(
      district = ifelse(
        district == "Baie Saint Anne", "Baie Sainte Anne", district
      )
    )

  df <- df |>
    dplyr::mutate(total = as.integer(total))
  
  if (!"Ile Perseverance" %in% df$district) {
    df <- rbind(
      df, data.frame(district = "Ile Perseverance", total = NA_integer_)
    )
  }

  df <- df |>
    dplyr::mutate(
      region = get_region(district) |>
        factor(
          levels = c(
            "North", "South", "East", "West", "Central", 
            "Praslin", "La Digue and Inner Islands", "Other Islands"
          )
        ), 
      .before = district
    ) |>
    dplyr::mutate(year = year, .before = region) |>
    arrange(region, district)

  df <- df |>
    dplyr::mutate(region = get_region(district))


  df
}