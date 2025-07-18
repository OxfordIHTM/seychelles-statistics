
# seystats: Curating Seychelles data and statistics from publicly-available sources

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
![seystats](https://img.shields.io/badge/version-0.0.0.9003-orange)
[![License for
code](https://img.shields.io/badge/license%20\(for%20code\)-GPL3.0-blue.svg)](https://opensource.org/licenses/gpl-3.0.html)
[![License for
text](https://img.shields.io/badge/license%20\(for%20writing\)-CC_BY_4.0-blue)](https://creativecommons.org/licenses/by/4.0/)
[![License for
data](https://img.shields.io/badge/license%20\(for%20data\)-CC0-blue)](https://creativecommons.org/public-domain/cc0/)
[![test
workflow](https://github.com/OxfordIHTM/seychelles-statistics/actions/workflows/test-workflow.yaml/badge.svg)](https://github.com/OxfordIHTM/seychelles-statistics/actions/workflows/test-workflow.yaml)
[![DOI](https://zenodo.org/badge/489512741.svg)](https://zenodo.org/badge/latestdoi/489512741)

This repository is a
[`docker`](https://www.docker.com/get-started)-containerised,
[`{targets}`](https://docs.ropensci.org/targets/)-based,
[`{renv}`](https://rstudio.github.io/renv/articles/renv.html)-enabled
[`R`](https://cran.r-project.org/) workflow for the `seystats` project
on curating Seychelles data and statistics from various
publicly-available sources.

## About the project

In 2022, the **Seychelles-Oxford Partnership** on research capacity
building leveraged the vast research experience and skills of University
of Oxford research partners for training and upskilling data analysts
from the Ministry of Health (MOH) Seychelles.

From this process, the partnership identified that while the Seychelles
is one of the few sub-Saharan African countries with efficient,
accurate, and comprehensive data collection and disaggregation across a
variety of sectors and across a variety of metrics, most of this data
are not in the format, shape, and structure that are ready for analysis.
A good amount of these rich data are still on paper or ledgers. For the
data that are electronic, they are either stored/distributed in formats
that are not readily readable by machines for analysis (e.g., portable
document format or PDF) or are in proprietary spreadsheet format
(i.e. Microsoft Excel) structured into presentational tables meant for
reports rather than for actual analysis.

It is from this context that the initial ideas and motivation around
this project began. The partnership involves mostly individuals whose
roles and responsibilities were related to health. As such, ad hoc plans
prioritised health-related data. During this time, rough and informal
plans were drawn as to how the various steps will be implemented and how
the different technologies required will be resourced. Alongside these,
ongoing capacity-building on data management and analysis related to
research continued continued within the partnership.

By 2025, three years on from the start of the partnership, very little
has progressed and has been implemented from these informal, ad hoc
plans whilst the partnership continued to more research
capacity-building focusing on other types of research skills
(e.g. qualitative research), on student placement projects for
University of Oxford Masters students, and other research efforts
(e.g. cancer screening, cancer awareness, cancer quality-of-care).
During this period and in all these activities, the same challenges and
issues related to data identified in 2022 keep propping up.

It is within this background that the `seystats` project is being
(re-)launched. The current motivation is to try to get moving in a more
productive direction on the ideas generated in 2022 and to be able to
demonstrate the stated advantages of data that is accessible,
persistent, and machine-readable/machine-actionable to catalysing
research efforts in Seychelles.

## Current sources of data

The project uses only officially-released publicly-available sources of
data on Seychelles. Such data are primarily sourced from Seychelles
government websites either as file downloads or data embedded onto the
webpages themselves. Other sources are official government publications
not released online.

Currently, the available datasets from `seystats` are from the
Seychelles [National Bureau of Statistics
(NBS)](https://www.nbs.gov.sc/) which provides
[downloads](https://www.nbs.gov.sc/downloads) of various official
statistics for/about Seychelles. This current release includes data from
the [NBS Statistical Bulletin on Population and Vital
Statistics](https://www.nbs.gov.sc/downloads/).

## Current available datasets

The currently available datasets from the `seystats` project are listed
and described in the table below.

| Description                                                           | Time Interval | Filename                              | Data URL                                                                                                              |
| :-------------------------------------------------------------------- | :------------ | :------------------------------------ | :-------------------------------------------------------------------------------------------------------------------- |
| Registered births by age of mother and birth order                    | Yearly        | births\_by\_age\_child\_number.csv    | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_age_child_number.csv)     |
| Registered births by age of mother and mother’s district of residence | Yearly        | births\_by\_age\_district.csv         | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_age_district.csv)         |
| Registered births by age of mother                                    | Yearly        | births\_by\_age.csv                   | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_age.csv)                  |
| Registered births by birth order                                      | Yearly        | births\_by\_child\_number.csv         | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_child_number.csv)         |
| Registered births by mother’s district of residence                   | Yearly        | births\_by\_district.csv              | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_district.csv)             |
| Registered births by month of birth registration                      | Monthly       | births\_by\_month.csv                 | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_month.csv)                |
| Registered births by sex of child                                     | Yearly        | births\_by\_sex.csv                   | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_sex.csv)                  |
| Registered births total                                               | Yearly        | births\_total.csv                     | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_total.csv)                   |
| Registered deaths by age and sex                                      | Yearly        | deaths\_by\_age\_sex.csv              | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/deaths_by_age_sex.csv)              |
| Registered deaths of infants total                                    | Yearly        | deaths\_infant\_total.csv             | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/deaths_infant_total.csv)            |
| Registered deaths total                                               | Yearly        | deaths\_total.csv                     | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/deaths_total.csv)                   |
| Population midyear by age and sex                                     | Yearly        | population\_midyear\_by\_age\_sex.csv | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/population_midyear_by_age_sex.csv)  |
| Population midyear by age                                             | Yearly        | population\_midyear\_by\_age.csv      | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/population_midyear_by_age.csv)      |
| Population midyear by district of residence                           | Yearly        | population\_midyear\_by\_district.csv | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/population_midyear_by_district.csv) |
| Population midyear total                                              | Yearly        | population\_midyear\_total.csv        | [file](https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/population_midyear_total.csv)       |

All available datasets can be found in the `data` folder of this
repository. Other modes of distribution (e.g. Dolthub SQL database,
Zenodo, Figshare, etc.) are currently in development and would be
available soon.

## Accessing the datasets

The datasets curated by `seystats` can be accessed through the following
methods:

### Forking and then cloning the project repository

[Fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)
a copy of the project repository into your own GitHub account then
[clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
your copy of the project repository into your local machine. This
requires a GitHub account and knowledge of git processes. This approach
will give you a copy of the entire repository of which the `data`
directory contains all the datasets listed above. This approach would be
ideal for those who would like to access the datasets but also would
like to potentially contribute to the source code for the curation of
the datasets.

### Manually download from GitHub

Go to the project repository, then to the `data` directory and then
select and click the dataset CSV file you want to download. On the upper
right hand corner you will see an downward pointing arrow icon. Click on
this icon to download the selected dataset CSV file.

### Programmatically download from GitHub

Using the data URL indicated in the table above, one can
programmatically download the dataset of interest using your choice of
programming tool.

In Terminal:

``` bash
curl -OL https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_age.csv
```

In R:

``` r
download.file(
  url = "https://raw.githubusercontent.com/OxfordIHTM/seystats/refs/heads/main/data/births_by_age.csv"
  destfile = "data/births_by_age.csv"
)
```

In the release version of `seystats`, we will be distributing the
datasets in repositories and archives that have more straightforward
user interfaces for downloading the datasets.

## Repository Structure

The project repository is structured as follows:

    seystats
        |-- .git-crypt/
        |-- .github/
        |-- auth/
        |-- data/
        |-- maps/
        |-- outputs/
        |-- pdf/
        |-- R/
        |-- renv
        |-- reports
        |-- schema/
        |-- _targets.R
        |-- .env
        |-- .gitattributes
        |-- .Rprofile
        |-- packages.R
        |-- renv.lock

  - `.git-crypt/` contains `git-crypt` software specific files to manage
    encryption of specific files and folders in the repository.

  - `.github` contains project testing and automated deployment of
    outputs workflows via continuous integration and continuous
    deployment (CI/CD) using Github Actions.

  - `auth` contains encrypted authentication keys used in this project.

  - `data/` contains comma-separated value (CSV) files of the various
    datasets curated by the project.

  - `maps/` contains Seychelles map data files downloaded by the
    workflow.

  - `outputs/` contains compiled reports and figures produced by the
    workflow.

  - `pdf/` contains PDF files downloaded by the workflow for data
    extraction.

  - `R/` contains R functions developed/created specifically for use in
    this project.

  - `renv/` contains `renv` package specific files and directories used
    by the package for maintaining R package dependencies within the
    project. The directory `renv/library`, is a library that contains
    all packages currently used by the project. This directory, and all
    files and sub-directories within it, are all generated and managed
    by the `renv` package. Users should not change/edit these manually.

  - `reports/` contains literate code for R Markdown and/or Quarto
    reports rendered in the workflow.

  - `schema/` contains `.sql` code used for creating and deploying the
    project SQL database in DoltHub.

  - `_targets.R` file defines the steps in the workflow’s data ingest,
    data processing, data outputs, and reporting pipeline.

  - `.env` is an encrypted file that contains environment variables used
    in this project.

  - `.gitattributes` file contains information used by `git-crypt` to
    determine which files and/or folders in the repository to encrypt.

  - `.Rprofile` file is a project R profile generated when initiating
    `renv` for the first time. This file is run automatically every time
    R is run within this project, and `renv` uses it to configure the R
    session to use the `renv` project library.

  - `packages.R` file lists out all R package dependencies required by
    the workflow.

  - `renv.lock` file is the `renv` lockfile which records enough
    metadata about every package used in this project that it can be
    re-installed on a new machine. This file is generated by the `renv`
    package and should not be changed/edited manually.

## Reproducibility

### R version

This project is built using `R 4.5.1`. To manage R versions, it is
recommended to use [`rig`](https://github.com/r-lib/rig) - an R
installation manager - to be able to install multiple versions of R and
switch between them as needed.

### R package dependencies

This project uses the `{renv}` framework to record R package
dependencies and versions. Packages and versions used are recorded in
`renv.lock` and code used to manage dependencies is in the `renv`
directory and other files in the root project directory.

On starting an R session in the working directory of this repository,
first run

``` r
renv::restore()
```

to install R package dependencies.

### Encryption

This project uses encrypted environment variables and authentication
keys for data retrieval managed using
[`git-crypt`](https://github.com/AGWA/git-crypt). Collaborators will
need to [install `git-crypt`](https://github.com/AGWA/git-crypt) and
then provide their GPG key to the authors to be added as an authorised
user within the repository. To get a GPG key, [download and install
GPG](https://www.gnupg.org/download/) and then [generate your GPG key
pair](https://www.gnupg.org/gph/en/manual/c14.html). Then provide your
GPG key id to the authors.

Once given permission into the project and GPG key id added to the
repository, update your local version of the repository by doing a `git
pull` and then unlock the encrypted files/folders of the repository by
running the following command in Terminal from within the project
directory:

``` bash
git-crypt unlock
```

The encrypted components of the repository will now be decrypted and
accessible for running the workflow (described below).

### The workflow

The current workflow has the following steps:

``` mermaid
graph LR
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Graph
    direction LR
    x39c53f3806f354bf(["births_by_district_pages"]):::skipped --> xb5d471b223f71093["births_by_age"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> xb5d471b223f71093["births_by_age"]:::skipped
    xd7ed52d5505f1301(["births_by_child_number_pages"]):::skipped --> xdb9387a71d9afb77["births_by_age_child_number"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> xdb9387a71d9afb77["births_by_age_child_number"]:::skipped
    xdb9387a71d9afb77["births_by_age_child_number"]:::skipped --> x37b1525401441d9f(["births_by_age_child_number_csv"]):::skipped
    xb5d471b223f71093["births_by_age"]:::skipped --> xbbabd51f8df64492(["births_by_age_csv"]):::skipped
    x39c53f3806f354bf(["births_by_district_pages"]):::skipped --> x4094d4f6d0f8f35a["births_by_age_district"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x4094d4f6d0f8f35a["births_by_age_district"]:::skipped
    x4094d4f6d0f8f35a["births_by_age_district"]:::skipped --> x11faadcda3280dc2(["births_by_age_district_csv"]):::skipped
    xd7ed52d5505f1301(["births_by_child_number_pages"]):::skipped --> x816c05a21a018486["births_by_child_number"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x816c05a21a018486["births_by_child_number"]:::skipped
    x816c05a21a018486["births_by_child_number"]:::skipped --> x0fb17a50aa9b7bc4(["births_by_child_number_csv"]):::skipped
    x39c53f3806f354bf(["births_by_district_pages"]):::skipped --> x0c2c53d9eeb365ed["births_by_district"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x0c2c53d9eeb365ed["births_by_district"]:::skipped
    x0c2c53d9eeb365ed["births_by_district"]:::skipped --> x45f5b18e27a4d0fe(["births_by_district_csv"]):::skipped
    x5c7646da106bc2f6(["births_endyear_monthly_pages"]):::skipped --> x2c584c9caafc1be8["births_by_month"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x2c584c9caafc1be8["births_by_month"]:::skipped
    x2c584c9caafc1be8["births_by_month"]:::skipped --> xa87bb9563f27e00c(["births_by_month_csv"]):::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x1e485a7f2384826f["births_by_sex"]:::skipped
    x5c7646da106bc2f6(["births_endyear_monthly_pages"]):::skipped --> x1e485a7f2384826f["births_by_sex"]:::skipped
    x1e485a7f2384826f["births_by_sex"]:::skipped --> xa6b75ce42a7aa79e(["births_by_sex_csv"]):::skipped
    xe648a7801cd2da2c(["births_endyear_pages"]):::skipped --> x2f4500c2756065a9["births_total"]:::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x2f4500c2756065a9["births_total"]:::skipped
    x2f4500c2756065a9["births_total"]:::skipped --> xd95928afea598d8e(["births_total_csv"]):::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> xae333981c466810a["deaths_by_age_sex"]:::skipped
    x344a2780ffaeb7bd(["deaths_endyear_pages"]):::skipped --> xae333981c466810a["deaths_by_age_sex"]:::skipped
    xae333981c466810a["deaths_by_age_sex"]:::skipped --> xaf8165dda7ea936b(["deaths_by_age_sex_csv"]):::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x1d5c00f1e4e41ab7["deaths_infant_total"]:::skipped
    xe648a7801cd2da2c(["births_endyear_pages"]):::skipped --> x1d5c00f1e4e41ab7["deaths_infant_total"]:::skipped
    x1d5c00f1e4e41ab7["deaths_infant_total"]:::skipped --> x548dbfa0844427dc(["deaths_infant_total_csv"]):::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> xfd0ff0d9529d4bbd["deaths_total"]:::skipped
    xe648a7801cd2da2c(["births_endyear_pages"]):::skipped --> xfd0ff0d9529d4bbd["deaths_total"]:::skipped
    xfd0ff0d9529d4bbd["deaths_total"]:::skipped --> xe42488d3267f69ff(["deaths_total_csv"]):::skipped
    x8e509dc7997a12f8(["map_download_files"]):::skipped --> x4851b2941f7c62fc(["map_adm0"]):::skipped
    x8e509dc7997a12f8(["map_download_files"]):::skipped --> xccb26dd891c9a035(["map_adm1"]):::skipped
    x8e509dc7997a12f8(["map_download_files"]):::skipped --> x30d02f8bff8e7f8d(["map_adm2"]):::skipped
    x8e509dc7997a12f8(["map_download_files"]):::skipped --> x7b26bed1fc581742(["map_adm3"]):::skipped
    x90a781ac8daf46c6(["population_bulletin_download_links"]):::skipped --> x303dcb35f327bc97(["population_bulletin_download_files"]):::skipped
    xa7b0e3bf1c25b597(["categories_download_links"]):::skipped --> x90a781ac8daf46c6(["population_bulletin_download_links"]):::skipped
    x303dcb35f327bc97(["population_bulletin_download_files"]):::skipped --> xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped
    x303dcb35f327bc97(["population_bulletin_download_files"]):::skipped --> x52e965cb7c1cd1fc(["population_midyear_bulletin_files"]):::skipped
    x52e965cb7c1cd1fc(["population_midyear_bulletin_files"]):::skipped --> x946771421caaa150["population_midyear_by_age"]:::skipped
    xefa1a60843915f9f(["population_midyear_bulletin_pages"]):::skipped --> x946771421caaa150["population_midyear_by_age"]:::skipped
    x946771421caaa150["population_midyear_by_age"]:::skipped --> xa1686cc888963231(["population_midyear_by_age_csv"]):::skipped
    x52e965cb7c1cd1fc(["population_midyear_bulletin_files"]):::skipped --> x426614807f974316["population_midyear_by_age_sex"]:::skipped
    xefa1a60843915f9f(["population_midyear_bulletin_pages"]):::skipped --> x426614807f974316["population_midyear_by_age_sex"]:::skipped
    x426614807f974316["population_midyear_by_age_sex"]:::skipped --> xf3039e66b37a1219(["population_midyear_by_age_sex_csv"]):::skipped
    x9f6b6d2ed74a37b4(["population_midyear_bulletin_district_pages"]):::skipped --> xd0c8e8b884ab8581["population_midyear_by_district"]:::skipped
    x7b26bed1fc581742(["map_adm3"]):::skipped --> xd0c8e8b884ab8581["population_midyear_by_district"]:::skipped
    x52e965cb7c1cd1fc(["population_midyear_bulletin_files"]):::skipped --> xd0c8e8b884ab8581["population_midyear_by_district"]:::skipped
    xd0c8e8b884ab8581["population_midyear_by_district"]:::skipped --> xf94a6bce4cea6c14(["population_midyear_by_district_csv"]):::skipped
    xeea0ec396e5de5da(["population_endyear_bulletin_files"]):::skipped --> x52d6a6119be69714["population_midyear_total"]:::skipped
    xe648a7801cd2da2c(["births_endyear_pages"]):::skipped --> x52d6a6119be69714["population_midyear_total"]:::skipped
    x52d6a6119be69714["population_midyear_total"]:::skipped --> x37b834e41770c27f(["population_midyear_total_csv"]):::skipped
    
  end
```

To run the workflow, issue the following command in R from within the
project directory

``` r
targets::tar_make()
```

or issue the following command in Terminal from within the project
directory

``` bash
Rscript -e  "targets::tar_make()"
```

## Authors and contributors

### Authors

  - Prof. Proochista Ariana
  - Dr. Aronrag Meeyai
  - Dr. Sylvie Pool
  - Dr. Sanjeev Pugazhendhi
  - Ituen Williams-Umanah
  - Ned Rosalie
  - Keddy Woodcock

The **Seychelles-Oxford Partnership**, from which this project came
about, was made possible through the efforts of [Prof. Proochista
Ariana](https://www.ndm.ox.ac.uk/team/proochista-ariana), [Dr. Aronrag
Meeyai](https://www.tropicalmedicine.ox.ac.uk/team/aronrag-meeyai), and
[Dr. Sylvie
Pool](https://www.tropicalmedicine.ox.ac.uk/team/sylvie-pool). The
original codebases from which this project was built on were written by
[Dr. Sanjeev
Pugazhendhi](https://www.linkedin.com/in/sanjeev-pugazhendhi), [Ituen
Williams-Umanah](https://www.linkedin.com/in/williams-ituen-umanah-b10a8b233),
Ned Rosalie, and Keddy Woodcock.

### Contributors

  - Dr. Johanna Rapanarilala
  - Dr. Carine Asnong
  - Prof. Bruno Holthof
  - Dr. Giri Rajahram
  - Dr. Bushra Naz
  - Dr. Yih Seong Wong
  - Anita Makori
  - Dr. Jillian Francise Lee
  - Neira Budiono
  - Dr. Nyasha Manyeruke
  - Dr. Ibrahim Ajami

This project would also not be possible without the contributions of
[Dr. Johanna
Rapanarilala](https://www.linkedin.com/in/johanna-rapanarilala-bb5520312/)
who supervised and mentored several of the [University of
Oxford](https://www.ox.ac.uk) [MSc in International Health and Tropical
Medicine](https://www.tropicalmedicine.ox.ac.uk/study-with-us/msc-ihtm)
who came to Seychelles for their study placement for their MSc and
[Dr. Carine
Asnong](https://www.tropicalmedicine.ox.ac.uk/team/carine-asnong) and
[Prof. Bruno
Holthof](https://www.tropicalmedicine.ox.ac.uk/team/bruno-holthof) who
have contributed to teaching on research skills, data analysis, and
healthcare management and quality of care for members of the [Seychelles
Ministry of Health](https://www.health.gov.sc/). Finally, the feedback,
insights, and learning gained from [Dr. Giri
Rajahram](https://www.rstmh.org/dr-giri-rajahram), [Dr. Bushra
Naz](https://www.linkedin.com/in/bushra-naz-983b801b6), [Dr. Yih Seong
Wong](https://www.linkedin.com/in/yihseongwong), [Anita
Makori](https://www.linkedin.com/in/anita-makori), [Dr. Jillian Francise
Lee](https://www.linkedin.com/in/jillianfrancise), Neira Budiono,
[Dr. Nyasha
Manyeruke](https://www.linkedin.com/in/nyasha-manyeruke-63a466283/), and
[Dr. Ibrahim
Ajami](https://www.linkedin.com/in/dr-ibrahim-f-ajami-043508146/) -
students who spent their study placement in Seychelles - contributed to
identifying critical and priority datasets to include in this project.

The project is currently maintained by [Ernest
Guevarra](https://ernest.guevarra.io).

## Disclaimer

This project is an independent effort by members of the
**Seychelles-Oxford Partnership** in support of group and individual
data needs and goals. This project is not a recognised project by the
Seychelles government or of the ministries/agencies from which our
Seychellois colleagues are affiliated with. Any issues or problems
arising from the `seystats` datasets or from participating or
contributing to the development of this project are the responsibility
of the authors and maintainers of this project and should be addressed
to them accordingly and not to the ministries/agencies/organisations
from which the data has been made available from.

This effort is aimed to serve as an example of how data can be curated
and managed in a manner that is effective, efficient,
machine-actionable, and analysis-ready using widely-available and open
source tools. Given the open source nature of this project, it is our
hope that the project can either be handed over to relevant and official
entities within Seychelles to continue its upkeep and maintenance or
that this becomes a basis for official efforts within Seychelles to
streamline and make more effective and efficient its data curation and
management processes.

## License

All code in this project is released under a
[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html#license-text)
license. All text in this project is released under a
[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.en)
license. All data is released under a
[CC0](https://creativecommons.org/public-domain/cc0/) license.

## Citation

If you use the data provided through `seystats` in your work/research,
please cite `seystats` along with all the sources of data that were used
for curating the data available herewith. The suggested appropriate
citation metadata is provided in
[CITATION.cff](https://github.com/OxfordIHTM/seystats/blob/main/CITATION.cff).

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/seystats/issues). If
you would like to contribute to the project, please see our
[contributing
guidelines](https://github.com/OxfordIHTM/seystats/blob/main/.github/CONTRIBUTING.md).

This project is released with a [Contributor Code of
Conduct](https://github.com/OxfordIHTM/seystats/blob/main/.github/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
