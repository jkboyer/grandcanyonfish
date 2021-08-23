#Functions to convert between US and metric units commonly used in Colorado
#river fisheries research
#Author: Jan Boyer, AGFD

#### distance conversions #####

#' Convert river miles (RM 0 = Lees Ferry) to kilometers (rkm 0 = Glen Canyon Dam)
#'
#' Glen Canyon Dam is 15.8 miles (25.42 km) upstream of Lees Ferry
#' @param river.mile GCMRC river mile, numbered downstream where RM 0 = Lees Ferry
#' @return river kilometer, numbered downstream where RM 0 = Glen Canyon Dam
#' @examples 
#' four.mile.bar <- mile_to_km_COR(-4.02)
#' confluences <- mile_to_km_COR(c(61.4, 89.1, 157))
#' @export
mile_to_km_COR <- function(river.mile) {
  round(1.60934*(river.mile + 15.8), 2)
}

#' Convert river kilometers (rkm 0 = Glen Canyon Dam) to miles (RM 0 = Lees Ferry)
#' 
#' Glen Canyon Dam is 15.8 miles (25.42 km) upstream of Lees Ferry
#' @param rkm GCMRC river kilometer, numbered downstream where RM 0 = Glen Canyon Dam
#' @return river mile, numbered downstream where RM 0 = Lees Ferry
#' @examples 
#' mile1 <- km_to_mile_COR(3.42)
#' mile2 <- mile_to_km_COR(c(150.23, 358.3))
#' @export
km_to_mile_COR <- function(rkm) {
  round(rkm/1.60934 - 15.8, 2)
}

#' Convert  miles to kilometers
#' 
#' use for river mile to km conversion if you are not changing km/mile 0 location
#' @param mile mile
#' @return kilometer
#' @examples 
#' four.mile.bar <- mile_to_km(-4.02)
#' confluences <- mile_to_km(c(61.4, 89.1, 157))
#' @export
mile_to_km <- function(mile) {
  round(1.60934*(mile), 2)
}

#' Convert kilometers to miles
#' 
#' use for river km to mile conversion if you are not changing km/mile 0 location
#' @param km kilometer
#' @return mile
#' @examples 
#' mile1 <- km_to_mile(3.42)
#' mile2 <- mile_to_km(c(150.23, 358.3))
#' @export
km_to_mile <- function(km) {
  round(km/1.60934, 2)
}

#### discharge conversions #####
#' cubic feet/second to cubic meters/second
#' 
#' round to 3 significant figures, as that is precision of USGS flow gauges
#' @param cfs discharge (cubic feet per second)
#' @return discharge (cubic meters per second)
#' @examples 
#' hfe <- cfs_to_cms(40000)
#' loadfollowing <- cfs_to_cms(12000, 16000)
#' @export
cfs_to_cms <- function(cfs) {
  signif(cfs/35.314666721489, 3)
}

#' cubic meters/second to cubic feet/second
#' 
#' round to 3 significant figures, as that is precision of USGS flow gauges
#' @param cfs discharge (cubic feet per second)
#' @return discharge (cubic meters per second)
#' @examples 
#' hfe <- cfs_to_cms(35.2)
#' loadfollowing <- cfs_to_cms(12.3, 18.1)
#' @export
cms_to_cfs <- function(cms) {
  signif(cms*35.314666721489, 3)
}