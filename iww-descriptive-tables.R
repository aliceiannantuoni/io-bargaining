### Replication File for "Project Design Decisions of Egalitarian and Non-Egalitarian International Organizations: Evidence from the Global Environment Facility and the World Bank" ###

# Alice Iannantuoni, Charla Waeiss, and Matthew S. Winters 

#######################################################
# R Code for Descriptive Statistics in Tables 1 and 2 #
#######################################################

library(tidyverse)
library(pastecs)

# Load replication data file:
data = read_csv("ReplicationFile20190918.csv")


#### Table 1 ####
options(scipen = 999)

# Focus on the 1,256 projects in our sample
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwviableproj) %>% 
  sum(na.rm = TRUE)

# Total project cost: iwwcoded_sum
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwcoded_sum) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwcoded_sum) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwcoded_sum) %>% 
  stat.desc() # Non-WB

# GEF Grant: iwwgef_grant
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwgef_grant) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwgef_grant) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwgef_grant) %>% 
  stat.desc() # Non-WB

# GEF Share: iwwgef_pct
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwgef_pct) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwgef_pct) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwgef_pct) %>% 
  stat.desc() # Non-WB

# IA Funding: iwwia_funding
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwia_funding) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwia_funding) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwia_funding) %>% 
  stat.desc() # Non-WB

# IA Share: iwwia_pct
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwia_pct) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwia_pct) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwia_pct) %>% 
  stat.desc() # Non-WB

# Foreign Funding: iwwforeign_funding
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwforeign_funding) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwforeign_funding) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwforeign_funding) %>% 
  stat.desc() # Non-WB

# Foreign Share: iwwforeign_pct
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwforeign_pct) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwforeign_pct) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwforeign_pct) %>% 
  stat.desc() # Non-WB

# Recipient Funding: iwwrecipient_funding
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwrecipient_funding) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwrecipient_funding) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwrecipient_funding) %>% 
  stat.desc() # Non-WB

# Recipient Share: iwwrecipient_pct
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwrecipient_pct) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwrecipient_pct) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwrecipient_pct) %>% 
  stat.desc() # Non-WB

# External Funding: iwwallexternal_funding
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwallexternal_funding) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwallexternal_funding) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwallexternal_funding) %>% 
  stat.desc() # Non-WB

# External Share: iwwallexternal_pct
data %>% 
  subset(iwwviableproj == 1) %>% 
  select(iwwallexternal_pct) %>% 
  stat.desc() # all 

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 1) %>% 
  select(iwwallexternal_pct) %>% 
  stat.desc() # WB

data %>% 
  subset(iwwviableproj = 1) %>% 
  subset(iwwibrd == 0) %>% 
  select(iwwallexternal_pct) %>% 
  stat.desc() # Non-WB


#### Table 2 ####
data %>%
  filter(!is.na(iwwimplementing_agency)) %>%
  group_by(iwwimplementing_agency) %>%
  summarise(
    `World Bank` = max(iwwibrd, na.rm=T),
    `Dev. Bank` = max(iwwdevbnk, na.rm=T),
    `N / 1,256` = sum(iwwviableproj, na.rm=T),
    `N / 1,411` = n()
  )

