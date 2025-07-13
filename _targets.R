# Project build script ---------------------------------------------------------

## Load packages and load project-specific functions in R folder ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Set build options ----


## Targets ----

data_download <- tar_plan(
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
  mid_population_census_files = get_mid_population_file_path(download_census_documents_files),
  mid_population_census_pages = c(8, 10, 10, 10, 11, 13, 11, 11)
)


## Extract tables
extract_tables <- tar_plan(
  tar_target(
    name = population_by_age_sex,
    command = extract_midyear_pop(
      pdf = mid_population_census_files,
      page = mid_population_census_pages
    ),
    pattern = map(mid_population_census_files, mid_population_census_pages)
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
    name = population_by_age_sex_csv,
    command = create_csv_data(
      x = population_by_age_sex,
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
