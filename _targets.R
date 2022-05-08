################################################################################
#
# Project build script
#
################################################################################

# Load packages (in packages.R) and load project-specific functions in R folder
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


# Set build options ------------------------------------------------------------



# Groups of targets ------------------------------------------------------------

## Downloads
download_data <- tar_plan(
  ## Get downloads page list
  download_list = get_downloads_manifest(url = "https://nbs.gov.sc/downloads"),
  download_list_population = get_downloads_population(download_list),
  download_year_latest = basename(download_list_population) |> max(),
  download_files_path_population = download_files_population(
    download_list_population, year = download_year_latest, path = "pdf"
  ),
  download_file_path_midyear = download_files_path_population$file_name |> 
    stringr::str_detect(pattern = "mid") |> 
    (\(x) download_files_path_population$file_path[x])(),
  download_file_path_endyear = download_files_path_population$file_name |> 
    stringr::str_detect(pattern = "end") |> 
    (\(x) download_files_path_population$file_path[x])()
)


## Extract tables
extract_tables <- tar_plan(
  extracted_tables_midyear = extract_tables_pdf(
    filename = download_file_path_midyear
  ),
  extracted_tables_endyear = extract_tables_pdf(
    filename = download_file_path_endyear
  )
)


## Read raw data
raw_data <- tar_plan(
  ##
  raw_midyear_demo_2021 = structure_midyear_demo_2021(
    extracted_tables_midyear[[8]]
  ),
  raw_endyear_demo_2021 = structure_endyear_demo_2021(
    extracted_tables_endyear[[7]]
  )
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
  ##
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

# Concatenate targets ----------------------------------------------------------
list(
  download_data,
  extract_tables,
  raw_data,
  processed_data,
  analysis,
  outputs,
  reports,
  deploy
)