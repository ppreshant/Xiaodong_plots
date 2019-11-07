# Purpose: Grab data from excel sheet and plot publication quality graphs
# Author: Prashant K. 
# date: 5 Nov 2019

# load required packages
source('./general_functions.R')

# file name input parameters
file_name <- "../2019 SSSA meeting.xlsx"
sheet_name <- "Fresh biochar_skeletal"

# read excel file
data_raw <- read_xlsx(file_name, sheet = sheet_name) # input the excel file

# data formatting
data_long <- gather(data_raw, feedstock, data, -Temp) # consolidate all feedstock types into long format
data_long_1 <- data_long %>%  separate(feedstock, c('feedstock', 'data_type'), sep = '_') # split the mean and stdev from feedstock_skeletal
data_wide <- data_long_1 %>% spread(data_type, data) # split the mean and stdev columns

remove(data_raw, data_long, data_long_1)
# plotting data

plt <- data_wide %>% ggplot(aes(x = Temp, y = skeletal, colour = feedstock)) + geom_point(size = 2) + geom_errorbar(aes(ymin = skeletal - stdev, ymax = skeletal + stdev, width = 10)) +
  scale_color_brewer(palette="Dark2") + 
  ylab(bquote('Skeletal density (g' ~ cm^-3 ~ ')')) + xlab(bquote('Pyrolysis temperature (' ~ degree*C ~ ')')) + labs(shape = 'Feedstock', colour = 'Feedstock')

ggsave('plots/fresh_charcoal_skeletal_density1.png', width = 6, height = 4)
