setwd("~/Desktop/torstar-projects/00-COVID-cases-in-schools-dashboard/data-uploader/data-uploader-machine")

# install.packages("rvest")
# install.packages("dplyr")
# install.packages("stringr")

library("rvest")
library("dplyr")
library("stringr")

#TDSB
link <- "https://docs.google.com/spreadsheets/d/1gEipMl79REabV5GPuJnPeziC3DbYhA92U_BxpzdKX_Y/htmlembed/sheet?gid=0&"
page <- read_html(link)
all_TDSB = page %>% html_nodes("td") %>% html_text() %>% str_remove(., "COVAX roll-out - ")
all_TDSB

#TCDSB
link <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vR4fnRpWN-7TxlNyW0oOoC9BKUGTm8sp-JdDcCYBwcmfTjnWEQKKJRNiaQtOA6RoOp27mTa3e_JRumy/pubhtml?gid=458011542&rm=minimal&chrome=false&headers=false&gid=0"
page <- read_html(link)
all_TCDSB = page %>% html_nodes("td") %>% html_text() %>% str_remove(., "COVAX roll-out - ")
all_TCDSB

# For monavenir
link <- "https://www.cscmonavenir.ca/infos-covid-19/"
page <- read_html(link)
all_monavenir = page %>% html_nodes("#elementor-tab-content-1591 .elementor-text-editor.elementor-clearfix p") %>% html_text() %>% str_remove(., "\t")
all_monavenir

# For viamonde
link <- "https://csviamonde.ca/parents/infos-covid-19/lutter-contre-la-covid-19/"
page <- read_html(link)
all_viamonde = page %>% html_nodes("#c10765 table td") %>% html_text() %>% str_remove(., "\t")
all_viamonde


#########################################################################################################
#########################################################################################################
#########################################################################################################
# TDSB 

set_headers <- character()
ncolumns <- 5
for(i in 2:ncolumns+1) {
  set_headers <- c(set_headers,all_TDSB[i])
  print(all_TDSB[i])
}

all_TDSB_DF <- data_frame()
counter <- 1
rowmaker <- character()
for(i in 7:length(all_TDSB)) {
  
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





