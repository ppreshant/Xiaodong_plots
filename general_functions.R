# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# calling libraries ; make sure they are installed (install.packages)
library(readxl); library(magrittr); library(tidyverse); library(ggrepel); library(rlist)  

# set theme for plotting
theme_set(theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()))
