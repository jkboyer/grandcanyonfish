#' Predict Total Length from Fork Length
#' 
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param fork.length fork length (mm)
#' @return total length (mm)
#' @examples 
#' total_from_fork("FMS", 437)
#' @export
total_from_fork <- function(species.code, fork.length){
round(
  weight.length.coef$TL.from.FL.intercept[
    weight.length.coef$SPECIES_CODE == species.code] +
    (fork.length)*(weight.length.coef$TL.from.FL.slope[
      weight.length.coef$SPECIES_CODE == species.code]),
  0)
}

#' Predict Total Length from Fork Length
#' 
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param total.length fork length (mm)
#' @return fork length (mm)
#' @examples 
#' fork_from_total("HBC", 282)
#' @export
fork_from_total <- function(species.code, total.length){
  round(
    weight.length.coef$FL.from.TL.intercept[
      weight.length.coef$SPECIES_CODE == species.code] +
      (total.length)*(weight.length.coef$FL.from.TL.slope[
        weight.length.coef$SPECIES_CODE == species.code]),
    0)
}  

#' Predict Weight (g) from Total Length (mm)
#' 
#' Note that weight can vary widely among individuals and over time, predicted weights
#' calculated by this function provide a mean weight at a given length, but fish
#' may weight more or less than predicted weights.
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param total.length (mm)
#' @return weight (g)
#' @examples 
#' weight_from_total("RBT", 307)
#' @export
weight_from_total <- function(species.code, total.length){
  round(
    10^(weight.length.coef$wt.from.TL.intercept[
      weight.length.coef$SPECIES_CODE == species.code] + 
        weight.length.coef$wt.from.FL.slope[
          weight.length.coef$SPECIES_CODE == species.code]*
        log10(total.length)),
    0)
}

#' Predict Weight (g) from Fork Length (mm)
#' 
#' Note that weight can vary widely among individuals and over time, predicted weights
#' calculated by this function provide a mean weight at a given length, but fish
#' may weight more or less than predicted weights.
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param fork.length (mm)
#' @return weight (g)
#' @examples 
#' weight_from_fork("BHS", 226)
#' @export
weight_from_fork <- function(species.code, fork.length){
  round(
    10^(weight.length.coef$wt.from.FL.intercept[
      weight.length.coef$SPECIES_CODE == species.code] + 
        weight.length.coef$wt.from.FL.slope[
          weight.length.coef$SPECIES_CODE == species.code]*
        log10(fork.length)),
    0)
}
