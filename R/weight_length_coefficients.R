#' Weight-length-conversion coefficients for Grand Canyon Fish
#'
#' Data from AGFD (2000-2021) Grand Canyon and Lees Ferry Monitoring and 
#' USGS Natal Origins, Juvenile Chub Monitoring, and Trout Recruitment and Growth
#' Dynamics projects. Calculated from approximately 300k fish, sample sizes vary 
#' from tens of thousands for common species (Rainbow Trout, Flannelmouth Sucker,
#' Humpback Chub) to 10-20 for rare species (i.e., bass, bullheads)
#'
#' @docType data
#'
#' @usage data(weight_length_coef)
#'
#' @format A Dataset with 21 rows and 10 columns
#'#' \describe{
#'   \item{SPECIES_CODE}{three letter species code, all capitals}
#'   \item{species}{common name}
#'   \item{FL.from.TL.intercept}{intercept used to calculate fork length  (mm) from total length (mm)}
#'   \item{FL.from.TL.slope}{slope used to calculate fork length  (mm) from total length (mm)}
#'   \item{TL.from.FL.intercept}{intercept used to calculate total length (mm) from fork length (mm)}
#'   \item{TL.from.FL.slope}{slope used to calculate total length (mm) from fork length (mm)}
#'   \item{wt.from.FL.intercept}{intercept used to calculate weight (g) from fork length (mm)}
#'   \item{wt.from.FL.slope}{slope used to calculate weight (g) from fork length (mm)}
#'   \item{wt.from.TL.intercept}{intercept used to calculate weight (g) from total length (mm)}
#'   \item{wt.from.TL.slope}{slope used to calculate weight (g) from total length (mm)}
#' }
#'
#' @keywords datasets

