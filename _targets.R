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
    (\(x) download_files_path_population$file_path[x])(),
  download_files_path_population_2021 = download_files_population(
    download_list_population, year = "2021", path = "pdf"
  ),
  download_file_path_midyear_2021 = download_files_path_population_2021 |>
    (\(x) x$file_name)() |>
    stringr::str_detect(pattern = "mid") |> 
    (\(x) download_files_path_population_2021$file_path[x])(),
  download_file_path_endyear_2021 = download_files_path_population |>
    (\(x) x$file_name)() |>
    stringr::str_detect(pattern = "end") |> 
    (\(x) download_files_path_population_2021$file_path[x])()
)


## Extract tables
extract_tables <- tar_plan(
  extracted_tables_midyear_2021 = extract_tables_pdf(
    filename = download_file_path_midyear_2021
  ),
  extracted_tables_endyear_2021 = extract_tables_pdf(
    filename = download_file_path_endyear_2021
  )
)


## Read raw data
raw_data <- tar_plan(
  ##
  raw_midyear_demo_2021 = structure_midyear_demo_2021(
    extracted_tables_midyear_2021[[8]]
  ),
  raw_endyear_demo_2021 = structure_endyear_demo_2021(
    extracted_tables_endyear_2021[[7]]
  ),
  raw_midyear_pop_change_2021 = structure_midyear_pop_change_2021(
    extracted_tables_midyear_2021[[9]]
  ),
  raw_endyear_pop_change_2021 = structure_endyear_pop_change_2021(
    extracted_tables_endyear_2021[[10]]
  ),
  raw_endyear_demo_rates_2021 = structure_endyear_demo_rates_2021(
    extracted_tables_endyear_2021[[8]]
  ),
  raw_midyear_population_by_age_2021 = structure_midyear_population_by_age_2021(
    extracted_tables_midyear_2021[[11]]
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
  raw_midyear_demo_2021_csv = write.csv(
    x = raw_midyear_demo_2021, 
    file = "data/midyear_demographics_2021.csv", 
    row.names = FALSE
  ),
  raw_endyear_demo_2021_csv = write.csv(
    x = raw_endyear_demo_2021,
    file = "data/endyear_demographics_2021.csv",
    row.names = FALSE
  ),
  raw_midyear_pop_change_2021_csv = write.csv(
    x = raw_midyear_pop_change_2021,
    file = "data/midyear_population_change_2021.csv",
    row.names = FALSE
  ),
  raw_endyear_pop_change_2021_csv = write.csv(
    x = raw_endyear_pop_change_2021,
    file = "data/endyear_population_change_2021.csv",
    row.names = FALSE
  ),
  raw_midyear_population_by_age_2021_csv = write.csv(
    x = raw_midyear_population_by_age_2021,
    file = "data/midyear_population_by_age_2021.csv",
    row.names = FALSE
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