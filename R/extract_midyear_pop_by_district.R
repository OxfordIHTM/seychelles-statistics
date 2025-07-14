#'
#' Extract per district midyear population
#' 

extract_midyear_pop_district <- function(pdf, page, ref_map) {
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
    setNames(nm = c("district", "population"))

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
      setNames(nm = c("district", "population")) |>
      (\(x) x$population)()

    df$population[df$district %in% c("Perseverance", "Ile Perseverance")] <- perseverance
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
      setNames(nm = c("district", "population")) |>
      (\(x) x$population)()

    df <- df |>
      dplyr::mutate(population = ifelse(district == "Inner Islands", la_digue, population))
  }

  df <- df[df$population != "", ]

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
    dplyr::mutate(population = as.integer(population))
  
  if (!"Ile Perseverance" %in% df$district) {
    df <- rbind(
      df, data.frame(district = "Ile Perseverance", population = NA_integer_)
    )
  }

  df <- df |>
    dplyr::mutate(
      district_alt = dplyr::case_when(
        district == "Ile Perseverance" ~ "Perseverance Island",
        district == "La Digue and Inner Islands" ~ "La Digue",
        .default = district
      )
    ) |>
    dplyr::left_join(
      y = ref_map |>
        sf::st_drop_geometry() |>
        dplyr::select(
          dplyr::starts_with("ADM1"), 
          dplyr::starts_with("ADM2"),
          dplyr::starts_with("ADM3")
        ),
      by = c("district_alt" = "ADM3_EN")
    ) |>
    dplyr::select(-district_alt, -dplyr::contains("TYPE")) |>
    dplyr::relocate(district:population, .after = ADM3_PCODE) |>
    setNames(
      nm = c(
        "island", "island_code", "region", "region_code", 
        "district_code", "district", "population"
      )
    ) |>
    dplyr::relocate(district, .before = district_code) |>
    dplyr::mutate(year = as.character(year), .before = island) |>
    dplyr::mutate(population = as.integer(population)) |>
    dplyr::arrange(year, island_code, region_code, district_code)

  tibble::as_tibble(df)
}