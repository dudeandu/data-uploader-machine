setwd("~/Desktop/torstar-projects/00-COVID-cases-in-schools-dashboard/data-uploader/data-uploader-machine")

# install.packages("rvest")
# install.packages("dplyr")
# install.packages("stringr")

library("rvest")
library("dplyr")
library("stringr")

#########################################################################################################
#########################################################################################################
#########################################################################################################
# monavenir
link <- "https://www.cscmonavenir.ca/infos-covid-19/"
page <- read_html(link)
# all_monavenir = page %>% html_nodes("#elementor-tab-content-1591 .elementor-text-editor.elementor-clearfix p") %>% html_text() %>% str_remove(., "\t")
all_monavenir = page %>% html_nodes("#elementor-tab-content-1591 .elementor-text-editor") %>% html_text() %>% gsub("\t","",.) %>% gsub("\n","",.)
all_monavenir

set_headers <- c("date","Establishment","Region","Cases","Additional information")
ncolumns <- 5

all_monavenir_DF <- data_frame()
counter <- 1
rowmaker <- character()
toprowsoff <- 1
bottomrowsoff <- 0
for(i in toprowsoff:(length(all_monavenir)) ) {
  
  # print(all_monavenir[i])
  # print(i)
  # print(counter)
  rowmaker <- c(rowmaker, all_monavenir[i])
  
  if (counter == ncolumns) {
    print(rowmaker)
    all_monavenir_DF <- rbind(all_monavenir_DF,rowmaker)
    counter <- 1
    rowmaker <- character()
  } else {
    counter <- counter + 1
  }
}

colnames(all_monavenir_DF) <- set_headers

write.csv(all_monavenir_DF,"boardsRaw/all_monavenir_RAW.csv")


#########################################################################################################
#########################################################################################################
#########################################################################################################
# viamonde
link <- "https://csviamonde.ca/parents/infos-covid-19/lutter-contre-la-covid-19/"
page <- read_html(link)
all_viamonde = page %>% html_nodes("#c10765 table td") %>% html_text() %>% str_remove(., "\t")
all_viamonde

set_headers <- c("Establishment","Students","Staff","Additional information")
ncolumns <- 4

all_viamonde_DF <- data_frame()
counter <- 1
rowmaker <- character()
toprowsoff <- 1*ncolumns+3
bottomrowsoff <- 0
for(i in toprowsoff:(length(all_viamonde)-bottomrowsoff*ncolumns)) {
  
  # print(all_viamonde[i])
  # print(i)
  # print(counter)
  rowmaker <- c(rowmaker, all_viamonde[i])
  
  if (counter == ncolumns) {
    print(rowmaker)
    all_viamonde_DF <- rbind(all_viamonde_DF,rowmaker)
    counter <- 1
    rowmaker <- character()
  } else {
    counter <- counter + 1
  }
}

colnames(all_viamonde_DF) <- set_headers

write.csv(all_viamonde_DF,"boardsRaw/all_viamonde_RAW.csv")


#########################################################################################################
#########################################################################################################
#########################################################################################################
#TDSB

link <- "https://docs.google.com/spreadsheets/d/1gEipMl79REabV5GPuJnPeziC3DbYhA92U_BxpzdKX_Y/htmlembed/sheet?gid=0&"
page <- read_html(link)
all_TDSB = page %>% html_nodes("td") %>% html_text() %>% str_remove(., "COVAX roll-out - ")
all_TDSB

set_headers <- character()
ncolumns <- 5
for(i in 1:ncolumns+1) {
  set_headers <- c(set_headers,all_TDSB[i])
  print(all_TDSB[i])
}

all_TDSB_DF <- data_frame()
counter <- 1
rowmaker <- character()
toprowsoff <- 2 + ncolumns*2
bottomrowsoff <- 3
for(i in toprowsoff:(length(all_TDSB)-bottomrowsoff*ncolumns)) {
  
  # print(all_TDSB[i])
  # print(i)
  # print(counter)
  rowmaker <- c(rowmaker, all_TDSB[i])
  
  if (counter == ncolumns) {
    print(rowmaker)
    all_TDSB_DF <- rbind(all_TDSB_DF,rowmaker)
    counter <- 1
    rowmaker <- character()
  } else {
    counter <- counter + 1
  }
}

colnames(all_TDSB_DF) <- set_headers

write.csv(all_TDSB_DF,"boardsRaw/all_TDSB_RAW.csv")


#########################################################################################################
#########################################################################################################
#########################################################################################################
#TCDSB

link <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vR4fnRpWN-7TxlNyW0oOoC9BKUGTm8sp-JdDcCYBwcmfTjnWEQKKJRNiaQtOA6RoOp27mTa3e_JRumy/pubhtml?gid=458011542&rm=minimal&chrome=false&headers=false&gid=0"
page <- read_html(link)
all_TCDSB = page %>% html_nodes("td") %>% html_text() %>% str_remove(., "COVAX roll-out - ")
all_TCDSB

set_headers <- c("School Name", "School Status", "Confirmation Date", "Student", "Staff", "Case Status")
ncolumns <- 7

all_TCDSB_DF <- data_frame()
counter <- 1
rowmaker <- character()
toprowsoff <- fromthisrow+ncolumns+ncolumns+1
bottomrowsoff <- 28
thisSchool <- character()
thisSchoolStatus <- character()
# Data seems to begin on item 90
for(i in 90:(length(all_TCDSB)-bottomrowsoff)) {
  
  # print(all_TDSB[i])
  # print(i)
  # print(counter)
  if (all_TCDSB[i+5] != "Active" && counter == 2){
    rowmaker <- c(rowmaker, thisSchool,thisSchoolStatus, all_TCDSB[i]) 
    counter <- 4
  } else if(counter > 1) {
    if (counter == 2) {
      thisSchool <- all_TCDSB[i]
    } else if (counter == 3) {
      thisSchoolStatus <- all_TCDSB[i]
    }
    rowmaker <- c(rowmaker, all_TCDSB[i]) 
  }
  
  if (counter == ncolumns) {
    print(rowmaker)
    all_TCDSB_DF <- rbind(all_TCDSB_DF,rowmaker)
    counter <- 1
    rowmaker <- character()
  } else {
    counter <- counter + 1
  }
}

colnames(all_TCDSB_DF) <- set_headers

write.csv(all_TCDSB_DF,"boardsRaw/all_TCDSB_RAW.csv")



