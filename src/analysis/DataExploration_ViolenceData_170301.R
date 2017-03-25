#  ####################################################################### 
#       File-Name:      DataExploration_ViolenceData_170301.R
#       Version:        R 3.3.2
#       Date:           Mar 1, 2017
#       Author:         MM
#       Purpose:        Basic descriptives and data exploration to assess 
#                       statements by the Program on Drug Policies (PPD) 
#                       based on their dataset that that compiles 
#                       violent confrontations between armed forces and 
#                       organized crime in MX between 2007-2011 for article in
#                       Revista R (Reforma) in MX
#       Input Files:    AllViolenceData_170301.csv (cleaned data on violence)
#       Output Files:   NONE
#       Data Output:    NONE
#       Previous files: NONE
#       Dependencies:   Gather_ViolenceData_170301.R
#       Required by:    NONE 
#       Status:         IN PROGRESS
#       Machine:        Mac laptop
#  ####################################################################### 

rm(list=ls(all=TRUE))   # cleans everything in the workspace

library(readr)          # easier reading of flat files
#library(ggplot2)        # pretty graphs made easy
#library(lubridate)      # easier manipulation of time objects
#library(pBrackets)      # package to create brackets 
#library(grid)           # package to allocate grids
#library(tidyverse)      #
library(IDPmisc)


# ::::::: SOME USEFUL DEFINITIONS :::::::::::::::::::::::::::::::::::::::::::::  

# set the general path for the project at its root, specific files will define 
# their own branches individually

#path <- # YOUR PROJECT PATH HERE


# define additional paths for files you will use. In each case, determine
# appropriate additions to the path

inFileName1   <- "data//processed/AllViolenceData_170301.csv"         # cleaned data on violence

# ::::::: APPLY INITIAL DEFINITIONS ::::::::::::::::::::::::::::::::::::::::::: 

# set your path to that defined above, and confirm it
setwd(path)   
getwd()

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: LOADS DATA :::::::::::::::::::::::::::::::::::::::::::  


# ::::::: LOADING RAW DATA

AllData <- read_csv(inFileName1) 

# rough validations that data was correctly loaded
names(AllData)
nrow(AllData)
summary(AllData)


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: SOME INITIAL EXPLORATIONS ::::::::::::::::::::::::::::  


# ::::: 1) COMPUTING LETHALITY INDEX WITH CIDE-PPD DATA

print(paste0(
    "El indice de letalidad para la Policia Federal es de ",
    round(
        sum(NaRV.omit(AllData$organized.crime.dead[AllData$federal.police==1]))/
            sum(NaRV.omit(AllData$organized.crime.wounded[AllData$federal.police==1])),
        digits = 1)
))


print(paste0(
    "El indice de letalidad para el Ejercito es de ",
    round(
        sum(NaRV.omit(AllData$organized.crime.dead[AllData$army==1]))/
            sum(NaRV.omit(AllData$organized.crime.wounded[AllData$army==1])),
        digits = 1)
))



print(paste0(
    "El indice de letalidad para la Marina es de ",
    round(
        sum(NaRV.omit(AllData$organized.crime.dead[AllData$navy==1]))/
            sum(NaRV.omit(AllData$organized.crime.wounded[AllData$navy==1])),
        digits = 1)
))



print(paste0(
    "El indice de letalidad para Fuerzas Federales (Ejercito, Marina y Policia Federal) es de ",
    round(
        sum(NaRV.omit(AllData$organized.crime.dead[AllData$navy==1 | 
                                                       AllData$army==1 | AllData$federal.police==1]))/
            sum(NaRV.omit(AllData$organized.crime.wounded[AllData$navy==1 | 
                                                              AllData$army==1 | AllData$federal.police==1 ])),
        digits = 1)
))

# ::::::: 2) WHAT PERCENTAGE OF ALL EVENTS REPORT "PERFECT LETHALITY"?

print(paste0(
    round((length(AllData$organized.crime.dead[AllData$perfect.lethality == 1])/
               length(AllData$organized.crime.dead))*100, digits = 2), 
    " por ciento de los eventos reportan letalidad perfecta entre presuntos miembros del crimen organizado" 
))


# :::::: 3) HOW MANY CASES ARE THERE IN EACH CATEGORY THAT COMBINES DEATHS AND 
#           WOUNDED AMONG ORGANIZED CRIME 

# number of cases in each category
table(AllData$category)

# proportions in each category
round(
    prop.table(
        table(AllData$category)
        ), digits = 2)


