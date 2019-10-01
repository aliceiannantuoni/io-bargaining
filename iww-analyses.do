/* Replication File for "Project Design Decisions of Egalitarian and Non-Egalitarian 
 International Organizations: Evidence from the Global Environment Facility and the World Bank" */

/* Alice Iannantuoni, Charla Waeiss, and Matthew S. Winters */

/* Variables for the GEF analyses are described in the text; see corresponding 
 regression tables. Variables for the World Bank analysis are described below. */

*Clear the memory:
drop _all

*Continue to scroll down and without waiting for me to press the space bar:
set more 1

*Open dataset 
insheet using ReplicationFile20190918.csv

*******************************
******* T-TESTS IN TEXT *******
*******************************

*** Project Year
ttest iwwproject_year, by(iwwviableproj)

*** Identify quartiles of data for project year by dropped / retained projects
by iwwviableproj, sort: summarize iwwproject_year, detail 

*** Run t-tests on total population across groups and on quantiles of project year
*** determined from the dropped projects

*******************************
*** GEF Funding Shares 
*** [dropped vs. retained 
*** projects]
*******************************

*** Total population
ttest iwwgef_pct, by(iwwviableproj)

*** 25% quantile
ttest iwwgef_pct, by(iwwviableproj), if iwwproject_year < 2000

*** 25-50% quantile
ttest iwwgef_pct, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest iwwgef_pct, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest iwwgef_pct, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011) 

*******************************
*** GEF Grant Amounts
*** [dropped vs. retained 
*** projects]
*******************************

*** Total population
ttest iwwlngef_grant, by(iwwviableproj)

*** 25% quantile
ttest iwwlngef_grant, by(iwwviableproj), if iwwproject_year < 2000

*** 25-50% quantile
ttest iwwlngef_grant, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest iwwlngef_grant, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest iwwlngef_grant, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011) 

*******************************
*** Project Cost
*** [dropped vs. retained 
*** projects]
*******************************

*** Total poulation
ttest iwwlncoded_sum, by(iwwviableproj)

*** 25% quantile
ttest iwwlncoded_sum, by(iwwviableproj), if iwwproject_year < 2000

*** 25-50% quantile
ttest iwwlncoded_sum, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest iwwlncoded_sum, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest iwwlncoded_sum, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011) 

*******************************
*** log(GDP)
*** [dropped vs. retained 
*** projects]
*******************************

*** Total population
ttest lngdpcon, by(iwwviableproj)

*** 25% quantile
ttest lngdpcon, by(iwwviableproj), if iwwproject_year<2000

*** 25-50% quantile
ttest lngdpcon, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest lngdpcon, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest lngdpcon, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011)

*******************************
*** log(GDPpc)
*** [dropped vs. retained 
*** projects]
*******************************

*** Total population
ttest iwwlncapgdp2000, by(iwwviableproj)

*** 25% quantile
ttest iwwlncapgdp2000, by(iwwviableproj), if iwwproject_year<2000

*** 25-50% quantile
ttest iwwlncapgdp2000, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest iwwlncapgdp2000, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest iwwlncapgdp2000, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011)

*******************************
*** Proportion of WB projects
*** [dropped vs. retained 
*** projects]
*******************************

*** Total population
ttest iwwibrd, by(iwwviableproj)

*** 25% quantile
ttest iwwibrd, by(iwwviableproj), if iwwproject_year < 2000

*** 25-50% quantile
ttest iwwibrd, by(iwwviableproj), if inrange(iwwproject_year, 2000,2004) 

*** 50-75% quantile
ttest iwwibrd, by(iwwviableproj), if inrange(iwwproject_year, 2005,2009) 

*** 75-100% quantile
ttest iwwibrd, by(iwwviableproj), if inrange(iwwproject_year, 2010,2011) 

*******************************
*** Recipient financing [WB vs. non-WB projects]
*******************************

ttest iwwrecipient_pct, by (iwwibrd)

*******************************
*** Foreign financing [WB vs. non-WB projects]
*******************************

ttest iwwforeign_pct, by (iwwibrd)


*******************************
*********** TABLE 3 ***********
******** GDP and GDPpc ********
*** WB vs. Non-WB and Full ****
*** GEF/Tot and Extrnl/Tot ****
*******************************

*** Model (1), WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* (IBRD = 1)
eststo clear
eststo: xi: regress percent_gefn lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, cluster(wdi_name)

*** Model (1), Non-WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* (IBRD = 0)
* eststo clear
eststo: xi: regress percent_gefn lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, cluster(wdi_name)

*** Model (1), all with interaction
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* eststo clear
eststo: xi: regress percent_gefn c.lngdpcon##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(wdi_name)



*** Model (2), WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress percent_gefn iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, cluster(wdi_name)

*** Model (2), Non-WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc 
* (IBRD = 0)
* eststo clear
eststo: xi: regress percent_gefn iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, cluster(wdi_name)

*** Model (2), all with interaction
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc 
* eststo clear
eststo: xi: regress percent_gefn c.iwwlncapgdp2000##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(wdi_name)



**********
*Limit data to our 1,411 projects
drop if iwwsample==0
**********

*** Model (3), WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress percent_gefn lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, cluster(wdi_name)

*** Model (3), Non-WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress percent_gefn lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, cluster(wdi_name)

*** Model (3), all with interaction
* GEF/Total, on IWW dataset and with BMU variables, wealth=GDP 
* eststo clear
eststo: xi: regress percent_gefn c.lngdpcon##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(wdi_name)



*** Model (4), WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress percent_gefn iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, cluster(wdi_name)

*** Model (4), Non-WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress percent_gefn iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, cluster(wdi_name)

*** Model (4), all with interaction
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* eststo clear
eststo: xi: regress percent_gefn c.iwwlncapgdp2000##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(wdi_name)



*** Model (5), WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgef_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (5), Non-WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgef_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (5), all with interaction
* GEF/Total, on IWW dataset and with IWW variables, wealth=GDP 
* eststo clear
eststo: xi: regress iwwgef_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (6), WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgef_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (6), Non-WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgef_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (6), all with interaction
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwgef_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (7), WB
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwallexternal_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (7), Non-WB
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwallexternal_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (7), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwallexternal_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (8), WB
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwallexternal_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (8), Non-WB
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwallexternal_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (8), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwallexternal_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)





*********************************
*********** TABLE 4 *************
******* GDP and GDPpc ***********
**** WB vs. Non-WB and Full *****
*** All Individ Funders / Tot ***
*********************************


*** Model (9), WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgefia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (9), Non-WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgefia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (9), Full
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwgefia_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)




*** Model (10), WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgefia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (10), Non-WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgefia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (10), Full
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwgefia_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (11), WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (11), Non-WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (11), Full
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwia_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (12), WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (12), Non-WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (12), Full
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwia_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (13), WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwforeign_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (13), Non-WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwforeign_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (13), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwforeign_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (14), WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwforeign_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (14), Non-WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwforeign_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (14), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwforeign_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (15), WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwrecipient_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (15), Non-WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwrecipient_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (15), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwrecipient_pct c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (16), WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwrecipient_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (16), Non-WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwrecipient_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (16), Full
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwrecipient_pct c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



**********************************
************ APPENDIX ************
**********************************

**********
*Re-open full dataset 
drop _all
insheet using ReplicationFile20190918.csv
**********

********************************
*********** TABLE A3 ***********
**** Fraction Logit from 3 *****
********************************

net install fracglm, from(https://www3.nd.edu/~rwilliam/stata)

*** Model (A1), WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* (IBRD = 1)
eststo clear
eststo: xi: fracglm percent_gefnfrac lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, vce(cluster wdi_name)

*** Model (A1), Non-WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm percent_gefnfrac lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, vce(cluster wdi_name)

*** Model (A1), all with interaction
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDP 
* eststo clear
eststo: xi: fracglm percent_gefnfrac c.lngdpcon##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster wdi_name)



*** Model (A2), WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm percent_gefnfrac iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, vce(cluster wdi_name)

*** Model (A2), Non-WB
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc 
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm percent_gefnfrac iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, vce(cluster wdi_name)

*** Model (A2), all with interaction
* GEF/Total, on BMU dataset and with BMU variables, wealth=GDPpc 
* eststo clear
eststo: xi: fracglm percent_gefnfrac c.iwwlncapgdp2000##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster wdi_name)



**********
*Limit data to our 1,411 projects
drop if iwwsample==0
**********



*** Model (A3), WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm percent_gefnfrac lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, vce(cluster wdi_name)

*** Model (A3), Non-WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm percent_gefnfrac lngdpcon climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, vce(cluster wdi_name)

*** Model (A3), all with interaction
* GEF/Total, on IWW dataset and with BMU variables, wealth=GDP 
* eststo clear
eststo: xi: fracglm percent_gefnfrac c.lngdpcon##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster wdi_name)



*** Model (A4), WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm percent_gefnfrac iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==1, vce(cluster wdi_name)

*** Model (A4), Non-WB
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm percent_gefnfrac iwwlncapgdp2000 climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if ibrd==0, vce(cluster wdi_name)

*** Model (A4), all with interaction
* GEF/Total, on IWW sample but with BMU variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm percent_gefnfrac c.iwwlncapgdp2000##ibrd climate lnprojecttotal democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster wdi_name)



*** Model (A5), WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwgef_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A5), Non-WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwgef_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A5), all with interaction
* GEF/Total, on IWW dataset and with IWW variables, wealth=GDP 
* eststo clear
eststo: xi: fracglm iwwgef_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A6), WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwgef_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A6), Non-WB
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwgef_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A6), all with interaction
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwgef_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A7), WB
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A7), Non-WB
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A7), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)




*** Model (A8), WB
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A8), Non-WB
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A8), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwallexternal_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



********************************
*********** TABLE A4 ***********
**** Fraction Log-it from 4 ****
********************************


*** Model (A9), WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwgefia_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A9), Non-WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwgefia_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A9), Full
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: fracglm iwwgefia_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)




*** Model (A10), WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwgefia_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A10), Non-WB
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwgefia_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A10), Full
* (GEF+IAs)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwgefia_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)




*** Model (A11), WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwia_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A11), Non-WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwia_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A11), Full
* IAs/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: fracglm iwwia_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A12), WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwia_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A12), Non-WB
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwia_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A12), Full
* IAs/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwia_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A13), WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwforeign_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A13), Non-WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwforeign_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A13), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: fracglm iwwforeign_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A14), WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwforeign_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A14), Non-WB
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwforeign_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A14), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwforeign_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A15), WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A15), Non-WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A15), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



*** Model (A16), WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, vce(cluster iwwrecipient_country)

*** Model (A16), Non-WB
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, vce(cluster iwwrecipient_country)

*** Model (A16), Full
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: fracglm iwwrecipient_pctfrac c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, vce(cluster iwwrecipient_country)



**************************
******** TABLE A6 ********
**** Log Ratio Models ****
**************************

*** Model (A21), WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gef_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A21), Non-WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gef_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A21), Full
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_gef_rec c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A22), WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gef_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A22), Non-WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gef_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A22), Full
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_gef_rec c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A23), WB
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gefia_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A23), Non-WB
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gefia_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A23), Full
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_gefia_rec c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A24), WB
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gefia_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A24), Non-WB
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gefia_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A24), Full
* Log(GEF+IAs/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_gefia_rec c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A25), WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ia_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A25), Non-WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ia_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A25), Full
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_ia_rec c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A26), WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ia_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A26), Non-WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ia_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A26), Full
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_ia_rec c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A27), WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_foreign_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A27), Non-WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_foreign_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A27), Full
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_foreign_rec c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A28), WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_foreign_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A28), Non-WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_foreign_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A28), Full
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_foreign_rec c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A29), WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_allexternal_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A29), Non-WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_allexternal_rec lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A29), Full
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_allexternal_rec c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A30), WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_allexternal_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A30), Non-WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_allexternal_rec iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A30), Full
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_allexternal_rec c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)






**************************
******** TABLE A7 ********
*** A6 with Small Sum ****
**************************


*** Model (A31), WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gef_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A31), Non-WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gef_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A31), Full
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_gef_rec_ss c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A32), WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gef_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A32), Non-WB
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gef_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A32), Full
* Log(GEF/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_gef_rec_ss c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A33), WB
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gefia_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A33), Non-WB
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gefia_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A33), Full
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_gefia_rec_ss c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A34), WB
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_gefia_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A34), Non-WB
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_gefia_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A34), Full
* Log(GEF+IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_gefia_rec_ss c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A35), WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ia_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A35), Non-WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ia_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A35), Full
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_ia_rec_ss c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A36), WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ia_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A36), Non-WB
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ia_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A36), Full
* Log(IA/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_ia_rec_ss c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A37), WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_foreign_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A37), Non-WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_foreign_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A37), Full
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_foreign_rec_ss c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A38), WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_foreign_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A38), Non-WB
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_foreign_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A38), Full
* Log(Foreign/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_foreign_rec_ss c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A39), WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ext_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A39), Non-WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ext_rec_ss lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A39), Full
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwln_ext_rec_ss c.lngdpcon##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A40), WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwln_ext_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A40), Non-WB
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwln_ext_rec_ss iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A40), Full
* Log(External/Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwln_ext_rec_ss c.iwwlncapgdp2000##iwwibrd climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



********************************
********** TABLE A10 ***********
***** Log Recipient as DV ******
********************************




*** Model (A49), WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress ln_iwwrecipient_funding lngdpcon  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A49), Non-WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
eststo: xi: regress ln_iwwrecipient_funding lngdpcon  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A49), Full
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
eststo: xi: regress ln_iwwrecipient_funding c.lngdpcon##iwwibrd  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A50), WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
*eststo clear
eststo: xi: regress ln_iwwrecipient_funding iwwlncapgdp2000  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A50), Non-WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
eststo: xi: regress ln_iwwrecipient_funding iwwlncapgdp2000  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A50), Full
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
eststo: xi: regress ln_iwwrecipient_funding c.iwwlncapgdp2000##iwwibrd  climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A51), WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
*eststo clear
eststo: xi: regress ln_iwwrecipient_funding lngdpcon ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A51), Non-WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
eststo: xi: regress ln_iwwrecipient_funding lngdpcon ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A51), Full
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDP
eststo: xi: regress ln_iwwrecipient_funding c.lngdpcon##iwwibrd ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)


*** Model (A52), WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
*eststo clear
eststo: xi: regress ln_iwwrecipient_funding iwwlncapgdp2000 ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==1, cluster(iwwrecipient_country)

*** Model (A52), Non-WB
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
eststo: xi: regress ln_iwwrecipient_funding iwwlncapgdp2000 ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwibrd==0, cluster(iwwrecipient_country)

*** Model (A52), Full
* Log(Recipient), on IWW sample and with IWW variables, wealth=GDPpc
eststo: xi: regress ln_iwwrecipient_funding c.iwwlncapgdp2000##iwwibrd ln_iwwallexternal_funding climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



********************************
********** TABLE A11 ***********
**** Same as Models 5-16 *******
**** Dev. Banks vs. UN Ag. *****
********************************

*** Model (A53), Dev. Banks
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IWWDevBnk = 1)
eststo clear
eststo: xi: regress iwwgef_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A53), UN Agencies
* GEF/Total, on IWW sample and with IWW variables, wealth=GDP
* (IWWDevBnk = 0)
* eststo clear
eststo: xi: regress iwwgef_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A53), all with interaction
* GEF/Total, on IWW dataset and with IWW variables, wealth=GDP 
* eststo clear
eststo: xi: regress iwwgef_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A54), Dev. Banks
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IWWDevBnk = 1)
eststo clear
eststo: xi: regress iwwgef_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A54), UN Agencies
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IWWDevBnk = 0)
* eststo clear
eststo: xi: regress iwwgef_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A54), all with interaction
* GEF/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwgef_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A55), Dev. Banks
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IWWDevBnk = 1)
eststo clear
eststo: xi: regress iwwallexternal_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A55), UN Agencies
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* (IWWDevBnk = 0)
* eststo clear
eststo: xi: regress iwwallexternal_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A55), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwallexternal_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A56), Dev. Banks
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IWWDevBnk = 1)
eststo clear
eststo: xi: regress iwwallexternal_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A56), UN Agencies
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IWWDevBnk = 0)
* eststo clear
eststo: xi: regress iwwallexternal_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A56), all with interaction
* External/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwallexternal_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A57), Dev. Banks
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgefia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A57), UN Agencies
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgefia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A57), Full
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwgefia_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A58), Dev. Banks
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwgefia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A58), UN Agencies
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwgefia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A58), Full
* (GEF+IA)/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwgefia_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A59), Dev. Banks
* IA/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A59), UN Agencies
* IA/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwia_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A59), Full
* IA/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwia_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)




*** Model (A60), Dev. Banks
* IA/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A60), UN Agencies
* IA/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwia_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A60), Full
* IA/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwia_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)




*** Model (A61), Dev. Banks
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwforeign_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A61), UN Agencies
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwforeign_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A61), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwforeign_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A62), Dev. Banks
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwforeign_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A62), UN Agencies
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwforeign_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A62), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwforeign_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A63), Dev. Banks
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwrecipient_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A63), UN Agencies
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDP
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwrecipient_pct lngdpcon climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A63), Full
* Foreign/Total, on IWW sample and with IWW variables, wealth=GDP
* eststo clear
eststo: xi: regress iwwrecipient_pct c.lngdpcon##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



*** Model (A64), Dev. Banks
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 1)
eststo clear
eststo: xi: regress iwwrecipient_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==1, cluster(iwwrecipient_country)

*** Model (A64), UN Agencies
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* (IBRD = 0)
* eststo clear
eststo: xi: regress iwwrecipient_pct iwwlncapgdp2000 climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year if iwwdevbnk==0, cluster(iwwrecipient_country)

*** Model (A64), Full
* Recipient/Total, on IWW sample and with IWW variables, wealth=GDPpc
* eststo clear
eststo: xi: regress iwwrecipient_pct c.iwwlncapgdp2000##iwwdevbnk climate iwwlncoded_sum democracy corrupt easiap soasia mideana wneurope europeca latamcar namerica i.year, cluster(iwwrecipient_country)



***************************************************************************************************************************************
***************************************************************************************************************************************

drop _all

***************************************************************************************************************************************
***************************************************************************************************************************************

*********************************
**** World Bank Analyses ********
*********************************

**********
*Open WB dataset 
drop _all
insheet using WorldBankData_20190918.csv
destring, replace 
**********

/* Notes on Variables

The data consists of cases that Winters and Streitfeld manually coded and cases 
where the financing data was webscraped from the World Bank Projects Database.

names_std - country

ccodealp - country code

year - World Bank fiscal year in which the project was approved

projectid - World Bank project id

ibrd, ida, blend - 0/1 indicators for World Bank financing source (IBRD, IDA, or both)

approvaldate, closingdate - project dates

borrower - borrowing entity

supplement - 0/1 indicator for supplemental funding

wbpct - the percentage of World Bank financing in the project. For manually-coded cases,
 there were 17 cases where the World Bank percentage was greater than 1 (likely a result
 of a rounding or transcription error).  For these cases, substituting the total project 
 value found in the Projects Database in place of the manually-coded value results in 
 values that are less than 1.  For an additional seven cases -- all webscraped cases, 
 the data in the Projects Database resulted in a wbpct varaible greater than 1.  
 For these cases, the variable is set to missing. Proportions are multiplied by 100 
 to get percentage values like those used in the GEF data.
 
wbpct_frac - as proportion
 
externalpct - the percentage of financing in the project from non-domestic sources 
 (including the World Bank and other foreign donors).  Here there are 34 cases
 where the variable initially takes a value greater than 1.  For 18 cases, replacing
 the denominator with the total project value found in the Projects Database (rather
 than the manually-coded variable) results in a ratio less than 1.  Seven cases -- 
 three from the hand-coded data and four from the webscraped data -- involve a ratio 
 that is between 1 and 1.1 -- these appear to be the result of rounding errors, 
 and we set all of them to 1.  For nine other cases, we set the variable to missing:
 seven are the same as were coded to missing above and another two feature a 
 World Bank number that matches the total amount. Once again, we multiply proportions 
 by 100 to get percentage values like those used in the GEF data.
 
externalpct_frac - as proportion
 
logwbrecipient - log-ratio of World Bank funds to recipient funds

logwbrecipient_ss - log-ratio with $1 added to numerator and denominator

logexternalrecipient - log-ratio of external funds to recipient funds

logexternalrecipient_ss - log-ratio with $1 added to numerator and denominator

totalprojectcost / logtotalprojectcost - the total project cost and the log(total project cost)

region - region indicators

p_polity2 - Polity score for country-year

wbgi_cce - Worldwide Governance Indicators control of corruption score for country-year

log_gdppcppp log_gdpppp - World Development Indicator measures of GDP per capita and GDP (logged)

*/




*******************************
*********** TABLE 5 ***********
********** Main Text **********
*******************************

* Model 17: World Bank Funding / Total Project Cost
eststo clear
eststo: xi: regress wbpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model 18: World Bank Funding / Total Project Cost
eststo: xi: regress wbpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model 19: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model 20: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)


*******************************
***** Replicate TABLE 5 *******
********** IBRD Only **********
*******************************

* Model 17 - IBRD: World Bank Funding / Total Project Cost
eststo clear
eststo: xi: regress wbpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ibrd==1, cluster(names_std)

* Model 18 - IBRD: World Bank Funding / Total Project Cost
eststo: xi: regress wbpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ibrd==1, cluster(names_std)

* Model 19 - IBRD: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ibrd==1, cluster(names_std)

* Model 20 - IBRD: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ibrd==1, cluster(names_std)

*******************************
**** Recplicate TABLE 5 *******
********** IDA Only ***********
*******************************

* Model 17 - IDA: World Bank Funding / Total Project Cost
eststo clear
eststo: xi: regress wbpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ida==1, cluster(names_std)

* Model 18 - IDA: World Bank Funding / Total Project Cost
eststo: xi: regress wbpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ida==1, cluster(names_std)

* Model 19 - IDA: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ida==1, cluster(names_std)

* Model 20 - IDA: External Funding / Total Project Cost
eststo: xi: regress externalpct log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year if ida==1, cluster(names_std)




*******************************
********** TABLE A5 ***********
******* Appendix Sect 3 *******
*******************************

net install fracglm, from(https://www3.nd.edu/~rwilliam/stata)

* Model A17: World Bank Funding / Total Project Cost (Fraction Logit) 
eststo clear
eststo: xi: fracglm wbpct_frac log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, vce(cluster names_std)

* Model A18: World Bank Funding / Total Project Cost (Fraction Logit) 
eststo: xi: fracglm wbpct_frac log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, vce(cluster names_std)

* Model A19: External Funding / Total Project Cost (Fraction Logit)
eststo: xi: fracglm externalpct_frac log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, vce(cluster names_std)

* Model A20: External Funding / Total Project Cost (Fraction Logit)
eststo: xi: fracglm externalpct_frac log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, vce(cluster names_std)



*******************************
********** TABLE A8 ***********
****** Appendix Sect 4.2 ******
*******************************

* Model A41: Log(WB/Recipient)
eststo clear
eststo: xi: regress logwbrecipient log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A42: Log(WB/Recipient)
eststo: xi: regress logwbrecipient log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A43: Log(External/Recipient)
eststo: xi: regress logexternalrecipient log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A44: Log(External/Recipient)
eststo: xi: regress logexternalrecipient log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)



*******************************
********** TABLE A9 ***********
****** Appendix Sect 4.2 ******
*******************************

* Model A45: Log(WB+1/Recipient+1)
eststo clear
eststo: xi: regress logwbrecipient_ss log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A46: Log(WB+1/Recipient+1)
eststo: xi: regress logwbrecipient_ss log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A47: Log(External+1/Recipient+1)
eststo: xi: regress logexternalrecipient_ss log_gdpppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)

* Model A48: Log(External+1/Recipient+1)
eststo: xi: regress logexternalrecipient_ss log_gdppcppp logtotalprojectcost p_polity2 wbgi_cce i.region i.year, cluster(names_std)



***************************************************************************************************************************************
***************************************************************************************************************************************

drop _all

