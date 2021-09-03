#required libraries to build package
library(roxygen2) # easily generates documentation for package
library(devtools) # builds packages
library(usethis) # automates package/project tasks such as git pushes

getwd() #check that working directory is package folder

load_all("."); # load everything in working directory
               # this will load your package while it is in progress

roxygenise()      # Builds the help file

#look at help file to see if it looks ok
?mile_to_km_COR

# put package on github
#usethis::use_git() #this does a git commit but does not push to my github
#usethis::use_github() #create repo on my github

# test that loading from github works
devtools::install_github("jkboyer/grandcanyonfish")
library(grandcanyonfish)



