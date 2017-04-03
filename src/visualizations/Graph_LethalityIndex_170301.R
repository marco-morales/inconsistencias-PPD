#  ####################################################################### 
#       File-Name:      Graph_VioenceData_170301.R
#       Version:        R 3.3.2
#       Date:           Mar 1, 2017
#       Author:         MM
#       Purpose:        Create visualizations for article assessing 
#                       contents and shortcomings of the "lethality index"
#                       using CIDE-PPD data to exemplify this for an article
#                       in Nexos in MX
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


# ::::::: SOME USEFUL DEFINITIONS :::::::::::::::::::::::::::::::::::::::::::::  

# set the general path for the project at its root, specific files will define 
# their own branches individually

#path <- YOUR PATH HERE

# define additional paths for files you will use. In each case, determine
# appropriate additions to the path

inFileName1   <- "data//processed/AllViolenceData_170301.csv"         # cleaned data on violence
inFileName2   <- "data//processed/LethalityIndices.csv"               # summary of calculated lethality indices
outFileName2  <- "reports//graphs//Nexos//FIGURA2_Nexos.png"          # output file name
outFileName3  <- "reports//graphs//Nexos//FIGURA3_Nexos.png"          # output file name
outFileName4  <- "reports//graphs//Nexos//FIGURA4_Nexos.png"          # output file name


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



Indices <- read_csv(inFileName2) 

# rough validations that data was correctly loaded
names(Indices)
nrow(Indices)
summary(Indices)

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: SOME QUICK DATA PROCESSING :::::::::::::::::::::::::::  

# first, to sort the graph we need to make "category"
# a factor variable with the ordering of levels we need
AllData$category <- factor(AllData$category, 
                           levels = c("no.dead.wounded",
                                      "perfect.lethality",
                                      "dead.wounded",
                                      "just.wounded")) 



# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# :::::::::::::::::::::: SOME INITIAL GRAPHING ::::::::::::::::::::::::::::::::  


# :::::::: FIGURE 2

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
  annotate("text", x = 3, y = .42, 
           label = "informaci\u00F3n usada selectivamente en \n \u022\u00EDndice de letalidad\u022 agregado \n (43%)", fontface = 2, 
           color = "gray50", size = 8) +
  theme_minimal() +
  theme(axis.text.y = element_text(size=16),
        axis.text.x = element_text(size=16),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank()) 

grid.locator(unit="native") 
bottom_y <- 210
grid.brackets(230, bottom_y, 690, bottom_y, lwd=2, col="gray50")
dev.copy(jpeg,outFileName2, height=180, width=300, units = "mm", res=600) 
dev.off()


# :::::::: FIGURE 3

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
  annotate("text", x = 3.5, y = .22, 
           label = "datos usados para calcular \n promedio del \u022\u00EDndice de letalidad\u022 \n (16%)", fontface = 2, 
           color = "gray50", size = 8) +
  theme_minimal() +
  theme(axis.text.y = element_text(size=16),
        axis.text.x = element_text(size=16),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank()) 

grid.locator(unit="native") 
bottom_y <- 350
grid.brackets(390, bottom_y, 690, bottom_y, lwd=2, col="gray50")
dev.copy(jpeg,outFileName3, height=180, width=300, units = "mm", res=600) 
dev.off()


# :::::::: FIGURE 4

  ggplot(Indices, aes(x = force, y = index, fill = source)) + 
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(yintercept = 1) +
  scale_x_discrete("", labels = 
                     c("army" = "ej\U00E9rcito",
                       "federal.police" = "polic\u00EDa federal",
                       "navy" = "marina")) +
  scale_y_continuous("\u00EDndice de letalidad", 
                     breaks = c(0, 1, 2, 3, 4, 5)) +
  theme_minimal() +
  theme(axis.text.y = element_text(size=16),
        axis.text.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size=16)) +
  scale_fill_manual(name = "", 
                    values = c("aggregate" = "orangered3", "average" = "steelblue4"),
                    labels=c("agregado", "promedio de eventos")) +
    annotate("text", x = .78, y = 5, 
             label = "5.4", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = 1.78, y = 2.8, 
             label = "3.0", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = 2.78, y = 4.3, 
             label = "4.6", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = 1.2, y = .4, 
             label = "0.63", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = 2.2, y = .23, 
             label = "0.37", fontface = 2, 
             color = "white", size = 8) +
    annotate("text", x = 3.2, y = .4, 
             label = "0.60", fontface = 2, 
             color = "white", size = 8)
  ggsave(file = outFileName4, 
         width = 300, height = 180, units = "mm", dpi = 300)





