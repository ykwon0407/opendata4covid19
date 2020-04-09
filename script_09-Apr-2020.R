#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# Short script to extract relevant data from COVID-19 database
# v 0.1
# 09-Apr-2020
# Katie Heath: katie.heath@burnet.edu.au
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

#--------------------------------------
# 1. Install and load packages to read excel files
#--------------------------------------

# This package allows us to easily read and modify excel files

if (! require("readxl")) install.packages("readxl")
library(readxl)

#--------------------------------------
# 2. Read test data, sheet by sheet
#--------------------------------------

# We read each sheet of the excel files as a separate object in our workspace

# Corona claim data
co19_t200_trans_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=2)
co19_t300_trans_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=3)
co19_t400_trans_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=4)
co19_t530_trans_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=5)

# Medical use history data
co19_t200_twjhe_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=6)
co19_t300_twjhe_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=7)
co19_t400_twjhe_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=8)
co19_t530_twjhe_dn = read_excel("./Data/HIRA COVID-19 Sample Data_20200325.xlsx", sheet=9)


#--------------------------------------
# 3. Create relevant tables from data
#--------------------------------------

#--------------------------------------
# 3.i. Table 1 - Demographic data
#--------------------------------------

table1 = co19_t200_trans_dn[,c(
  "MID", "SEX_TP_CD", "PAT_AGE"
)]

# Get only the unique entries
# there may be some individuals with >1 hospital record
table1 = unique(table1)



#--------------------------------------
# 3.ii. Table 2 - Care information - COVID
#--------------------------------------


table2 = co19_t200_trans_dn[,c(
  "MID", "CL_CD","FOM_TP_CD","MAIN_SICK","SUB_SICK","DGSBJT_CD",
  "RECU_FR_DD","RECU_TO_DD","FST_DD","VST_DDCNT","RECU_DDCNT",
  "DGRSLT_TP_CD"
)]

# get only the medical records which match with table 1
table2 = table2[which(table2$MID %in% table1$MID),]


#--------------------------------------
# 3.iii. Table 3 - Care information - MEDICAL HISTORY
#--------------------------------------


table3 = co19_t200_twjhe_dn[,c(
  "MID", "CL_CD","FOM_TP_CD","MAIN_SICK","SUB_SICK","DGSBJT_CD",
  "RECU_FR_DD","RECU_TO_DD","FST_DD","VST_DDCNT","RECU_DDCNT",
  "DGRSLT_TP_CD"
)]

# get only the medical records which match with table 1
table3 = table3[which(table3$MID %in% table1$MID),]


#--------------------------------------
# 3.iv. Table 4 - Care information - COVID
#--------------------------------------

table4 = co19_t530_trans_dn[,c(
  "MID", "PRSCP_GRANT_NO","TOT_INJC_DDCNT_EXEC_FQ", "GNL_CD"
)]

# get only the medical records which match with table 1
table4 = table4[which(table4$MID %in% table1$MID),]

# Get the number of characters in the number/string
nch = nchar(table4$PRSCP_GRANT_NO[1])

# separate PRSCP_GRANT_NO by year, month, day, remaining, etc
table4$PRSCP_YEAR  = substring(table4$PRSCP_GRANT_NO, 1, 4)
table4$PRSCP_MONTH  = substring(table4$PRSCP_GRANT_NO, 5, 6)
table4$PRSCP_DAY  = substring(table4$PRSCP_GRANT_NO, 7, 8)
table4$PRSCP_REM  = substring(table4$PRSCP_GRANT_NO, 9, nch)


#--------------------------------------
# 3.v. Table 5 - Care information - MEDICAL HISTORY
#--------------------------------------

table5 = co19_t530_twjhe_dn[,c(
  "MID", "PRSCP_GRANT_NO","TOT_INJC_DDCNT_EXEC_FQ", "GNL_CD"
)]

# get only the medical records which match with table 1
# we expect there to be no records or overlap for the saple dataset
table5 = table5[which(table5$MID %in% table1$MID),]

# Get the number of characters in the number/string
nch = nchar(table5$PRSCP_GRANT_NO[1])

# separate PRSCP_GRANT_NO by year, month, day, remaining, etc
table5$PRSCP_YEAR  = substring(table5$PRSCP_GRANT_NO, 1, 4)
table5$PRSCP_MONTH  = substring(table5$PRSCP_GRANT_NO, 5, 6)
table5$PRSCP_DAY  = substring(table5$PRSCP_GRANT_NO, 7, 8)
table5$PRSCP_REM  = substring(table5$PRSCP_GRANT_NO, 9, nch)



#--------------------------------------
# 5. Write the output file
#--------------------------------------

# This section outpute the data into new .csv files which we can open and use.

write.csv(table1, "./Results/table1.csv", row.names = F)
write.csv(table2, "./Results/table2.csv", row.names = F)
write.csv(table3, "./Results/table3.csv", row.names = F)
write.csv(table4, "./Results/table4.csv", row.names = F)
write.csv(table5, "./Results/table5.csv", row.names = F)
