

clear all
global drop all
global data "C:\Users\rmjdshc\OneDrive - University College London\MB\data\"
global outputs "C:\Users\rmjdshc\OneDrive - University College London\MB\outputs\"
log using "${outputs}\03_Alcohol.log", replace
di c(current_date)

use "${data}\SStemp.dta", clear
tab dvalc_5P

********************
*age-by-cohort
********************

*control for IMD.
glm dvalc_5P age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
glm dvalc_5P age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)

*1960s as ref (main effect of cohort)
glm dvalc_5P age ib1960.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1960.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

*Men.

glm dvalc_5P age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
est store a
glm dvalc_5P age i.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b

glm dvalc_5P age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs 
glm dvalc_5P age ib1950.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1960.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1970.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1980.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog

*Women.
glm dvalc_5P age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
est store a
glm dvalc_5P age i.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b
 
glm dvalc_5P age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1950.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1960.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1970.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvalc_5P age ib1980.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

glm dvalc_5P age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5

glm dvalc_5P age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5
log close








