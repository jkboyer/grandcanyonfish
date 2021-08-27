

#make test df 
test <- data.frame(species = c("FMS", "HBC", "BHS", "RBT", #all good
                               "FMS", "HBC", "BHS", #missing one or both lengths
                               "CRA", "NFC", NA), #mising sp or not a species
                   total = c(350, 350, 350, 350,
                             NA, NA, 250, 
                             100, NA, NA),
                   fork = c(330, 310, 320, 340,
                            250, NA, NA, 
                            NA, NA, NA))

test.good <- test[1:4, ]



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

#using vectorize makes things work!
#but there may be a better way https://www.jimhester.com/post/2018-04-12-vectorize/
fork_to_total <- Vectorize(fork_to_total)

library(grandcanyonfish)

#test funtion with single fish
fork_to_total("FMS", 350)
fork_to_total("HBC", 350)
fork_to_total("RBT", 350)


#test function with incomplete data
fork_to_total("NFC", NA) #not a species, no length
fork_to_total("FMS", NA) #no length
fork_to_total("CRA", 100) #not a species
fork_to_total(NA, 250) #no species

#test function with vector of fishes (good data)
fork_to_total(c("FMS", "HBC", "RBT", "BHS"), c(350, 351, 353, 200))

#test function with vector of fishes (bad data)
fork_to_total(c("FMS", "HBC", "NFC", "BHS"), c(NA, 350, NA, 200))

#test function with good dataframe (base)
fork_to_total(test.good$species, test.good$fork)

#test function with good dataframe (dplyr)
library(tidyverse)
test.good %>%
  mutate(calc.total = fork_to_total(species, fork))

#test function with bad dataframe (base)
fork_to_total(test$species, test$fork)

#test function with bad dataframe (dplyr)
test %>%
  mutate(calc.total = fork_to_total(species, fork))


species.code <- c("FMS", "HBC")
fork.length <- c(375, 350)


intercept <-  weight.length.coef$TL.from.FL.intercept[
  weight.length.coef$SPECIES_CODE == species.code]

slope <- weight.length.coef$TL.from.FL.slope[
  weight.length.coef$SPECIES_CODE == species.code]

str(intercept)
str(slope)
is.atomic(intercept)
is.atomic(slope)

#calculate total length
is.atomic(round(intercept + slope*fork.length))

















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
