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
    writeLines(c("library(tidyverse)","library(CRbasics)","library(readxl)","library(lubridate) # handling dates/ timestamps","library(ggthemes) # ggplot formatting","library(scales) # color and number formatting","","options(scipen=5) # change to adjust number of decimals used before switching to scientific notation"
    ),fileConn.import)
    close(fileConn.import)
  }

  file.edit(CRnormalizePath("code\\_import.R"))
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


CRcolorPalette <- c(
  "#33b1ff",
  "#8a3ffc",
  "#007d79",
  "#ff7eb6",
  "#fa4d56",
  "#fff1f1",
  "#6fdc8c",
  "#4589ff",
  "#d12771",
  "#d2a106",
  "#08bdba",
  "#bae6ff",
  "#ba4e00",
  "#d4bbff"
)
