# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# User input section ----

# file name input parameters
file_name <- "../2019 SSSA meeting.xlsx"
sheet_name <- "Biochar-goethite"

# axis labels, legend label
x_axis_label <- bquote('')
y_axis_label <- bquote('Measurement')
legend_title <- 'Biochar\ntreatment'
errorbar_width <- .1
image_format <- 'png' # image format: (png or PDF). Export PDF for high resolution vector image for publication (editable in Inkscape or Illustrator software)


# data read and processing section ----

# load required packages
source('./general_functions.R')

# read excel file
data_raw <- read_xlsx(file_name, sheet = sheet_name) # input the excel file

# data formatting
data_formatted <- clean_formatting(data_raw) # cleans data, convert to long format and creates standard variable names for x axis, y axis - mean and category
data_formatted$category %<>% fct_relevel('Skeletal', 'Envelope', 'Porosity')  # change plotting order as needed

# plotting data
plt <- data_formatted %>% ggplot(aes(x = '', y = mean_value, shape = x_variable)) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) + geom_point(size = 3, fill = 'white') +
  scale_color_brewer(palette="Dark2") + facet_wrap(~ category, scales = 'free_y') + scale_shape_manual(values = c(21,19)) +
  ylab(y_axis_label) + xlab(x_axis_label) + labs(shape = legend_title, colour = legend_title)

# plotting data : bars
plt.bars <- data_formatted %>% ggplot(aes(x = x_variable, y = mean_value, fill = x_variable)) + geom_col(size = 2) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) +
  scale_fill_brewer(palette="Dark2") + facet_wrap(~ category, scales = 'free_y') +
  ylab(y_axis_label) + xlab('Biochar treatment') + labs(fill = legend_title)

# plotting data: horizontal bars
plt.horizontal.bars <- data_formatted %>% ggplot(aes(x = x_variable, y = mean_value, fill = x_variable)) + geom_col(size = 2) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) +
  scale_fill_brewer(palette="Dark2") + facet_wrap(~ category, scales = 'free_x', ncol = 1) + coord_flip() +
   ylab(y_axis_label) + xlab('Biochar treatment') + labs(fill = legend_title)

# dumbbell plot ; work in progress
# plt <- data_formatted %>% ggplot(aes(x = x_variable, y = mean_value)) + geom_col(size = 2) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) +
#   scale_color_brewer(palette="Dark2") + facet_grid(~ category, scales = 'free') + coord_flip() +
#   ylab(y_axis_label) + xlab(x_axis_label) + labs(shape = legend_title, colour = legend_title)

# save plot (same filename as the sheet name) ; width and height in inches
ggsave(str_c('plots/', sheet_name, '(horizontal bars).', image_format), plt.horizontal.bars, width = 6, height = 4)

# extra command small legend (play with the parameters)
# addSmallLegend(plt, 1,6,.2)
