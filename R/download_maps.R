#'
#' Download Seychelles maps
#' 

download_unzip_maps <- function(dest) {
  url <- "https://data.humdata.org/dataset/9ac1737f-cd33-4458-86e8-aec90eeffda2/resource/de3bca8b-f522-46ba-b4d2-e1c52034fcc0/download/syc_adm_nbs2010_shp.zip"

  download_dir <- tempdir()
  download_path <- file.path(download_dir, "sc_maps.zip")

  download.file(url = url, destfile = download_path)

  unzip(download_path, overwrite = TRUE, exdir = dest)

  dest
}

