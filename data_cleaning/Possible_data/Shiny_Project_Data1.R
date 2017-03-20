library(dplyr)
library(tidyr)
# Write a function to tidy the first set of data tables.
file_names = c('Vina_area.csv', 
               'Vol_exports.csv', 
               'Vol_production.csv', 
               'Vol_Consumption.csv',
               'Vol_Consumption_per_capita.csv',
               'Vol_imports.csv', 
               'Vol_net_imports.csv',
               'Value_exports.csv', 
               'Value_imports.csv', 
               'Alcohol_consumption_per_capita.csv',
               'Adult_pop.csv', 
               'GDP_per_capita.csv', 
               'GDP.csv')

col_names = c('Total grapevine area, 000 ha', 
              'Volume of wine exports, ML', 
              'Volume of wine production, ML', 
              'Volume of wine consumption, ML', 
              'Volume of wine consumption per capita, litres', 
              'Volume of wine imports, ML', 
              'Volume of wine net imports, ML', 
              'Value of wine exports, US$ million',
              'Value of wine imports, US$ million', 
              'Total alcohol consumption per capita (litres of alcohol)',
              'Adult population (millions)', 
              'GDP per capita, US$ current', 
              'GDP, US$ current')

# 
cols <- c('X1961.1964','X1965.1969','X1970.1974','X1975.1979','X1980.1984',
          'X1985.1989','X1990.1994','X1995.1999','X2000.2004','X2005.2009')

tidy_growth_data <- function(name, column_names) {
    df <- read.csv(name, na.strings = c('', 'na'), header=TRUE)
    df[cols] <- lapply(df[cols], as.numeric)
    df <- gather(df ,key='5 Year Range', value = value_string, 3:12)
    return(df)
}
df1 <- tidy_growth_data('Vina_area.csv') %>%
                 rename('Total grapevine area, 000 ha' = value_string)
df2 <- tidy_growth_data('Vol_exports.csv') %>%
                 rename('Volume of wine exports, ML' = value_string)
df3 <- tidy_growth_data('Vol_production.csv') %>%
                 rename('Volume of wine production, ML' = value_string)
df4 <- tidy_growth_data('Vol_Consumption.csv') %>%
                 rename('Volume of beverage wine consumption, ML' = value_string)
df5 <- tidy_growth_data('Vol_Consumption_per_capita.csv', cols) %>%
                 rename('Volume of beverage wine consumption per capita, litres' = value_string)
df6 <- tidy_growth_data('Vol_imports.csv') %>%
                 rename('Volume of wine imports, ML' = value_string)
df7 <- tidy_growth_data('Vol_net_imports.csv') %>%
                 rename('Volume of wine net imports, ML' = value_string)
df8 <- tidy_growth_data('Value_exports.csv') %>%
                 rename('Value of wine exports, US$ million' = value_string)
df9 <- tidy_growth_data('Value_imports.csv') %>%
                 rename('Value of wine imports, US$ million' = value_string)
df10  <- tidy_growth_data('Adult_pop.csv') %>%
                   rename('Adult population (millions)' = value_string)
df11 <- tidy_growth_data('GDP_per_capita.csv') %>%
                  rename('GDP per capita, US$ current' = value_string)
df12  <- tidy_growth_data('Alcohol_consumption_per_capita.csv') %>%
                   rename('Total alcohol consumption per capita (litres of alcohol)' = value_string)
df13<- tidy_growth_data('GDP.csv') %>%
                  rename('GDP, US$ current'= value_string)
# Merge the outputs into a data frame
df_list = list(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12, df13)
df14 <- Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), df_list) %>%
# remove some extra characters and convert the character columns to factors.
        mutate(`5 Year Range` = gsub('X','' ,`5 Year Range`)) %>%
        mutate(`5 Year Range` = gsub('\\.','-' ,`5 Year Range`))
df14$Region <- as.factor(df14$Region)
df14$Country <- as.factor(df14$Country)
df14$`5 Year Range` <- as.factor(df14$`5 Year Range`)
saveRDS(df14, '1961-2009_data.rds')

# Now tidy the data from the data for bilateral trade







