#  ####################################################################### 
#       File-Name:      Graph_VioenceData_170301.R
#       Version:        R 3.3.2
#       Date:           Mar 1, 2017
#       Author:         MM
#       Purpose:        Create visualizations for artile assessing statements by
#                       the Program on Drug Policies (PDD) that compiles 
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
library(ggplot2)        # pretty graphs made easy
library(lubridate)      # easier manipulation of time objects
library(pBrackets)      # package to create brackets 
library(grid)           # package to allocate grids
library(tidyverse)      #
library(IDPmisc)


# ::::::: SOME USEFUL DEFINITIONS :::::::::::::::::::::::::::::::::::::::::::::  

# set the general path for the project at its root, specific files will define 
# their own branches individually

#path <- # YOUR PROJECT PATH HERE


# define additional paths for files you will use. In each case, determine
# appropriate additions to the path

inFileName1   <- "data//processed/AllViolenceData_170301.csv"         # cleaned data on violence
outFileName1  <- "reports//graphs//RevistaR//FIGURA1_RevistaR.png"    # output file name
outFileName2  <- "reports//graphs//RevistaR//FIGURA2_RevistaR.png"    # output file name
outFileName3  <- "reports//graphs//RevistaR//FIGURA3_RevistaR.png"    # output file name



# ::::::: APPLY INITIAL DEFINITIONS ::::::::::::::::::::::::::::::::::::::::::: 

# set your path to that defined above, and confirm it
setwd(path)   
getwd()

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: LOADS DATA :::::::::::::::::::::::::::::::::::::::::::  


# ::::::: LOADING RAW DATA
# note that read_csv() guesses column types, so that date is read as a date 
# very useful for plotting time series

AllData <- read_csv(inFileName1) 
    
# rough validations that data was correctly loaded
names(AllData)
nrow(AllData)
summary(AllData)


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: SOME INITIAL GRAPHING ::::::::::::::::::::::::::::::::  


# :::::::::: FIGURE 1: CLASSIFICATION

# first, to sort the graph we need to make "category"
# a factor variable with the ordering of levels we need

AllData$category <- factor(AllData$category, 
                           levels = c("no.dead.wounded",
                                      "perfect.lethality",
                                      "dead.wounded",
                                      "just.wounded")) 

ggplot(data = AllData) +
    geom_bar(aes(x=category, 
                 y = (..count..)/sum(..count..)), fill = "orangered3") +
    scale_y_continuous("", labels = scales::percent) +
    scale_x_discrete("", labels = 
                       c("perfect.lethality" = "\u022letalidad perfecta\u022",
                         "no.dead.wounded" = "",
                         "dead.wounded" = "",
                         "just.wounded" = "")) +
    annotate("text", x = "no.dead.wounded", y = .50, 
             label = "sin muertos \n sin heridos \n (57%)", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = "perfect.lethality", y = .20, 
             label = "con muertos \n sin heridos \n (27%)", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = "dead.wounded", y = .04, 
             label = "con muertos \n con heridos", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = "just.wounded", y = .04, 
             label = "sin muertos \n con heridos", fontface = 2, 
             color = "white", size = 8) +
    theme_minimal() +
    ggtitle("Proporciones de tipos de \u022letalidad\u022 entre presuntos criminales \n en la Base CIDE-PPD")+
      theme(axis.text.y = element_text(size=16),
          axis.text.x = element_text(size=16),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          plot.title = element_text(size = 16, face = "bold", hjust = 0.5)
          ) 
ggsave(file = outFileName1, 
       width = 300, height = 180, units = "mm", dpi = 300)

# ::::::::: FIGURE 2: event-level indices

# let's look at the cases of the lethality index
ggplot(data = AllData[is.infinite(AllData$organized.crime.lethality)==F,],
       aes(date, organized.crime.lethality)) + 
    geom_point(alpha = 1/2, size = 3) +
    geom_hline(yintercept = mean(NaRV.omit(AllData$organized.crime.lethality)),
               color = "orangered4") +
    annotate("text", x = as.Date("2007-03-01"), y = 2, 
           label = "promedio = 0.7", fontface = 2, 
           color = "orangered4", size = 6) +
    scale_x_date("", date_breaks = "1 year", date_labels = "%Y")  +
    scale_y_continuous("") +
    theme_minimal() +
    ggtitle("\u0022\u00EDndice de letalidad\u0022 por evento \n en la base CIDE-PPD")+
    theme(axis.title.y = element_text(size =16),
          axis.text.y = element_text(size=16),
          axis.text.x = element_text(size=12),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          plot.title = element_text(size = 16, face = "bold", hjust = 0.5)
    ) 
ggsave(file = outFileName2, 
       width = 300, height = 180, units = "mm", dpi = 300)



# :::::::::: FIGURE 3: perfect-lethality events

ggplot(data = subset(AllData, category == "perfect.lethality")) +
    geom_rect(aes(xmin = 0.5, xmax = 3.5, ymin = 0, ymax =.5), 
              fill = "gray80", alpha = 1/8) +
    geom_bar(aes(x=organized.crime.dead, 
        y = (..count..)/sum(..count..)), fill = "orangered2") +
    annotate("text", x = 2, y = .48, size = 8,
             label = "80%", fontface = 2, color = "white") +
    theme_minimal() +
    scale_x_continuous("", breaks = c(1,2,3,5,10,15,20,30),
                     labels = c("1","2","3","5","10","15","20","30")) +
    scale_y_continuous("", labels = scales::percent) +  
    theme(axis.text.y = element_text(size=14), 
         axis.text.x = element_text(size=12),
         panel.grid.major.x = element_blank(),
         panel.grid.minor.x = element_blank(),
         panel.grid.minor.y = element_blank(),
         plot.title = element_text(size = 16, face = "bold", hjust = 0.5)
         ) +
    ggtitle("N\u00FAmero de muertes de presuntos criminales\n en eventos de \u022letalidad perfecta\u022 \n en la base CIDE-PPD")

ggsave(file = outFileName3, 
       width = 300, height = 180, units = "mm", dpi = 300)
