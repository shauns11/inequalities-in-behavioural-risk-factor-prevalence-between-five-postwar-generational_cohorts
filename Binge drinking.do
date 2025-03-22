****************
***Binge drinking
****************

clear all
global drop all
global data "C:\Users\rmjdshc\OneDrive - University College London\MB\data\"
global outputs "C:\Users\rmjdshc\OneDrive - University College London\MB\outputs\"
log using "${outputs}\04_Binge_drinking.log", replace
di c(current_date)

use "${data}\Dataset1.dta", clear

*control for IMD.
glm dvbinge2 age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
glm dvbinge2 age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)

*1960s as ref (main effect of cohort)
glm dvbinge2 age ib1960.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1960.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

******************************************************
*cohort by IMD.
******************************************************

glm dvbinge2 age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
est store a
glm dvbinge2 age i.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
*testparm chort10yr#imdq5 
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b

*main effect of IMD.
glm dvbinge2 age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs 
glm dvbinge2 age ib1950.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1960.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1970.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1980.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog

*(women)
glm dvbinge2 age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
est store a
glm dvbinge2 age i.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b
 
glm dvbinge2 age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1950.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1960.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1970.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvbinge2 age ib1980.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

glm dvbinge2 age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5

glm dvbinge2 age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5
log close









