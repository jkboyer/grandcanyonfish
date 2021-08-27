# grandcanyonfish 🏜️ 🐟
Functions to simplify working with fisheries data from the Grand Canyon

To install:

`remotes::install_github("jkboyer/grandcanyonfish")`

All functions have documentation/help files, use `?` to see help file for a function

`?mile_to_km_COR()`

### 📏 River mile to kilometer conversions

Mile/kilometer conversion functions for Grand Canyon river miles, where river mile 0 = Lees Ferry but river kilometer 0 = Glen Canyon Dam

`mile_to_km_COR()`

`km_to_mile_COR()`

Normal mile/kilometer conversions

`mile_to_km()`

`km_to_mile()`

### 🌊 Discharge conversions (cubic feet/second, cubic meters/second)
Each conversion function rounds to 3 significant figures to match the accuracy of USGS stream gauges

`cfs_to_cms()`

`cms_to_cfs()`

### 🐟 Total length, fork length, weight conversions
All functions need species (3 letter code) and length. For example, to calculate the estimated weight of a 375 mm TL Flannelmouth, use `total_to_weight("FMS", 375)`

`fork_to_total()`

`total_to_fork()`

`total_to_weight()`

`fork_to_weight()`

Length/Weight conversions calculated using the included data `weight.length.coef`, which has slopes and intercepts for all conversions and species. Coefficients calculated using AGFD data and NO/TRGD/JCM data (approximately 300k fish records total, per species sample sizes range from tens of thousands for commonly caught species (FMS, RBT, HBC) to 10-20 for rare species (i.e., YBH, RBS).

### 📑 Lookup tables for GCMRC database codes

Several reference tables from the big boy database are included in this package, in order to make it easier to convert codes used in our data to actual understandable words (i.e., FMS to Flannelmouth Sucker or Catostomus latipinnis, BAC to Bright Angel Creek) or look up useful information from codes (i.e., What agency/project tagged a fish with SAMPLE_TYPE 138?, What kind of sampling gear is BK?). Most have been edited to clean up capitalization, remove rarely needed columns, or add useful columns.

`gc.species` SPECIES_CODE, COMMON_NAME, genus, species, sci_name

`gc.rivers` RIVER_CODE, river_name, confluence_mile

`gc.gear` GEAR_CODE, gear, description

`gc.sample.type` SAMPLE_TYPE, sample_type, agency, river, description

As long as you have kept the same column names used by the big boy, these data can be easily merged onto your dataframes:

`mydata <- mydata %>% left_join(gc.species) #tidyverse`

`mydata <- merge(mydata, gc.species, by = "SPECIES_CODE", all.x = TRUE) #base R`
