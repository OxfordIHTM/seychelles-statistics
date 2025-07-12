################################################################################
#
#'
#' Extract tables given a PDF file
#'
#' @param file_path path to PDF file to extract text or data from
#'
#' @return A vector or list of PDF text or data
#' 
#' @rdname extract_pdf
#'
#
################################################################################

extract_pdf_text <- function(file_path) {
  suppressMessages(
    pdftools::pdf_text(file_path)
  )
}

#'
#' @rdname extract_pdf
#'

extract_pdfs_text <- function(file_path) {
  lapply(
    X = file_path,
    FUN = extract_pdf_text
  ) |>
    (\(x) 
      { 
        names(x) <- basename(file_path) |> 
          stringr::str_remove_all(pattern = ".pdf")
        x
      }
    )()
}

#'
#' @rdname extract_pdf
#'

extract_pdf_data <- function(file_path) {
  suppressMessages(
    pdftools::pdf_data(file_path)
  )
}

#'
#' @rdname extract_pdf
#'

extract_pdfs_data <- function(file_path) {
  lapply(
    X = file_path,
    FUN = extract_pdf_data
  ) |>
    (\(x) 
     { 
       names(x) <- basename(file_path) |> 
         stringr::str_remove_all(pattern = ".pdf")
       x
    }
    )()
}