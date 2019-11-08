# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# User input section ----

# file name input parameters
file_name <- "../2019 SSSA meeting.xlsx"
sheet_name <- "Biochar-goethite"

# axis labels, legend label
x_axis_label <- bquote('Treatment')
y_axis_label <- bquote('Measurement')
legend_title <- 'Position'
errorbar_width <- .5
image_format <- 'png' # image format: (png or PDF). Export PDF for high resolution vector image for publication (editable in Inkscape or Illustrator software)


# data read and processing section ----

# load required packages
source('./general_functions.R')

# read excel file
data_raw <- read_xlsx(file_name, sheet = sheet_name) # input the excel file

# data formatting
data_formatted <- clean_formatting(data_raw) # cleans data, convert to long format and creates standard variable names for x axis, y axis - mean and category

# plotting data
plt <- data_formatted %>% ggplot(aes(x = x_variable, y = mean_value)) + geom_col(size = 2) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) +
  scale_color_brewer(palette="Dark2") + facet_grid(~ category, scales = 'free') + coord_flip() +
  ylab(y_axis_label) + xlab(x_axis_label) + labs(shape = legend_title, colour = legend_title)

# save plot (same filename as the sheet name) ; width and height in inches
ggsave(str_c('plots/', sheet_name, '.', image_format), width = 5, height = 4)

# extra command small legend (play with the parameters)
# addSmallLegend(plt, 1,6,.2)
