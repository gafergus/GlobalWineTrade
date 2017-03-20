library(dplyr)
library(tidyr)
# Write a function to tidy the first set of data tables.
# Read in the csv files and tidy the data for the groeth from 
tidy_growth_data <- function(name, value_string) {
    df <- read.csv(name, na.strings = c('', 'na'), header=TRUE) %>%
          gather(key='5 Year Range', value = value_string, 3:12)
    return(df)
}
df1 <- tidy_growth_data('Vina_area.csv', 'Total grapevine area, 000 ha')

df1 <- tidy_growth_data('Vina_area.csv') %>%
                 rename('Total grapevine area, 000 ha' = value_string)
df2 <- tidy_growth_data('Vol_exports.csv') %>%
                 rename('Volume of wine exports, ML' = value_string)
df3 <- tidy_growth_data('Vol_production.csv') %>%
                 rename('Volume of wine production, ML' = value_string)
df4 <- tidy_growth_data('Vol_Consumption.csv') %>%
                 rename('Volume of beverage wine consumption, ML' = value_string)
df5 <- tidy_growth_data('Vol_Consumption_per_capita.csv') %>%
                 rename('Volume of beverage wine consumption per capita, litres' = value_string)
df6 <- tidy_growth_data('Vol_imports.csv') %>%
                 rename('Volume of wine imports, ML' = value_string)
df7 <- tidy_growth_data('Vol_net_imports.csv') %>%
                 rename('Volume of wine net imports, ML' = value_string)
df8 <- tidy_growth_data('Value_exports.csv') %>%
                 rename('Value of wine exports, US$ million' = value_string)
df9 <- tidy_growth_data('Value_imports.csv') %>%
                 rename('Value of wine imports, US$ million' = value_string)

# Merge the outputs into a data frame
df_list = list(df1, df2, df3, df4, df5, df6, df7, df8, df9)
df10 <- Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), df_list)
# remove some extra characters and convert the character columns to factors.
df10 <- df10 %>%
  mutate(`5 Year Range` = gsub('X','' ,`5 Year Range`)) %>%
  mutate(`5 Year Range` = gsub('\\.','-' ,`5 Year Range`))
as.factor(df10$Region)
as.factor(df10$Country)
as.factor(df10$`5 Year Range`)
growth_data <- df10

# Now tidy the data from the data for bilateral trade







