# grandcanyonfish
Functions to simplify working with fisheries data from the Grand Canyon

To install:

`devtools::install_github("jkboyer/grandcanyonfish")`

All functions have documentation/help files, use `?` before a function (run `?mile_to_km_COR()`) to see help file for a function

### River mile to kilometer conversions

Mile/kilometer conversion functions for Grand Canyon river miles, where river mile 0 = Lees Ferry but river kilometer 0 = Glen Canyon Dam

`mile_to_km_COR()`

`km_to_mile_COR()`

Normal mile/kilometer conversions

`mile_to_km()`

`km_to_mile()`

### Discharge conversions (cubic feet/second, cubic meters/second)
Each conversion function rounds to 3 significant figures to match the accuracy of USGS stream gauges

`cfs_to_cms()`

`cms_to_cfs()`

### Total length, fork length, weight conversions
All functions need species (3 letter code) and length. For example, to calculate the estimated weight of a 375 mm TL Flannelmouth, use `weight_from_total("FMS", 375)`

`total_from_fork()`

`fork_from_total()`

`weight_from_total()`

`weight_from_fork()`

Length/Weight conversions calculated using the included data `weight_length_coef`, which has slopes and intercepts for all conversions and species. Coefficients calculated using AGFD data and NO/TRGD/JCM data (approximately 300k fish records total, per species sample sizes range from tens of thousands for commonly caught species (FMS, RBT, HBC) to 10-20 for rare species (YBH, RBS)
