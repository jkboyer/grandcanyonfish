#required libraries to build package
library(roxygen2) # easily generates documentation for package
library(devtools) # builds packages

getwd() #check that working directory is package folder

load_all("."); # load everything in working directory
               # this will load your package while it is in progress

roxygenise()      # Builds the help file

?mile_to_km_COR
