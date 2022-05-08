################################################################################
#
#'
#' Extract tables given a PDF file
#'
#' @param filename PDF file to extract tables from including path to file
#'
#
################################################################################

# extract_tables_pdf <- function(filename) {
#   tabulizer::extract_tables(file = filename)
# }

extract_tables_pdf <- function(filename) {
  pdftools::pdf_text(filename)
}
