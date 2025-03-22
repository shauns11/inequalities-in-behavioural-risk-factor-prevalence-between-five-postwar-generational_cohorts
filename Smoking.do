**************************
***Smoking
**************************

clear all
global drop all
global data "C:\Users\rmjdshc\OneDrive - University College London\MB\data\"
global outputs "C:\Users\rmjdshc\OneDrive - University College London\MB\outputs\"
log using "${outputs}\01_Smoking.log", replace
di c(current_date)

use "${data}\Dataset.dta", clear
keep if age>=25 & age<=60
tab1 dvcurrsmk imdq5 age

*collapse (mean) dvcurrsmk,by(sex chort10 age)

*age- and IMD-adjusted.
glm dvcurrsmk age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
glm dvcurrsmk age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)

*1960s as ref (main effect of cohort)
glm dvcurrsmk age ib1960.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1960.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

*smoke (men): cohort by IMD.

glm dvcurrsmk age i.chort10 i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
est store a
glm dvcurrsmk age i.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
*testparm chort10yr#imdq5 
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b

*main effect of IMD.
glm dvcurrsmk age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs 
glm dvcurrsmk age ib1950.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1960.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1970.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1980.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog

*smoke (women)
glm dvcurrsmk age i.chort10 i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
est store a
glm dvcurrsmk age i.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
margins chort10yr#imdq5,at(age=40)
est store b
lrtest a b
 
glm dvcurrsmk age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1950.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1960.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1970.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog
glm dvcurrsmk age ib1980.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog

glm dvcurrsmk age ib1940.chort10##i.imdq5 if sex==1, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5

glm dvcurrsmk age ib1940.chort10##i.imdq5 if sex==2, family(binomial) link(log)  eform nolog  // least vs
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5

log close







