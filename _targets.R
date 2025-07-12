# Project build script ---------------------------------------------------------

## Load packages and load project-specific functions in R folder ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Set build options ----


## Targets ----

### Downloads ----

download_data <- tar_plan(
  ## Get population and vital statistics downloads list
  download_population_list = get_download_census(),
  download_population_pdfs = download_files_population(
    download_population_list, path = "pdf"
  )
)


## Extract tables
extract_tables <- tar_plan(
  extracted_pdf_text = extract_pdfs_text(
    file_path = download_population_pdfs$file_path
  ),
  extracted_pdf_data = extract_pdfs_data(
    file_path = download_population_pdfs$file_path
  ),
  extracted_tables_midyear_2021 = extract_tables_pdf(
    filename = download_file_path_midyear_2021
  ),
  extracted_tables_data_midyear_2021 = extract_tables_data_pdf(
    filename = download_file_path_midyear_2021
  ),
  extracted_tables_data_midyear_2020 = extract_tables_data_pdf(
    filename = download_file_path_midyear_2020
  ),
  extracted_tables_data_midyear_2019 = extract_tables_data_pdf(
    filename = download_file_path_midyear_2019
  ),
  extracted_tables_data_midyear_2018 = extract_tables_data_pdf(
    filename = download_file_path_midyear_2018
  ),
  extracted_tables_data_midyear_2017 = extract_tables_data_pdf(
    filename = download_file_path_midyear_2017
  ),
  extracted_tables_endyear_2021 = extract_tables_pdf(
    filename = download_file_path_endyear_2021
  ),
  extracted_tables_data_endyear_2021 = extract_tables_data_pdf(
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
    extracted_tables_data_midyear_2021[[11]]
  ),
  raw_midyear_population_by_age_2020 = structure_midyear_population_by_age_2020(
    extracted_tables_data_midyear_2020[[10]]
  ),
  raw_midyear_population_by_age_2019 = structure_midyear_population_by_age_2019(
    extracted_tables_data_midyear_2019[[10]]
  ),
  raw_midyear_population_by_age_2018 = structure_midyear_population_by_age_2018(
    extracted_tables_data_midyear_2018[[10]]
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