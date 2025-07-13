#'
#' Get Seychelles regions based on district
#' 

get_region <- function(district) {
  dplyr::case_when(
    district %in% c("Au Cap", "Anse Royale", "Takamaka") ~ "South",
    district %in% c("Anse Aux Pins", "Cascade", "Point Larue") ~ "East",
    district %in% c("Anse Boileau", "Baie Lazare", "Grand Anse Mahe", "Port Glaud") ~ "West",
    district %in% c("Anse Etoile", "Beau Vallon", "Belombre", "Glacis") ~ "North",
    district %in% c("Baie Sainte Anne", "Grand Anse Praslin") ~ "Praslin",
    district == "La Digue and Inner Islands" ~ "La Digue and Inner Islands",
    district == "Other Islands" ~ "Other Islands",
    .default = "Central"
  )
}