# Project build script ---------------------------------------------------------

## Load packages and load project-specific functions in R folder ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Set build options ----


## Targets ----

data_download <- tar_plan(
  tar_target(
    name = download_map_files,
    command = download_maps(),
    format = "file"
  ),
  ### Get download categories list of links ---- 
  tar_target(
    name = download_categories_links,
    command = get_download_category_links(url = "https://www.nbs.gov.sc/downloads")
  ),
  ### Census data ----
  tar_target(
    name = download_census_documents_links,
    command = get_download_census_links(url = download_categories_links$url[1])
  ),
  tar_target(
    name = download_census_documents_files,
    command = download_files_census(
      download_census_documents_links,
      src = "Estimate|estimate|End|Mid|Abridged|Vital Statistics", 
      file_type = "pdf|PDF",
      path = "pdf"
    )
  ),
  midyear_pop_census_files = get_mid_population_file_path(download_census_documents_files),
  midyear_pop_census_pages = c(8, 10, 10, 10, 11, 13, 11, 11),
  midyear_pop_district_census_pages = c(14, 16, 17, 17, 18, 14, 14, 13)
)


## Extract tables
data_targets <- tar_plan(
  tar_target(
    name = map_adm0,
    command = sf::st_read(dsn = "maps", layer = "syc_admbnda_adm0_nbs2010")
  ),
  tar_target(
    name = map_adm1,
    command = sf::st_read(dsn = "maps", layer = "syc_admbnda_adm1_nbs2010")
  ),
  tar_target(
    name = map_adm2,
    command = sf::st_read(dsn = "maps", layer = "syc_admbnda_adm2_nbs2010")
  ),
  tar_target(
    name = map_adm3,
    command = sf::st_read(dsn = "maps", layer = "syc_admbnda_adm3_nbs2010")
  ),
  tar_target(
    name = midyear_pop_by_age_sex,
    command = extract_midyear_pop(
      pdf = midyear_pop_census_files,
      page = midyear_pop_census_pages
    ),
    pattern = map(midyear_pop_census_files, midyear_pop_census_pages)
  ),
  tar_target(
    name = midyear_pop_by_age_district,
    command = extract_midyear_pop_district(
      pdf = midyear_pop_census_files,
      page = midyear_pop_district_census_pages
    ),
    pattern = map(midyear_pop_census_files, midyear_pop_district_census_pages)
  )
)


## Read raw data
raw_data <- tar_plan(
)


## Process data
processed_data <- tar_plan(
  ##
)


## Analysis
analysis <- tar_plan(
  ##
)


## Outputs
outputs <- tar_plan(
  tar_target(
    name = midyear_pop_by_age_sex_csv,
    command = create_csv_data(
      x = midyear_pop_by_age_sex,
      dest = "data/population_by_age_sex.csv"
    )
  )
)


## Reports
reports <- tar_plan(
  ##
)

## Deploy targets
deploy <- tar_plan(
  ##
)

## Set seed
set.seed(1977)

## Concatenate targets ----
all_targets()
