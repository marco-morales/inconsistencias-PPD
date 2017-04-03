#  ####################################################################### 
#       File-Name:      DataExploration_LethalityIndex_170301.R
#       Version:        R 3.3.2
#       Date:           Mar 1, 2017
#       Author:         MM
#       Purpose:        Basic descriptives and data exploration on 
#                       scoping out contents and limitations of the
#                       "Lethality Index" using CIDE-PPD data to illustrate  
#                       on an article in Nexos in MX
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
library(tidyverse)      #
library(IDPmisc)
library(magrittr)


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
# :::::::::::::::::::::: SOME COMPUTATIONS:::::::::::::::::::::::::::::::::::::  

# computes lethality index at the event level

AllData %<>%
    mutate(.,
           organized.crime.EventIndex = 
               (organized.crime.dead-organized.crime.wounded) / 
               (organized.crime.dead+organized.crime.wounded)
    )


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

# ::::::: 2) COMPUTING EVENT-LEVEL LETHALITY INDEX WITH CIDE-PPD DATA


print(paste0(
    "El indice de letalidad promedio para la Policia Federal es de ",
    round(
        mean(NaRV.omit(AllData$organized.crime.EventIndex[AllData$federal.police==1])),
        digits = 2)
))


print(paste0(
    "El indice de letalidad promedio para el Ejercito es de ",
    round(
        mean(NaRV.omit(AllData$organized.crime.EventIndex[AllData$army==1])),
        digits = 2)
))



print(paste0(
    "El indice de letalidad promedio para la Marina es de ",
    round(
        mean(NaRV.omit(AllData$organized.crime.EventIndex[AllData$navy==1])),
        digits = 2)
))



print(paste0(
    "El indice de letalidad promedio para Fuerzas Federales (Ejercito, Marina y Policia Federal) es de ",
    round(
        mean(NaRV.omit(AllData$organized.crime.EventIndex[AllData$navy==1 | 
                                                       AllData$army==1 | 
                                                           AllData$federal.police==1])),
        digits = 2)
))



