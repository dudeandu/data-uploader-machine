setwd("~/Desktop/torstar projects/00-COVID-cases-in-schools-dashboard/data-uploader/data-uploader-machine")

# install.packages("plyr")
require("devtools")
# require("system")

library("plyr")
# library(shell)

# list.files()

# data_active_cases_raw <- read.csv("schoolsactivecovid.csv", header = TRUE)
data_summary_cases_raw <- read.csv("https://data.ontario.ca/dataset/b1fef838-8784-4338-8ef9-ae7cfd405b41/resource/7e644a48-6040-4ee0-9216-1f88121b21ba/download/schoolcovidsummary2021_2022.csv", header = TRUE)
data_active_cases_raw <- read.csv("https://data.ontario.ca/dataset/b1fef838-8784-4338-8ef9-ae7cfd405b41/resource/dc5c8788-792f-4f91-a400-036cdf28cfe8/download/schoolrecentcovid2021_2022.csv", header = TRUE)
data_allSchools_raw <- read.csv("publicly_funded_schools_xlsx_august_2021_en.csv", header = TRUE)

## GET the last date
lastDate <- data_active_cases_raw[nrow(data_active_cases_raw),"collected_date"]

## GET all instances whit the matching last date
lastdayinstances <- data_active_cases_raw[ which(data_active_cases_raw$collected_date == lastDate), ] 

# get the school list 
school_number_list <- unique(data_allSchools_raw$School.Number)

# make all school numbers/id numeric
lastdayinstances$school_id <- as.numeric(lastdayinstances$school_id)
data_allSchools_raw$School.Number <- as.numeric(data_allSchools_raw$School.Number)

## build a data frame with schools info and cases
all_schools_cases_df <- data_allSchools_raw

# Add the columns from the active cases data frame
all_schools_cases_df$collected_date <- rep(FALSE,times = nrow(all_schools_cases_df))
all_schools_cases_df$reported_date <- rep(FALSE,times = nrow(all_schools_cases_df))
all_schools_cases_df$confirmed_student_cases <- rep(0,times = nrow(all_schools_cases_df))
all_schools_cases_df$confirmed_staff_cases <- rep(0,times = nrow(all_schools_cases_df))
all_schools_cases_df$confirmed_unspecified_cases <- rep(0,times = nrow(all_schools_cases_df))
all_schools_cases_df$total_confirmed_cases <- rep(0,times = nrow(all_schools_cases_df))


## search the active cases database, and change the number of cases based on a school id search
## some school boards are in there, so have to make an if statement looking for NAs in school id, and then match to the school board name
for(i in 1:nrow(lastdayinstances)) {
  
  # print(i)
  # get the schoolid
  temp_schoolid <- lastdayinstances[i,"school_id"]
  print(temp_schoolid)
  
  if ( !is.na(temp_schoolid) ) {
    print(all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "School.Number" ])
    
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "collected_date"] <- lastdayinstances[i,"collected_date"]
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "reported_date"] <- lastdayinstances[i,"reported_date"]
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "confirmed_student_cases"] <- lastdayinstances[i,"confirmed_student_cases"]
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "confirmed_staff_cases"] <- lastdayinstances[i,"confirmed_staff_cases"]
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "confirmed_unspecified_cases"] <- lastdayinstances[i,"confirmed_unspecified_cases"]
      all_schools_cases_df[ which(all_schools_cases_df$School.Number == temp_schoolid), "total_confirmed_cases"] <- lastdayinstances[i,"total_confirmed_cases"]
  }  
  
  # new_temp_data <- data_edges_raw[ which(data_edges_raw$timezone == timezones_list[i]), ]
  # temp_freq_usernames <- count(new_temp_data, 'username')
  
  # timezonerow <- rep(timezones_list[i],times = nrow(temp_freq_usernames))
  # temp_freq_usernames_daily <- cbind(temp_freq_usernames,timezonerow)
  # 
  # edges_aggregated_byusername <- rbind(edges_aggregated_byusername,temp_freq_usernames_daily)
}



# add an id number to all instances of the last day
# !!!!!!!! might be better to do this to the larger data frame at the end
all_schools_cases_df$id <- seq.int(0,nrow(all_schools_cases_df)-1)

colnames(all_schools_cases_df) <- c("Region","Board_Number","Board_Name","Board_Type","Board_Language","School_Number","School_Name","School_Level","School_Language","School_Type","School_Special_Conditions_Code","Suite","PO_Box","Street","City","Province","Postal_Code","Latitude","Longitude","Phone","Fax","Grade_Range","Date_Open","School_Email","School_Website","Board_Website","collected_date","reported_date","confirmed_student_cases","confirmed_staff_cases","confirmed_unspecified_cases","total_confirmed_cases","id")


## svae the file into a new CSV
write.csv(all_schools_cases_df,"schoolsactivecovid_adaiID.csv", row.names = FALSE)

write.csv(data_summary_cases_raw,"schoolcovidsummary2021_2022.csv", row.names = FALSE)





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


