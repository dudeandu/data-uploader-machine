setwd("~/Desktop/00-COVID-cases-in-schools-dashboard/Data-wrangling-R")

# install.packages("plyr")
require("devtools")
# require("system")

library("plyr")
# library(shell)

# list.files()

# data_active_cases_raw <- read.csv("schoolsactivecovid.csv", header = TRUE)
data_active_cases_raw <- read.csv("https://data.ontario.ca/dataset/b1fef838-8784-4338-8ef9-ae7cfd405b41/resource/8b6d22e2-7065-4b0f-966f-02640be366f2/download/schoolsactivecovid.csv", header = TRUE)
data_allSchools_raw <- read.csv("publicly_funded_schools_xlsx_august_2021_en.csv", header = TRUE)

## GET the last date
lastDate <- data_active_cases_raw[nrow(data_active_cases_raw),"collected_date"]

## GET all instances whit the matching last date
lastdayinstances <- data_active_cases_raw[ which(data_active_cases_raw$collected_date == lastDate), ] 

# add an id number to all instances of the last day
lastdayinstances$id <- seq.int(0,nrow(lastdayinstances)-1)

## svae the file into a new CSV
write.csv(lastdayinstances,"schoolsactivecovid_adaiID.csv", row.names = FALSE)





# shell('git commit -a -m "update for  todays date"')
# shell('git push -u origin master')

print('done')

########
## install_github("dudeandu/canada_covid")
## git remote add origin git@github.com:dudeandu/gituploader_test.git



### just run this on the command line
## Rscript csv_uploader_test.R

### commits
## git add canada_data_raw.csv
## git add data_heathlunits_raw.csv
## git commit -a -m "update for  today's date" 

#### push 
## git push -u origin master


