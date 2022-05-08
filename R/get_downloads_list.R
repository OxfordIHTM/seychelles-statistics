################################################################################
#
#'
#' Get downloads manifest
#' 
#' @param url Base url for the Seychelles NBS downloads page. Default to
#'   "https://nbs.gov.sc/downloads"
#'
#'
#
################################################################################

get_downloads_manifest <- function(url = "https://nbs.gov.sc/downloads") {
  base_url <- "https://nbs.gov.sc"
  
  links <- rvest::read_html(url) |>
    rvest::html_elements(".edocman-category-title-link") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0(base_url, x))()
  
  if (length(links) == 1) {
    if (links == base_url) {
      links <- rvest::read_html(url) |>
        rvest::html_elements(".edocman-document-title-link") |>
        rvest::html_attr(name = "href") |>
        (\(x) paste0(base_url, x))()
    }
  }
  
  if (dirname(url) != "downloads") {
    links <- rvest::read_html(url) |>
      rvest::html_elements(".edocman-category-title-link") |>
      rvest::html_attr(name = "href") |>
      (\(x) paste0(base_url, x))()
    
    if (length(links) == 1) {
      if (links == base_url) {
        links <- rvest::read_html(url) |>
          rvest::html_elements(".edocman-document-title-link") |>
          rvest::html_attr(name = "href") |>
          (\(x) paste0(base_url, x))()
      }
    }
  }
  
  links
}


################################################################################
#
#'
#' Get population and vital statistics downloads list
#' 
#' @param download_list A vector of URL links of the NBS downloads page. 
#'
#'
#
################################################################################

get_downloads_population <- function(download_list) {
  get_downloads_manifest(url = download_list[1]) |> 
    (\(x) get_downloads_manifest(x[1]))()
}