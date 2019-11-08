# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# calling libraries ; make sure they are installed (install.packages)
library(readxl); library(magrittr); library(tidyverse); library(ggrepel); library(rlist)  

# set theme for plotting
theme_set(theme_bw() + # simple theme with border and gridlines
            theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) # remove gridlines
          )

# Data formatting function - cleans data, convert to long format and creates standard variable names for x axis, y axis - mean and category
clean_formatting <- function(data_raw)
{
  names(data_raw)[1] <- 'x_variable'  # rename the first column header as x axis variable
  data_long <- gather(data_raw, category, data, -x_variable)  # consolidate all category types into long format
  data_long_1 <- data_long %>%  separate(category, c('category', 'data_type'), sep = '_')  # split the mean and stdev from category_skeletal
  data_wide <- data_long_1 %>% spread(data_type, data)  # split the mean and stdev columns
  
  names(data_wide) -> temp_names # store temporary variable
  temp_names[!str_detect(temp_names, 'x_var|category|stdev')] -> redundant_column_names # columns with mean named with different names captured here
  if(sum(!str_detect(temp_names, 'x_var|category|stdev')) > 1)  unite(data_wide, mean_value, redundant_column_names, remove = T, na.rm = F) # merge the redundant columns and name them mean_value
  else names(data_wide)[!str_detect(temp_names, 'x_var|category|stdev')] <- 'mean_value' # rename the y variable mean to be mean_value
  
  remove(data_raw, data_long, data_long_1, temp_names, redundant_column_names) # remove temporary variables
  data_wide # output
}

# plotting
nice_plot <- function(data_final, x_axis_label, y_axis_label, legend_title, errorbar_width = 10)
{
  plt <- data_final %>% ggplot(aes(x = x_variable, y = mean_value, colour = category)) + geom_point(size = 2) + geom_errorbar(aes(ymin = mean_value - stdev, ymax = mean_value + stdev, width = errorbar_width)) +
    scale_color_brewer(palette="Dark2") + 
    ylab(y_axis_label) + xlab(x_axis_label) + labs(shape = legend_title, colour = legend_title)
}

# modifying plots
addSmallLegend <- function(myPlot, pointSize = 0.5, textSize = 3, spaceLegend = 0.1) {
  myPlot +
    guides(shape = guide_legend(override.aes = list(size = pointSize)),
           color = guide_legend(override.aes = list(size = pointSize))) +
    theme(legend.title = element_text(size = textSize), 
          legend.text  = element_text(size = textSize),
          legend.key.size = unit(spaceLegend, "lines"))
}