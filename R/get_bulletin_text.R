#'
#' Get PDF bulletin text
#' 

get_bulletin_text <- function(pdf) {
  year <- stringr::str_extract(string = pdf, pattern = "[0-9]{4}")

  x <- suppressMessages(pdftools::pdf_text(pdf)) |>
    list() |>
    (\(x) { names(x) <- year; x})()

  x
}