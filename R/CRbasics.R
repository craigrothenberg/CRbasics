# project setup ----

# 2022-07-06 new approach to normalizing paths by OS
CRnormalizePath <- function(myPath){
  if(Sys.info()['sysname'] %in% "Windows"){
    gsub(x = myPath,pattern = "/",replacement = "\\\\")
  } else {
    gsub(x = myPath,pattern = "\\\\",replacement = "/")
  }
}


# creates subfolder directories and basic files for project
# works in conjunction with custom shortcuts and custom pipe (not included in this R code)
CRprojectBuilder <- function(){

  # identify mac vs windows
  cr.pathSetup <- if(Sys.info()['sysname'] %in% "Windows"){
    "\\"
  } else {
    "/"
  }

  if(!dir.exists(CRnormalizePath("data"))){dir.create(CRnormalizePath("data"))}
  if(!dir.exists(CRnormalizePath("code"))){dir.create(CRnormalizePath("code"))}
  if(!dir.exists(CRnormalizePath("figures"))){dir.create(CRnormalizePath("figures"))}
  if(!dir.exists(CRnormalizePath("output"))){dir.create(CRnormalizePath("output"))}
  if(!dir.exists(CRnormalizePath("docs"))){dir.create(CRnormalizePath("docs"))}

  if(!file.exists(CRnormalizePath("code\\_import.R"))){
    file.create(CRnormalizePath("code\\_import.R"))
    fileConn.import <- file(CRnormalizePath("code\\_import.R"))
    writeLines(c("library(tidytable)","library(tidyverse)","library(CRtools)","library(cowplot)","library(ggthemes)","library(readxl)","library(scales)","library(lubridate)"
    ),fileConn.import)
    close(fileConn.import)
  }
}


# additional functions ----
# same as round() function, but rounds .5 up to higher number, rather than rounding even
round2 <- function( vec , digits=0 ){
  vec0 <- vec
  eps <- 10^(-10)
  vec <- abs(vec)
  vec <- vec*10^digits
  vec2 <- vec-floor(vec)
  #    vec <- floor( vec ) + ifelse( vec2 < .5 , 0 , 1 )
  vec <- floor( vec ) + ifelse( ( vec2 - .5 ) < - eps, 0 , 1 )
  vec.round <- sign(vec0) * vec / 10^digits
  return(vec.round)
}


