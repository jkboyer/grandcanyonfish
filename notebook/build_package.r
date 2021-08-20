#required libraries to build package
library(roxygen2) # easily generates documentation for package
library(devtools) # builds packages
library(usethis) # automates package/project tasks such as git pushes

getwd() #check that working directory is package folder

load_all("."); # load everything in working directory
               # this will load your package while it is in progress

roxygenise()      # Builds the help file

#look at help file to see if it looks ok
?mile_to_km_COR

# put package on github
usethis::use_git() #this does a git commit but does not push to my github
#usethis::use_github() #create repo on my github

# test that loading from github works
devtools::install_github("jkboyer/grandcanyonfish")
library(grandcanyonfish)


#to get data into Rdata format to include in package
#load data from text
weight_length_coef <- read.table("./notebook/weight_length_coefficients.tsv",
                                 header = TRUE)
str(weight_length_coef)

#save
save(weight_length_coef, file = "./data/weight_length_coef.RData")

#get tables from big boy
library(RODBC)
library(tidyverse)

db <- odbcConnectAccess("C:/Users/jboyer/Documents/big_boy/FISH_SAMPLE_SPECIMEN_HISTORY_20201210_1415.mdb")
sqlTables(db)$TABLE_NAME

species <- sqlFetch(db, "FISH_T_SPECIES", na.strings = "N/A")

species <- species %>%
  transmute(
         SPECIES_CODE = SPECIES_CODE,
         COMMON_NAME = str_to_title(COMMON_NAME),
         genus = str_to_title(GENUS),
         species = str_to_lower(SPECIES),
         sci_name = case_when(!is.na(species) ~ paste(genus, species),
                              is.na(species) ~ NA_character_),
         native = NATIVE) 

#update species names
species$SPECIES_CODE[species$SPECIES_CODE == "CSF"] <- "CPM"
species$COMMON_NAME[species$COMMON_NAME == "Colorado Squawfish"] <- "Colorado Pikeminnow"

#add crayfish
species <- species %>%
  add_row(SPECIES_CODE = "CRA", COMMON_NAME = "Crayfish", genus = NA,
          species = NA, sci_name = NA, native = "N")
#save
save(species, file = "./data/GC_species.RData")

#river codes
rivers <- sqlFetch(db, "GCMRC_T_RIVER_CODE", na.strings = "N/A")



rivers <- rivers %>%
  filter(REGION == "GC" & (DISTRIBUTARY_RIVER == "COR" | RIVER_CODE == "COR")) %>%
  transmute(RIVER_CODE = RIVER_CODE,
            river_name = str_to_title(DESCRIPTION))

#add confluence RM for streams where we often sample fish
confluences <- data.frame(RIVER_CODE = c("PAR", "LCR", "BAC", "SHI", 
                                         "TAP", "KAN",  "HAV"),
                          confluence_mile = c(0.9, 61.8, 88.3, 109.2, 
                                              134.3, 144.0, 157.3)) 
rivers <- rivers %>%
  left_join(confluences)
#save
save(rivers, file = "./data/GC_river_codes.RData")

#or use_data() will save as .rdata in data folder
