****************
***Heavy smoking
****************

clear all
global drop all
global data "C:\Users\rmjdshc\OneDrive - University College London\MB\data\"
global outputs "C:\Users\rmjdshc\OneDrive - University College London\MB\outputs\"
log using "${outputs}\02_Heavy_Smoking.log", replace
di c(current_date)

use "${data}\Dataset1.dta", clear
tab1 year if !missing(dvheavysmk)
tab1 imdq5,m

*Age- and IMD-adjusted.
glm dvheavysmk age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
glm dvheavysmk age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)

*1960s as ref (main effect of cohort)
glm dvheavysmk age ib1960.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1960.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog


*cohort by IMD.

glm dvheavysmk age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
est store a
glm dvheavysmk age i.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
*testparm chort10yr#imdq5 
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b

*main effect of IMD.
glm dvheavysmk age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs 
glm dvheavysmk age ib1950.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1960.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1970.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1980.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog

*smoke (women)
glm dvheavysmk age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
est store a
glm dvheavysmk age i.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b
 
glm dvheavysmk age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1950.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1960.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1970.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvheavysmk age ib1980.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

glm dvheavysmk age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5

glm dvheavysmk age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5
log close









