#'
#' Download population and vital statistics bulletins by year
#' 
#' @param download_list_population List of URLs for population and vital
#'   statistics downloads
#' @param path Directory to save downloaded file/s into. If NULL, path is
#'   set to a tempdir().
#'   
#'

download_files_population <- function(download_population_list, 
                                      path = NULL) {
  ## Create download filenames
  download_file_names <- ifelse(
    stringr::str_detect(
      download_population_list$name, 
      pattern = "[0-9]{4}"
    ),
    stringr::str_split(
      download_population_list$link, pattern = "/", simplify = TRUE
    ) |>
      (\(x) x[ , 5])(),
    stringr::str_split(
      download_population_list$link, pattern = "/", simplify = TRUE
    ) |>
      (\(x) paste(x[ , 5], download_population_list$year, sep = "-"))()
  ) |>
    (\(x) paste0(x, ".pdf"))()
  
  if (is.null(path)) {
    destfile <- file.path(tempdir(), download_file_names)
  } else {
    destfile <- file.path(path, download_file_names)
  }
  
  Map(
    f = download.file,
    url = download_population_list$link,
    destfile = destfile
  )
  
  tibble::tibble(
    download_population_list, 
    file_path = destfile
  )
}


