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
  base_url <- dirname(url)

  current_session <- rvest::session(url)

  current_elements <- current_session |>
    rvest::html_elements(".edocman-category-title-link")

  if (length(current_elements) != 0) {
    labs <- current_elements |>
      rvest::html_text() #|>
      # stringr::str_remove_all(
      #   pattern = "\\( [0-9]{1,} Documents \\)|\\( [0-9]{1,} Document \\)"
      # ) |>
      # trimws()

    links <- current_elements |>
      rvest::html_attr(name = "href") |>
      (\(x) paste0(base_url, x))()
    
    names(links) <- labs
  } else {
    links <- NULL
  }

  links
}

#'
#' @rdname get_download
#' 

get_download_document_links <- function(url) {
  base_url <- dirname(url)

  current_session <- rvest::session(url)

  current_elements <- current_session |>
    rvest::html_elements(".edocman-document-title-link")

  if (length(current_elements) != 0) {
    labs <- current_elements |>
      rvest::html_text() #|>
      #trimws()

    links <- current_elements |>
      rvest::html_attr(name = "href") |>
      (\(x) paste0(base_url, x))()

    names(links) <- labs
  } else {
    links <- NULL
  }

  links
}


#'
#' @rdname get_download
#' 

get_download_links <- function(url = "https://nbs.gov.sc/downloads") {
  category_links <- get_download_category_links(url = url)
  document_links <- get_download_document_links(url = url)

  if (!is.null(category_links)) {
    for (i in seq_len(length(category_links))) {
      current_url <- category_links[i]
      get_download_links(url = current_url)
    }
  } else {
    links <- c(category_links, document_links)
  }

  links
}


#'
#' @rdname get_download
#'

get_download_census <- function(url) {
  x <- 
  
  y <- lapply(x$`Population and Vital Statistics`, get_download_links) |>
    lapply(utils::stack) |>
    dplyr::bind_rows(.id = "year") |>
    (\(x)
      data.frame(
        year = as.integer(x$year),
        name = as.character(x$ind),
        link = x$values
      )
    )()
  
  tibble::tibble(category = names(x), y)
}

