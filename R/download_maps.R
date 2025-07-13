#'
#' Download Seychelles maps
#' 

download_maps <- function(dest= tempdir()) {
  url <- "https://data.humdata.org/dataset/9ac1737f-cd33-4458-86e8-aec90eeffda2/resource/de3bca8b-f522-46ba-b4d2-e1c52034fcc0/download/syc_adm_nbs2010_shp.zip"

  download.file(
    url = url, destfile = file.path(dest, "sc_maps.zip")
  )

  file.path(dest, "sc_maps.zip")
}

