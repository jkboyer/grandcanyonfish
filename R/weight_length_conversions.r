#' Predict Total Length from Fork Length
#' 
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param fork.length fork length (mm)
#' @return total length (mm)
#' @examples 
#' fork_to_total("FMS", 437)
#' @export
fork_to_total <- Vectorize(function(species.code, fork.length){
  
  if (species.code %in% weight.length.coef$SPECIES_CODE & !is.na(fork.length)){
    
    #define coefficients for the species
    intercept <-  weight.length.coef$TL.from.FL.intercept[
      weight.length.coef$SPECIES_CODE == species.code]
    
    slope <- weight.length.coef$TL.from.FL.slope[
      weight.length.coef$SPECIES_CODE == species.code]
    
    #calculate total length
    round(intercept + slope*fork.length)
    
  }
  
  else {
    NA #return NA if data is missing or species not in weight.length.coef
  }
}
)

#' Predict Fork Length from Total Length
#' 
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param total.length fork length (mm)
#' @return fork length (mm)
#' @examples 
#' total_to_fork("HBC", 282)
#' @export
total_to_fork <- Vectorize(function(species.code, total.length){
  
  if (species.code %in% weight.length.coef$SPECIES_CODE & !is.na(total.length)){
    
    #define coefficients for the species
    intercept <-  weight.length.coef$FL.from.TL.intercept[
      weight.length.coef$SPECIES_CODE == species.code]
    
    slope <- weight.length.coef$FL.from.TL.slope[
      weight.length.coef$SPECIES_CODE == species.code]
    
    #calculate total length
    round(intercept + slope*total.length)
    
  }
  
  else {
    NA #return NA if data is missing or species not in weight.length.coef
  }
}
)

#' Predict Weight (g) from Total Length (mm)
#' 
#' Note that weight can vary widely among individuals and over time, predicted weights
#' calculated by this function provide a mean weight at a given length, but fish
#' may weight more or less than predicted weights.
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param total.length (mm)
#' @return weight (g)
#' @examples 
#' total_to_weight("RBT", 307)
#' @export
total_to_weight <- Vectorize(function(species.code, total.length){
  
  if (species.code %in% weight.length.coef$SPECIES_CODE & !is.na(total.length)){
  
    intercept <- weight.length.coef$wt.from.TL.intercept[
      weight.length.coef$SPECIES_CODE == species.code]
    
    slope <-  weight.length.coef$wt.from.TL.slope[
          weight.length.coef$SPECIES_CODE == species.code]
    
    round(10^(intercept + slope*log10(total.length)))
      
}
  else {
    NA #return NA if data is missing or species not in weight.length.coef
  }
}
)


#' Predict Weight (g) from Fork Length (mm)
#' 
#' Note that weight can vary widely among individuals and over time, predicted weights
#' calculated by this function provide a mean weight at a given length, but fish
#' may weight more or less than predicted weights.
#' @param species.code 3 letter GCMRC species code (i.e., "FMS", "HBC", "RBT")
#' @param fork.length (mm)
#' @return weight (g)
#' @examples 
#' fork_to_weight("BHS", 226)
#' @export
fork_to_weight <- Vectorize(function(species.code, fork.length){
  
  if (species.code %in% weight.length.coef$SPECIES_CODE & !is.na(fork.length)){
    
    intercept <- weight.length.coef$wt.from.FL.intercept[
      weight.length.coef$SPECIES_CODE == species.code]
    
    slope <-  weight.length.coef$wt.from.FL.slope[
      weight.length.coef$SPECIES_CODE == species.code]
    
    round(10^(intercept + slope*log10(fork.length)))
    
  }
  else {
    NA #return NA if data is missing or species not in weight.length.coef
  }
}
)

