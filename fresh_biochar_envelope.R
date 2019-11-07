# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# User input section ----

# file name input parameters
file_name <- "../2019 SSSA meeting.xlsx"
sheet_name <- "Fresh biochar_envelope"

# axis labels, legend label
x_axis_label <- bquote('Pyrolysis temperature (' ~ degree*C ~ ')')
y_axis_label <- bquote('Envelope density (g' ~ cm^-3 ~ ')')
legend_title <- 'Feedstock'
image_format <- 'png' # image format: (png or PDF). Export PDF for high resolution vector image for publication (editable in Inkscape or Illustrator software)

# data read and processing section ----

# load required packages
source('./general_functions.R')

# read excel file
data_raw <- read_xlsx(file_name, sheet = sheet_name) # input the excel file

# data formatting
data_formatted <- clean_formatting(data_raw) # cleans data, convert to long format and creates standard variable names for x axis, y axis - mean and category

# plotting data
plt <- nice_plot(data_formatted, x_axis_label, y_axis_label, legend_title)
plt <- plt + theme(legend.justification = c(1, 1), legend.position = c(1, 1), legend.box.margin=margin(rep(10,4))) # plot legend on top left

# save plot (same filename as the sheet name) ; width and height in inches
ggsave(str_c('plots/', sheet_name, '.', image_format), width = 4, height = 4)
