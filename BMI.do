
clear all
global drop all
global data "C:\Users\rmjdshc\OneDrive - University College London\MB\data\"
global outputs "C:\Users\rmjdshc\OneDrive - University College London\MB\outputs\"
log using "${outputs}\06_BMI.log", replace
di c(current_date)

use "${data}\Dataset_continuous vars.dta", clear

gen cons=1
svyset [pw=cons]
svy:mean BMI2,over(sex chort10 age)


*****************
*BMI
*****************

*control for IMD.
regress BMI2 age ib1940.chort10 ib1.imdq5 if sex==1 
margins chort10yr#imdq5,at(age=40)
regress BMI2 age ib1940.chort10 ib1.imdq5 if sex==2
margins chort10yr#imdq5,at(age=40)
 
*1960s as REF: main effect of cohort
regress BMI2 age ib1960.chort10 ib1.imdq5 if sex==1  
regress BMI2 age ib1960.chort10 ib1.imdq5 if sex==2 

*IMD*cohort (IMD5 versus 1)
regress BMI2 age ib1940.chort10##ib1.imdq5 if sex==1
testparm chort10yr#imdq5
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5
margins chort10yr#imdq5,at(age=40)

regress BMI2 age ib1940.chort10##ib1.imdq5 if sex==2
testparm chort10yr#imdq5
test 1950.chort10yr#5.imdq5 1960.chort10yr#5.imdq5 1970.chort10yr#5.imdq5 1980.chort10yr#5.imdq5
margins chort10yr#imdq5,at(age=40)

regress BMI2 age ib1940.chort10##ib1.imdq5 if sex==1
regress BMI2 age ib1950.chort10##ib1.imdq5 if sex==1
regress BMI2 age ib1960.chort10##ib1.imdq5 if sex==1
regress BMI2 age ib1970.chort10##ib1.imdq5 if sex==1
regress BMI2 age ib1980.chort10##ib1.imdq5 if sex==1

regress BMI2 age ib1940.chort10##ib1.imdq5 if sex==2
regress BMI2 age ib1950.chort10##ib1.imdq5 if sex==2
regress BMI2 age ib1960.chort10##ib1.imdq5 if sex==2
regress BMI2 age ib1970.chort10##ib1.imdq5 if sex==2
regress BMI2 age ib1980.chort10##ib1.imdq5 if sex==2
log close












