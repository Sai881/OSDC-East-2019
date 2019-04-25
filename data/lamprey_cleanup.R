library(tidyverse)

## larval data
raw_data <- read_csv("./larval_density_RAW_Data.csv")

## Look at data
raw_data %>% pull(Fluor) %>% unique()
raw_data %>% pull(Sample) %>% unique()
raw_data %>% pull(Inhibited) %>% unique()

## Remove blanks and ext control
raw_data_2 <-
    raw_data %>%
    filter(!grepl("ext", Sample) & !grepl("blank", Sample))

raw_data_2 <- 
    raw_data_2 %>%
    mutate(tank  = gsub("(tank\\d+)_(\\d+)", "\\1", Sample),
           DNA   = gsub("(tank\\d+)_(\\d+)", "\\2", Sample),
           Detect = ifelse(is.na(Copies), 0, 1))

write_csv(x = raw_data_2, path = "./lamprey_lab_DNA.csv")


## Adult data
raw_data <- read_csv("./adult_density_RAW_Data.csv")

## Look at data
raw_data %>% pull(Fluor) %>% unique()
raw_data %>% pull(Sample) %>% unique()
raw_data %>% pull(Inhibited) %>% unique()

## Remove blanks and ext control
raw_data_2 <-
    raw_data %>%
    filter(!grepl("CB", Sample) & !grepl("Neg-Con", Sample) &
           !grepl("Well", Sample) & !grepl("FB", Sample))

raw_data_2 <- 
    raw_data_2 %>%
    mutate(tank  = gsub("(\\d+L)-(\\d[A-Z])", "\\2", Sample),
           stock = gsub("(\\d+L)-(\\d[A-Z])",  "\\1", Sample)) %>%
    filter(Fluor == "FAM")
raw_data_2

write_csv(x = raw_data_2, path = "./lamprey_adult_lab_DNA.csv")
