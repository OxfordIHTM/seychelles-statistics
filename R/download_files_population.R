#'
#' Download population and vital statistics bulletins by year
#' 
#' @param download_census_documents_links A data.frame for population and vital
#'   statistics documents downloads
#' @param src
#' @param file_type
#' @param path Directory to save downloaded file/s into. If NULL, path is
#'   set to a [tempdir()].
#'   
#'

download_files_census <- function(download_census_documents_links,
                                  src = NULL,
                                  file_type = NULL,
                                  path = NULL) {
  if (is.null(src)) {
    if (is.null(file_type)) {
      download_links <- download_census_documents_links
    } else {
      download_links <- download_census_documents_links |>
        dplyr::filter(
          stringr::str_detect(string = filename, pattern = file_type)
        )
    }
  } else {
    download_links <- download_census_documents_links |>
      dplyr::filter(stringr::str_detect(string = name, pattern = src))

    if (is.null(file_type)) {
      download_links <- download_links
    } else {
      download_links <- download_links |>
        dplyr::filter(
          stringr::str_detect(string = filename, pattern = file_type)
        )
    }
  }
  
  ## Create download filenames
  download_file_names <- download_links$filename
  
  if (is.null(path)) {
    destfile <- file.path(tempdir(), download_file_names)
  } else {
    destfile <- file.path(path, download_file_names)
  }
  
  Map(
    f = download.file,
    url = download_links$url,
    destfile = destfile
  )
  
  tibble::tibble(
    download_links, 
    file_path = destfile
  )
}


