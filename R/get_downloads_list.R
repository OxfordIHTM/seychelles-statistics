#'
#' Get download links
#' 
#' @param url Base url for the Seychelles NBS downloads page. Default to
#'   "https://nbs.gov.sc/downloads"
#'   
#' @return A list of URLs
#' 
#' @examples
#' get_download_links() 
#'
#' @rdname get_download
#'

get_download_category_links <- function(url) {
  base_url <- "https://www.nbs.gov.sc"
  current_session <- rvest::session(url)

  current_elements <- current_session |>
    rvest::html_elements(".edocman-category-title-link")

  if (length(current_elements) != 0) {
    labs <- current_elements |>
      rvest::html_text() |>
      trimws()

    links <- current_elements |>
      rvest::html_attr(name = "href") |>
      (\(x) paste0(base_url, x))()
    
    links <- data.frame(
      name = labs,
      url = links,
      is_folder = TRUE
    )
  } else {
    links <- NULL
  }

  links
}

#'
#' @rdname get_download
#' 

get_download_document_links <- function(url) {
  base_url <- "https://www.nbs.gov.sc"

  current_session <- rvest::session(url)

  current_elements <- current_session |>
    rvest::html_elements(".edocman-document-title-link")

  if (length(current_elements) != 0) {
    labs <- current_elements |>
      rvest::html_text() |>
      trimws()

    links <- current_elements |>
      rvest::html_attr(name = "href") |>
      (\(x) paste0(base_url, x))()

    filenames <- links |>
      lapply(
        FUN = function(x) {
          h <- httr::HEAD(x) |>
            httr::headers()
          h$`content-disposition` |>
            stringr::str_split(pattern = "; ", simplify = TRUE) |>
            (\(x) x[1, 2])() |>
            stringr::str_remove_all(pattern = 'filename=|\\"')
        }
      ) |>
      unlist()

    links <- tibble::tibble(
      name = labs,
      filename = filenames,
      url = links,
      is_folder = FALSE
    )
  } else {
    links <- NULL
  }
  
  links
}

#'
#' @rdname get_download
#' 

get_download_census_links <- function(url) {
  category_links <- get_download_category_links(url = url)
  document_links <- get_download_document_links(url = url)

  ## GIS maps ----
  gis_map_links <- get_download_document_links(url = category_links$url[1])
  pop_stats_links <- get_download_category_links(url = category_links$url[2]) |>
    (\(x) x$url)() |>
    lapply(FUN = get_download_document_links) |>
    dplyr::bind_rows()

  rbind(gis_map_links, pop_stats_links, document_links)
}


