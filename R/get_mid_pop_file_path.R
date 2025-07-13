#'
#' Get mid year population files
#'

get_mid_population_file_path <- function(download_census_documents_files) {
  df <- download_census_documents_files |>
    dplyr::filter(stringr::str_detect(string = filename, pattern = "Mid")) |>
    dplyr::filter(
      stringr::str_detect(
        string = name, 
        pattern = "Abridged|Mid 2024 Estimated Resident Population$", 
        negate = TRUE
      )
    )
  
  df$file_path
}