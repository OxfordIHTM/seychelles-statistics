# Project build script ---------------------------------------------------------

## Load packages and load project-specific functions in R folder ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Set build options ----


## Download targets ----

data_download_targets <- tar_plan(
  tar_target(
    name = map_download_files,
    command = download_unzip_maps(dest = "maps")
  ),
  ### Get download categories list of links ---- 
  tar_target(
    name = categories_download_links,
    command = get_download_category_links(url = "https://www.nbs.gov.sc/downloads")
  ),
  ### Census data ----
  tar_target(
    name = population_bulletin_download_links,
    command = get_download_census_links(url = categories_download_links$url[1])
  ),
  tar_target(
    name = population_bulletin_download_files,
    command = download_files_census(
      population_bulletin_download_links,
      src = "Estimate|estimate|End|Mid|Abridged|Vital Statistics", 
      file_type = "pdf|PDF",
      path = "pdf"
    )
  ),
  population_midyear_bulletin_files = get_mid_population_file_path(
    population_bulletin_download_files
  ),
  population_endyear_bulletin_files = get_end_population_file_path(
    population_bulletin_download_files
  ),
  tar_target(
    name = population_midyear_bulletin_text,
    command = get_bulletin_text(population_midyear_bulletin_files),
    pattern = map(population_midyear_bulletin_files)
  ),
  tar_target(
    name = population_endyear_bulletin_text,
    command = get_bulletin_text(population_endyear_bulletin_files),
    pattern = map(population_endyear_bulletin_files)
  ),
  tar_target(
    name = population_midyear_bulletin_pages,
    command = find_table_page_pop(
      bulletin_text = population_midyear_bulletin_text
    ),
    pattern = map(population_midyear_bulletin_text)
  ),
  tar_target(
    name = population_midyear_bulletin_district_pages,
    command = find_table_page_pop_district(
      bulletin_text = population_midyear_bulletin_text
    ),
    pattern = map(population_midyear_bulletin_text)
  ),
  tar_target(
    name = deaths_endyear_pages,
    command = find_table_page_death(
      bulletin_text = population_endyear_bulletin_text
    ),
    pattern = map(population_endyear_bulletin_text)
  ),
  tar_target(
    name = births_endyear_pages,
    command = find_table_page_birth(
      bulletin_text = population_endyear_bulletin_text
    ),
    pattern = map(population_endyear_bulletin_text)
  ),
  tar_target(
    name = births_endyear_monthly_pages,
    command = find_table_page_birth_month(
      bulletin_text = population_endyear_bulletin_text
    ),
    pattern = map(population_endyear_bulletin_text)
  ),
  tar_target(
    name = births_by_district_pages,
    command = find_table_page_birth_district(
      bulletin_text = population_endyear_bulletin_text
    ),
    pattern = map(population_endyear_bulletin_text)
  ),
  tar_target(
    name = births_by_birth_order_pages,
    command = find_table_page_birth_birth_order(
      bulletin_text = population_endyear_bulletin_text
    ),
    pattern = map(population_endyear_bulletin_text)
  )
)


## Data extraction targets ----

data_extraction_targets <- tar_plan(
  tar_target(
    name = map_adm0,
    command = sf::st_read(
      dsn = map_download_files, layer = "syc_admbnda_adm0_nbs2010"
    )
  ),
  tar_target(
    name = map_adm1,
    command = sf::st_read(
      dsn = map_download_files, layer = "syc_admbnda_adm1_nbs2010"
    )
  ),
  tar_target(
    name = map_adm2,
    command = sf::st_read(
      dsn = map_download_files, layer = "syc_admbnda_adm2_nbs2010"
    )
  ),
  tar_target(
    name = map_adm3,
    command = sf::st_read(
      dsn = map_download_files, layer = "syc_admbnda_adm3_nbs2010"
    )
  ),
  tar_target(
    name = population_midyear_by_age_sex,
    command = extract_midyear_pop(
      bulletin_text = population_midyear_bulletin_text,
      page = population_midyear_bulletin_pages,
      total = FALSE
    ),
    pattern = map(
      population_midyear_bulletin_text, population_midyear_bulletin_pages
    )
  ),
  tar_target(
    name = population_midyear_by_age,
    command = extract_midyear_pop(
      bulletin_text = population_midyear_bulletin_text,
      page = population_midyear_bulletin_pages,
      total = TRUE
    ),
    pattern = map(
      population_midyear_bulletin_text, population_midyear_bulletin_pages
    )
  ),
  tar_target(
    name = population_midyear_by_district,
    command = extract_midyear_pop_district(
      bulletin_text = population_midyear_bulletin_text,
      page = population_midyear_bulletin_district_pages,
      ref_map = map_adm3
    ),
    pattern = map(
      population_midyear_bulletin_text, 
      population_midyear_bulletin_district_pages
    )
  ),
  tar_target(
    name = population_midyear_total,
    command = extract_endyear_pop_births_deaths_total(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_pages,
      type = "population"
    ),
    pattern = map(population_endyear_bulletin_text, births_endyear_pages)
  ),
  tar_target(
    name = births_by_month,
    command = extract_endyear_births_monthly(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_monthly_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_endyear_monthly_pages
    )
  ),
  tar_target(
    name = births_by_sex,
    command = extract_endyear_births_by_sex(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_monthly_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_endyear_monthly_pages
    )
  ),
  tar_target(
    name = births_total,
    command = extract_endyear_pop_births_deaths_total(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_pages,
      type = "births"
    ),
    pattern = map(population_endyear_bulletin_text, births_endyear_pages)
  ),
  tar_target(
    name = births_by_age_district,
    command = extract_births_by_age_district(
      bulletin_text = population_endyear_bulletin_text,
      page = births_by_district_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_by_district_pages
    )
  ),
  tar_target(
    name = births_by_age,
    command = extract_births_by_age(
      bulletin_text = population_endyear_bulletin_text,
      page = births_by_district_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_by_district_pages
    )
  ),
  tar_target(
    name = births_by_district,
    command = extract_births_by_district(
      bulletin_text = population_endyear_bulletin_text,
      page = births_by_district_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_by_district_pages
    )
  ),
  tar_target(
    name = births_by_birth_order,
    command = extract_births_by_birth_order(
      bulletin_text = population_endyear_bulletin_text,
      page = births_by_birth_order_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_by_birth_order_pages
    )
  ),
  tar_target(
    name = births_by_age_birth_order,
    command = extract_births_by_age_birth_order(
      bulletin_text = population_endyear_bulletin_text,
      page = births_by_birth_order_pages
    ),
    pattern = map(
      population_endyear_bulletin_text, births_by_birth_order_pages
    )
  ),
  tar_target(
    name = deaths_by_age_sex,
    command = extract_endyear_deaths(
      bulletin_text = population_endyear_bulletin_text,
      page = deaths_endyear_pages
    ),
    pattern = map(population_endyear_bulletin_text, deaths_endyear_pages)
  ), 
  tar_target(
    name = deaths_total,
    command = extract_endyear_pop_births_deaths_total(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_pages,
      type = "deaths_all"
    ),
    pattern = map(population_endyear_bulletin_text, births_endyear_pages)
  ),
  tar_target(
    name = deaths_infant_total,
    command = extract_endyear_pop_births_deaths_total(
      bulletin_text = population_endyear_bulletin_text,
      page = births_endyear_pages,
      type = "deaths_infant"
    ),
    pattern = map(population_endyear_bulletin_text, births_endyear_pages)
  )
)


## Data processing targets ----

data_processing_targets <- tar_plan(
  
)


## Analysis targets ----

analysis_targets <- tar_plan(

)


## Outputs targets ----

outputs_targets <- tar_plan(
  tar_target(
    name = population_midyear_by_age_sex_csv,
    command = create_csv_data(
      x = population_midyear_by_age_sex,
      dest = "data/population_midyear_by_age_sex.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = population_midyear_by_age_csv,
    command = create_csv_data(
      x = population_midyear_by_age,
      dest = "data/population_midyear_by_age.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = population_midyear_by_district_csv,
    command = create_csv_data(
      x = population_midyear_by_district,
      dest = "data/population_midyear_by_district.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = population_midyear_total_csv,
    command = create_csv_data(
      x = population_midyear_total,
      dest = "data/population_midyear_total.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_month_csv,
    command = create_csv_data(
      x = births_by_month,
      dest = "data/births_by_month.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_sex_csv,
    command = create_csv_data(
      x = births_by_sex,
      dest = "data/births_by_sex.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_total_csv,
    command = create_csv_data(
      x = births_total,
      dest = "data/births_total.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_age_district_csv,
    command = create_csv_data(
      x = births_by_age_district,
      dest = "data/births_by_age_district.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_age_csv,
    command = create_csv_data(
      x = births_by_age,
      dest = "data/births_by_age.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_district_csv,
    command = create_csv_data(
      x = births_by_district,
      dest = "data/births_by_district.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_birth_order_csv,
    command = create_csv_data(
      x = births_by_birth_order,
      dest = "data/births_by_birth_order.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = births_by_age_birth_order_csv,
    command = create_csv_data(
      x = births_by_age_birth_order,
      dest = "data/births_by_age_birth_order.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = deaths_by_age_sex_csv,
    command = create_csv_data(
      x = deaths_by_age_sex,
      dest = "data/deaths_by_age_sex.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = deaths_total_csv,
    command = create_csv_data(
      x = deaths_total,
      dest = "data/deaths_total.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = deaths_infant_total_csv,
    command = create_csv_data(
      x = deaths_infant_total,
      dest = "data/deaths_infant_total.csv"
    ),
    format = "file"
  )
)


## Reports targets ----

reports_targets <- tar_plan(

)


## Handbook targets ----

handbook_targets <- tar_plan(

)


## Deploy targets ----

deploy_targets <- tar_plan(

)


## Set seed
set.seed(1977)


## Concatenate targets ----
all_targets()
