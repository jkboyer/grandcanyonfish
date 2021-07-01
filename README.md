# grandcanyonfish
Functions to simply working with fisheries data from the Grand Canyon

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
