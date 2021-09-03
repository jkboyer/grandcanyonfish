#get tables from big boy #################
library(RODBC)
library(tidyverse)

db <- odbcConnectAccess("C:/Users/jboyer/Documents/big_boy/FISH_SAMPLE_SPECIMEN_HISTORY_20201210_1415.mdb")
sqlTables(db)$TABLE_NAME

gc.species <- sqlFetch(db, "FISH_T_SPECIES", na.strings = "N/A")

gc.species <- gc.species %>%
  transmute(
    SPECIES_CODE = SPECIES_CODE,
    COMMON_NAME = str_to_title(COMMON_NAME),
    genus = str_to_title(GENUS),
    species = str_to_lower(SPECIES),
    sci_name = case_when(!is.na(species) ~ paste(genus, species),
                         is.na(species) ~ NA_character_),
    native = NATIVE) 

#update species names
gc.species$SPECIES_CODE[gc.species$SPECIES_CODE == "CSF"] <- "CPM"
gc.species$COMMON_NAME[gc.species$COMMON_NAME == "Colorado Squawfish"] <- "Colorado Pikeminnow"

#add crayfish
gc.species <- gc.species %>%
  add_row(SPECIES_CODE = "CRA", COMMON_NAME = "Crayfish", genus = NA,
          species = NA, sci_name = NA, native = "N")
#save
#save(gc.species, file = "./data/GC_species.RData")

#river codes
gc.rivers <- sqlFetch(db, "GCMRC_T_RIVER_CODE", na.strings = "N/A")



gc.rivers <- gc.rivers %>%
  #filter to grand canyon only - don't want upper or lower basin
  filter(REGION == "GC" & (DISTRIBUTARY_RIVER == "COR" | RIVER_CODE == "COR")) %>%
  transmute(RIVER_CODE = RIVER_CODE,
            river_name = str_to_title(DESCRIPTION))

#add confluence RM for streams where we often sample fish
confluences <- data.frame(RIVER_CODE = c("PAR", "LCR", "BAC", "SHI", 
                                         "TAP", "KAN",  "HAV"),
                          confluence_mile = c(0.9, 61.8, 88.3, 109.2, 
                                              134.3, 144.0, 157.3)) 
gc.rivers <- gc.rivers %>%
  left_join(confluences)
#save
#save(gc.rivers, file = "./data/GC_river_codes.RData")

#gear codes
gc.gear <- sqlFetch(db, "GCMRC_T_GEAR", na.strings = "N/A")

gc.gear <- gc.gear %>%
  mutate(DESCRIPTION = str_to_title(DESCRIPTION))

unique(gc.gear$GEAR_GROUP)
#add a baited column (Baited, unbaited, unknown, NA)

gear.group <- data.frame(GEAR_GROUP = unique(gc.gear$GEAR_GROUP),
                         gear_type = c("Hoop Net", "Angling", "Dip Net",
                                       "Unknown", "Trap", "Antenna",
                                       "Seine", "Electrofishing", "Foodbase Sampling",
                                       "Gill Net", "Hydrolab", "Rotenone", "Weir"))
gc.gear <- gc.gear %>%
  left_join(gear.group)
#fix gear types
gc.gear <- gc.gear %>%
  mutate(gear_type = case_when(
    #backpack vs. boat electorfishing
    gear_type == "Electrofishing" & str_detect(DESCRIPTION, "Backpack") ~ "Backpack Electrofishing",
    GEAR_CODE == "EL" ~ "Boat Electrofishing",
    #trammel net vs gill net
    str_detect(DESCRIPTION, "Trammel") ~ "Trammel Net",
    #different types of angling
    GEAR_CODE == "LL" ~ "Long Line",
    GEAR_CODE == "SPG" ~ "Spear Gun",
    #portable vs. fixed antennas
    str_detect(GEAR_CODE, "MUX") ~"PIT Tag Antenna, Fixed",
    GEAR_GROUP == "PA" ~ "PIT Tag Antenna, Portable",
    #baited hoop nets
    GEAR_CODE %in% c("HB", "MHB", "HMB") ~ "Baited Hoop Net",
    #trap types
    GEAR_CODE == "LT" ~ "Light Trap",
    GEAR_CODE %in% c("MB", "MG", "MT", "MTM", "MTP") ~ "Minnow Trap",
    #clarify a few unknowns
    GEAR_CODE == "VO" ~ "Visual Observation",
    OWNER == "WATER" ~ "Sonar",
    GEAR_CODE == "ICM" ~ "ICM Meter",
    TRUE ~ gear_type))

gc.gear <- gc.gear %>%
  transmute(GEAR_CODE = GEAR_CODE,
            gear = gear_type,
            description = DESCRIPTION)
#save
save(gc.gear, file = "./data/GC_gear_codes.RData")

#sample types
gc.sample.type <- sqlFetch(db, "GCMRC_T_SAMPLE_TYPE", na.strings = "N/A")

gc.sample.type <- gc.sample.type %>%
  filter(PROJECT == "FISH") %>%
  transmute(SAMPLE_TYPE_ID = SAMPLE_TYPE_ID,
    sample_type = str_to_title(SAMPLE_TYPE),
    agency = AGENCY,
    river = RIVER,
    description = str_to_title(DESCRIPTION)) 

#fix capitalization of acronymns
gc.sample.type <- gc.sample.type %>%
  mutate(sample_type = str_replace_all(sample_type, 
         c("Lcr" = "LCR",  "Usfws" = "USFWS", "Agfd" = "AGFD", "Agf" = "AGF",
           "Gcy" = "GCY", "Trgd" = "TRGD", "Nps" = "NPS", "_lf_" = " Lees Ferry ",
           "Swca" = "SWCA", "Nse" = "NSE", "Gc" = "GC", "Pit" = "PIT")),
         description = str_replace_all(description,
            c("Lcr" = "LCR",  "Usfws" = "USFWS", "Agfd" = "AGFD", "Agf" = "AGF",
             "Gcy" = "GCY", "Trgd" = "TRGD", "Nps" = "NPS", "_lf_" = " Lees Ferry ",
              "Swca" = "SWCA", "Nse" = "NSE", "Gc" = "GC", "Pit" = "PIT")))

gc.sample.type <- gc.sample.type %>%
  transmute(SAMPLE_TYPE = SAMPLE_TYPE_ID,
            sample_type = sample_type,
            agency = agency,
            river = river, 
            description = description)

#save
save(gc.sample.type, file = "./data/GC_sample_types.RData")


#Add 
#to get data into Rdata format to include in package
#load data from text
weight.length.coef <- read.table("./notebook/weight_length_coefficients.tsv",
                                 header = TRUE)
str(weight.length.coef)

#save
save(weight.length.coef, file = "./data/weight_length_coef.RData")

library(tidyverse)
gc.disposition <- read.csv("C:/Users/jboyer/Documents/FISH_T_DISPOSITION_LU.csv")

gc.disposition <- gc.disposition %>%
  mutate(disposition = str_to_title(disposition))

save(gc.disposition, file = "./data/GC_disposition.RData")





#"GCMRC_T_SAMPLE_TYPE" #project, agency
#RM to lat/long coordinates
#"FISH_T_DISPOSITION_LU"


odbcClose(db)
