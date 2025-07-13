#'
#' Get end year population files
#'

get_end_population_file_path <- function(download_census_documents_files) {
  df <- download_census_documents_files |>
    dplyr::filter(stringr::str_detect(string = filename, pattern = "End"))
  
  df$file_path
}