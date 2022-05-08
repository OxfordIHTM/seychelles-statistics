################################################################################
#
#'
#' Download population and vital statistics bulletins by year
#' 
#' @param download_list_population List of URLs for population and vital
#'   statistics downloads
#' @param year Year of population and vital statistics bulletins to be
#'   downloaded
#' @param path Directory to save downloaded file/s into. If NULL, path is
#'   set to a tempdir().
#'   
#'
#
################################################################################

download_files_population <- function(download_list_population, 
                                      year, path = NULL) {
  download_urls <- download_list_population|>
    stringr::str_detect(pattern = year) |>
    (\(x) download_list_population[x])() |>
    get_downloads_manifest()
  
  download_file_names <- stringr::str_split(
    download_urls, pattern = "/", simplify = TRUE
  ) |>
    (\(x) paste0(x[ , 5], ".pdf"))()
  
  if (is.null(path)) {
    destfile <- paste0(tempdir(), "/", download_file_names)
  } else {
    destfile <- paste0(path, "/", download_file_names)
  }
  
  Map(
    f = download.file,
    url = download_urls,
    destfile = destfile
  )
  
  tibble::tibble(download_file_names, destfile) |>
    (\(x) { names(x) <- c("file_name", "file_path"); x })()
}