# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# calling libraries ; make sure they are installed (install.packages)
library(readxl); library(magrittr); library(tidyverse); library(ggrepel); library(rlist)  

# set theme for plotting
theme_set(theme_bw() + # simple theme with border and gridlines
            theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + # remove gridlines
            theme(legend.justification = c(0, 1), legend.position = c(0, 1), legend.box.margin=margin(rep(10,4))) # plot legend on top left
          )
