#' Table of GCMRC fish disposition codes
#'
#' @docType data
#'
#' @usage data(gc.disposition)
#'
#' @format A Dataset with 13 rows and 4 columns
#'#' \describe{
#'   \item{DISPOSITION_CODE}{two letter disposition code, all capitals}
#'   \item{disposition}{description of disposition code}
#'   \item{disposition_simple}{alive or dead}
#'   \item{disposition_mr}{alive or dead for purposes of mark-recapture analysis. TA taken alive fish are "dead", as they are no longer in system and catchable. }
#' }
#'
#' @keywords datasets
#'
#'
#' Table of GCMRC gear codes
#'
#' @docType data
#'
#' @usage data(gc.gear)
#'
#' @format A Dataset with 119 rows and 3 columns
#'#' \describe{
#'   \item{GEAR_CODE}{two letter gear code, all capitals}
#'   \item{gear}{simplified gear type (i.e., hoop net, boat electrofishing, trammel net)}
#'   \item{description}{detailed description of gear type}
#' }
#'
#' @keywords datasets
#' 
#' 
#' 
#' 
#' #' Table of GCMRC river codes
#'
#' @docType data
#'
#' @usage data(gc.rivers)
#'
#' @format A Dataset with 41 rows and 3 columns
#'#' \describe{
#'   \item{RIVER_CODE}{three letter gear code, all capitals}
#'   \item{river_name}{name of river, creek, or wash}
#'   \item{confluence_mile}{Colorado river mile (mile 0 = glen canyon dam) of confluence with Colorado River. Accurate to nearest tenth of a mile, not recorded for all tributaries, only ones commonly sampled for fish.}
#' }
#'
#' @keywords datasets
#' #' 
#' 
#' 
#' 
#' #' Table of GCMRC sample types
#'
#' @docType data
#'
#' @usage data(gc.sample.type)
#'
#' @format A Dataset with 47 rows and 5 columns
#'#' \describe{
#'   \item{SAMPLE_TYPE}{numeric sample type code (94-142)}
#'   \item{sample_type}{name of project or sample type}
#'   \item{agency}{which agency conducts that sampling}
#'   \item{river}{what river sampling was in, as three letter RIVER_CODE}
#'   \item{description}{description of sampling}
#' }
#'
#' @keywords datasets
#' 
#' 
#' 
#' #' #' Table of GCMRC species codes
#'
#' @docType data
#'
#' @usage data(gc.species)
#'
#' @format A Dataset with 61 rows and 6 columns
#'#' \describe{
#'   \item{SPECIES_CODE}{three letter species code, all caps}
#'   \item{COMMON_NAME}{common name of species}
#'   \item{genus}{which agency conducts that sampling}
#'   \item{species}{what river sampling was in, as three letter RIVER_CODE}
#'   \item{sci_name}{Genus and species}
#'   \item{native}{native fish species? Y or N)
#' }
#'
#' @keywords datasets



