% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distance_discharge_conversions.r
\name{mile_to_km_COR}
\alias{mile_to_km_COR}
\title{Convert river miles (RM 0 = Lees Ferry) to kilometers (rkm 0 = Glen Canyon Dam)}
\usage{
mile_to_km_COR(river.mile)
}
\arguments{
\item{river.mile}{GCMRC river mile, numbered downstream where RM 0 = Lees Ferry}
}
\value{
river kilometer, numbered downstream where RM 0 = Glen Canyon Dam
}
\description{
Glen Canyon Dam is 15.8 miles (25.42 km) upstream of Lees Ferry
}
\examples{
four.mile.bar <- mile_to_km_COR(-4.02)
confluences <- mile_to_km_COR(c(61.4, 89.1, 157))
}
