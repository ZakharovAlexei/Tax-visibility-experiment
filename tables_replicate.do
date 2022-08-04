local path="C:\Users\Алексей\Dropbox\research\tax_visibility\"

*local vlist_controls1="female age married educ_h l_income na_income empl_entr emp_state emp_pens emp_student emp_manager emp_fulltime style_int trust_f covid_vacc pol1_wrong profession_econ tax2_fns property_tax know_econ taxbudg_corr"
local vlist_controls2="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
local vl1="pol1_wrong_0 pol1_na t0_pol1 t0_pol1_na trust_f_0 trust_f_na t0_trust t0_trust_na style_int_0 style_int_na t0_style t0_style_na"
local vlist_controls3="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na"

local vlist_controls2_know="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"

local med_head="\multicolumn{2}{c}{Earn more}&Work-luck&Altruism&Evade taxes&Satisfaction&Gov spending&\multicolumn{2}{c}{President}&\multicolumn{2}{c}{Government}&\multicolumn{2}{c}{Governor}"
local budg_head="\multicolumn{2}{c}{Army}&\multicolumn{2}{c}{Social}&\multicolumn{2}{c}{Health}&\multicolumn{2}{c}{Education}&\multicolumn{2}{c}{Security}&\multicolumn{2}{c}{Utilities}&\multicolumn{2}{c}{Transport}"
local head1="{ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \begin{tabular}{l*{13}{c}} \hline\hline"
local head2="{ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \begin{tabular}{l*{14}{c}} \hline\hline"

local mlist_med="m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13"

local dvlist_gov="tax6_r1_p tax6_r1_f_p tax6_r2_p_rev tax6_r2_f_p_rev tax6_r3_p_rev tax6_r3_f_p_rev budg_av budg_av_f"
local gov_head="\multicolumn{2}{c}{Taxes too high}&\multicolumn{2}{c}{Rus vs Eur (R)}&\multicolumn{2}{c}{Gov spend too high (R)}&\multicolumn{2}{c}{Budget items}"
local head_gov="{ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \begin{tabular}{l*{8}{c}} \hline\hline"

set more off




***********************************************************************************
************************* TABLE WITH PERCEIVED TAX LEVELS *************************
***********************************************************************************

use "`path'final_work.dta", clear

local fname="`path'taxes_table.tex"

file open mf using "`fname'", write replace
file write mf "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write mf "\begin{tabular}{|p{7cm}|ccc|}" _n
file write mf "\hline" _n
file write mf "&Income tax&Social security&Value-added tax\\" _n
file write mf "\hline" _n

file write mf "Actual value&12&30&20\\" _n
tabstat taxndfl2 taxpens21 taxnds2, save
mat V=r(StatTotal)
local v0=string(V[1,1],"%9.1f")
local v1=string(V[1,2],"%9.1f")
local v2=string(V[1,3],"%9.1f")
file write mf "Average value reported&`v0'&`v1'&`v2'\\" _n
tab taxndfl_cat, freq matcell(T1)
mat T1=T1/(T1[1,1]+T1[2,1]+T1[3,1]+T1[4,1])
tab taxpens_cat, freq matcell(T2)
mat T2=T2/(T2[1,1]+T2[2,1]+T2[3,1]+T2[4,1])
tab taxnds_cat, freq matcell(T3)
mat T3=T3/(T3[1,1]+T3[2,1]+T3[3,1]+T3[4,1])
local v0=string(T1[2,1],"%9.3f")
local v1=string(T2[2,1],"%9.3f")
local v2=string(T3[2,1],"%9.3f")
file write mf "Reported: Below actual value&`v0'&`v1'&`v2'\\" _n
local v0=string(T1[3,1],"%9.3f")
local v1=string(T2[3,1],"%9.3f")
local v2=string(T3[3,1],"%9.3f")
file write mf "Reported: At actual value&`v0'&`v1'&`v2'\\" _n
local v0=string(T1[4,1],"%9.3f")
local v1=string(T2[4,1],"%9.3f")
local v2=string(T3[4,1],"%9.3f")
file write mf "Reported: Above actual value&`v0'&`v1'&`v2'\\" _n
local v0=string(T1[1,1],"%9.3f")
local v1=string(T2[1,1],"%9.3f")
local v2=string(T3[1,1],"%9.3f")
file write mf "Reported: Did not know&`v0'&`v1'&`v2'\\" _n

file write mf "\hline" _n
*file write mf "\multicolumn{4}{p{16cm}}{\tiny Something.}" _n
file write mf "\end{tabular}"
file close mf



*********************************************************************************************
****************** BALANCE TEST TABLES, MAIN AND Foll. ***********************************
*********************************************************************************************

.fn=.object.new
.fn.Declare array list
.fn.list[1]="`path'balance_table.tex"
.fn.list[2]="`path'balance_table_foll.tex"

.pf=.object.new
.pf.Declare array list
.pf.list[1]=""
.pf.list[2]="if taxnds1_f!=."

forval i=1/2 {

local fname="`.fn.list[`i']'"
local pref="`.pf.list[`i']'"



file open mf using "`fname'", write replace
file write mf "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write mf "\begin{tabular}{|p{7cm}|cc|lcc|}" _n
file write mf "\hline" _n
file write mf "\multicolumn{6}{|c|}{{\bf Tax knowledge}}\\" _n
*file write mf "\hline" _n
file write mf "&Control&Treatment&Test&\$p\$&\$N\$\\" _n
file write mf "\hline" _n


ttest taxndfl2 `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Income tax: Percentage&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n
ranksum taxndfl2 `pref', by(t0choice)
local p=string(2 * normprob(-abs(r(z))),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "&&&Ranksum&`p'&`N' \\" _n

cc t0choice taxndfl_13 `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat taxndfl_13 `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Income tax: 13\%&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest taxnds2 `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Value-added tax: Percentage&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n
ranksum taxnds2 `pref', by(t0choice)
local p=string(2 * normprob(-abs(r(z))),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "&&&Ranksum&`p'&`N' \\" _n

cc t0choice taxnds_20 `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat taxnds_20 `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Value added tax: 20\%&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest taxpens21 `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Social security: Percentage&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n
ranksum taxpens21 `pref', by(t0choice)
local p=string(2 * normprob(-abs(r(z))),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "&&&Ranksum&`p'&`N' \\" _n

cc t0choice taxpens_30 `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat taxpens_30 `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Social security: 30\%&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n
file write mf "\hline" _n

file write mf "\multicolumn{6}{|c|}{{\bf Other covariates}}\\" _n
*file write mf "\hline" _n
file write mf "&Control&Treatment&Test&\$p\$&\$N\$\\" _n
file write mf "\hline" _n


cc t0choice female `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat female `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Female&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest age `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Age&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n
ranksum age `pref', by(t0choice)
local p=string(2 * normprob(-abs(r(z))),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "&&&Ranksum&`p'&`N' \\" _n

cc t0choice educ_h `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat educ_h `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Higher education&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest l_income `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Log personal income&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n
ranksum l_income `pref', by(t0choice)
local p=string(2 * normprob(-abs(r(z))),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "&&&Ranksum&`p'&`N' \\" _n

cc t0choice l_income_na `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat l_income_na `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Personal income: NA&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl_entr `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl_entr `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Work: Self-employed/entrepreneur&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl_fulltime `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl_fulltime `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Work: Full-time&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_married `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_married `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Married&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_retiree `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_retiree `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Retired&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_student `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_student `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Student&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_manager `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_manager `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Manager/executive&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_covid `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_covid `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Covid&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl2_econ `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl2_econ `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Status: Econ/finance&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice empl3_state `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat empl3_state `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Employer: State&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest style_int `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Intuitive style&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n

ttest trust_f `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Trust experts&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n

cc t0choice pol1_wrong `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat pol1_wrong `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Things going: Wrong way&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice tax2_fns `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat tax2_fns `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Visited tax authority past year&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

cc t0choice proptax `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat proptax `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Paid property tax past year&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

ttest know_econ `pref', by(t0choice)
local v00=string(r(mu_1),"%9.1f")
local v10=string(r(mu_2),"%9.1f")
local p=string(r(p),"%9.4f")
local N=string(r(N_1)+r(N_2),"%9.0f")
file write mf "Econ knowledge&`v00'&`v10'&Two-tailed t&`p'&`N' \\" _n

cc t0choice budg_corr `pref', exact 
local p=string(r(p_exact),"%9.4f")
tabstat budg_corr `pref', by(t0choice) save stats(mean n)
mat v0=r(Stat1)
mat v1=r(Stat2)
local v00=string(v0[1,1],"%9.4f")
local v10=string(v1[1,1],"%9.4f")
local N=string(v0[2,1]+v1[2,1],"%9.0f")
file write mf "Budget revenue: Taxes&`v00'&`v10'&Fisher's exact&`p'&`N' \\" _n

file write mf "\hline" _n
file write mf "\multicolumn{5}{p{16cm}}{\tiny The table reports test statistics comparing treatment and control groups of subjects.}" _n
file write mf "\end{tabular}"
file close mf

}
***********************************************************************************
******************* F-TESTS WITH BALANCE TEST VARIABLES AS CONTROLS ***************
***********************************************************************************

reg t0choice `vlist_controls2' taxndfl_0 taxndfl_na taxndfl_13 taxpens_0 taxpens_na taxpens_30 taxnds_0 taxnds_na taxnds_20
reg t0choice `vlist_controls2' taxndfl_0 taxndfl_na taxndfl_13 taxpens_0 taxpens_na taxpens_30 taxnds_0 taxnds_na taxnds_20 if taxnds1_f!=.


*********************************************************************************************
**************** TREATMENT EFFECT ON TAX BELIEFS IN FOLLOWUP ********************************
*********************************************************************************************

estimates clear
local note="\tiny OLS regressions. Dependent variable is follow-up estimate of social insurance deduction rate for models 1 and 2, and follow-up estimate of VAT for models 3 and 4. {\it 1st estimate} is the estimate of the correspondent tax given in the main survey."
local fname="`path'table_fcomp.tex"
drop temp1 temp2
drop temp3

gen temp1=taxpens21_gap
gen temp3=temp1
lab var temp1 "Bias"
gen temp2=taxpens21_gap*t0choice
lab var temp2 "Bias\$\times \$ T"
reg taxpens21_update temp1 temp2 t0choice `vlist_controls2'
eststo m1
estadd local cont "YES", replace

reg taxpens21_update temp1 temp2 t0choice `vlist_controls2' if temp3<=0
eststo m2
estadd local cont "YES", replace

reg taxpens21_update temp1 temp2 t0choice `vlist_controls2' if temp3>=0
eststo m3
estadd local cont "YES", replace

replace temp1=taxnds2_gap
replace temp2=taxnds2_gap*t0choice
reg taxnds2_update temp1 temp2 t0choice `vlist_controls2'
eststo m4
estadd local cont "YES", replace

reg taxpens21_update temp1 temp2 t0choice `vlist_controls2' if temp3<=0
eststo m5
estadd local cont "YES", replace

reg taxpens21_update temp1 temp2 t0choice `vlist_controls2' if temp3>=0
eststo m6
estadd local cont "YES", replace

esttab m1 m2 m3 m4 m5 m6 using "`fname'", keep(temp1 temp2 t0choice) mtitles("Social: All" "Social: Bias\$\leq0\$" "Social: Bias \$\geq0\$" "VAT: All" "VAT: Bias\$\leq0\$" "VAT: Bias\$\geq0\$") label compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2 cont, label("N" "R2" "Controls")) replace note(`note')


********************************************************************************************************************************
******************** CORRELATES OF TAX KNOWLEDGE ********************************************************
********************************************************************************************************************************

estimates clear
local fname="`path'know_table.tex"
local dvlist1="n_dnk n_low n_corr n_high budg_corr_0 know_econ"
forval i=1/6 {
	local dvar: word `i' of `dvlist1'
	reg `dvar' `vlist_controls2_know'
	eststo m`i'
}

local note="OLS regressions. In Columns 1-4 the dependent variable is the number (between 0 and 3) of taxes for which the individual did not provide a percentage (Column 1), provided a lower than actual value (Column 2), gave correct value (Column 3), and gave a value that was higher than actual (Column 4). In Column 5 the dependent variable (0 or 1) is whether the individual believes the state budget is funded primarily due to taxes. In Column 4 the dependent variable is the self-assessed economic knowledge."

esttab m1 m2 m3 m4 m5 m6 using "`fname'", label drop(*_na) mtitles("Tax: DNK" "Tax: Down" "Tax: Corr" "Tax: Up" "Budg rev" "Know econ") compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace note("`note'")

********************************************************************************************************************************
******************** TAX BELIEFS AND GOV SPENDING: TREATMENT EFFECTS ***********************************************************
********************************************************************************************************************************

global vlist="`vlist_controls2'"
cd "`path'"

global fname="`path'table_treat_new1.tex"
global title="`gov_head'"
global title2="Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll."
global depvlist1="`dvlist_gov'"
local note="OLS regressions. In Columns 1-6, the dependent variables are agreements (on a 0-1 scale) with the statements that ``You and your family members are paying too much taxes'', ``In Russia the tax burden is lower than in most European countries'', and ``Russian government spending is too high'', respectively (the scale is reversed for Columns 2 and 3). In Columns 7-8 the dependent variable is the average of opinion on 7 budget needs (1-Too little funding, 0.5 - The right amount, 0 - Too much funding). Panel A the independent variable is the tax information treatment. In Panel B the independent variable is the tax information treatment, interacted with a categorical variable indicating whether the individual's belief was correct, biased upward/downward, or no answer was provided; marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors in parenthesis. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"

do "`path'gen_table_31.do"


********************************************************************************************************************************
******************** REDISTRIBUTION PREFERENCES: TREATMENT EFFECTS *************************************************************
********************************************************************************************************************************

global fname="`path'table_treat_new2.tex"
global title="\multicolumn{2}{c}{Unemployed}&\multicolumn{2}{c}{Residence}&\multicolumn{2}{c}{Poor}&\multicolumn{2}{c}{Min wage}&\multicolumn{2}{c}{Food stamps}&\multicolumn{2}{c}{Inc differences}&\multicolumn{2}{c}{Prog tax}&\multicolumn{2}{c}{Tax rich}"
global title2="Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll."
local dvlist1="redist1_r1_p redist1_r1_f_p redist1_r2_p redist1_r2_f_p redist1_r3_p redist1_r3_f_p redist2_p redist2_f_p redist3_p redist3_f_p tax6_r5_p tax6_r5_f_p tax6_r6_p tax6_r6_f_p tax6_r7_p tax6_r7_f_p"
global depvlist1="`dvlist1'"

local note="OLS regressions. In Columns 1-6 the dependent variables are agreements (on a 0-1 scale) with the statement that the government should provide a decent standard of living for the unemployed/ Provide housing to all everyone who needs it/ Provide income assistance to the poor. In Columns 7-8 and 9-10, the dependent variable is (on a 0-1 scale) the support for increasing the minimum wage and the food stamps program (see Appendix A for precise definitions). In Columns 11-16 the dependent variables are agreements (on a 0-1 scale) with the statements that <<Income differences in Russia are too high>> and support for progressive taxation. In Panel A the independent variable is the tax information treatment. In Panel B the independent variable is the tax information treatment, interacted with a categorical variable indicating whether the individual's belief was correct, biased upward/downward, or no answer was provided; marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors in parenthesis. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"

do "`path'gen_table_31.do"



********************************************************************************************************************************
******************** SPECIFIC BUDGET ITEMS: TREATMENT EFFECTS ******************************************************************
********************************************************************************************************************************

global fname="`path'table_treat_new_budg.tex"
global title="`budg_head'"
global title2="Main&Foll.&Main&Foll&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll."
local dvlist1="budget1_r1_p budget1_r1_f_p budget1_r2_p budget1_r2_f_p budget1_r3_p budget1_r3_f_p budget1_r4_p budget1_r4_f_p budget1_r5_p budget1_r5_f_p budget1_r6_p budget1_r6_f_p budget1_r7_p budget1_r7_f_p"
global depvlist1="`dvlist1'"

local note="OLS regressions. The dependent variable is the belief about the amount of spending on a budget item (1-Too little funding, 0.5 - The right amount, 0 - Too much funding). In Panel A the independent variable is the tax information treatment. In Panel B the independent variable is the tax information treatment, interacted with a categorical variable indicating whether the individual's belief was correct, biased upward/downward, or no answer was provided; marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors in parenthesis. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"
do "`path'gen_table_31.do"

********************************************************************************************************************************
******************** TAX BELIEFS AND GOV SPENDING: FULL CONTROLS ***************************************************************
********************************************************************************************************************************

estimates clear
local fname="`path'covar_table_gov.tex"
forval i=1/8 {
	local dvar: word `i' of `dvlist_gov'
	quietly reg `dvar' t0choice `vlist_controls2' n_low n_corr n_high
	eststo m`i'
}
local note="\tiny OLS regressions. In Columns 1-6, the dependent variables are agreements (on a 0-1 scale) with the statements that <<You and your family members are paying too much taxes>>, <<In Russia the tax burden is lower than in most European countries>>, and <<Russian government spending is too high>>, respectively (the scale is reversed for Columns 2 and 3). In Columns 7-8 the dependent variable is the average of opinion on 7 budget needs (1-Too little funding, 0.5 - The right amount, 0 - Too much funding). Standard errors in parenthesis."
esttab m1 m2 m3 m4 m5 m6 m7 m8 using "`fname'", label drop(*_na) mtitles(Main Foll Main Foll Main Foll Main Foll) compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace prehead("`head_gov' &`gov_head' \\") note("`note'")


********************************************************************************************************************************
******************** REDISTRIBUTION PREFERENCES: FULL CONTROLS *****************************************************************
********************************************************************************************************************************

estimates clear
local fname="`path'covar_table.tex"
local dvlist1="redist1_r1_p redist1_r2_p redist1_r3_p redist2_p redist3_p tax6_r5_p tax6_r6_p tax6_r7_p"
forval i=1/8 {
	local dvar: word `i' of `dvlist1'
	quietly reg `dvar' t0choice `vlist_controls2' n_low n_corr n_high
	eststo m`i'
}

local note="\tiny OLS regressions. In Columns 1-3 the dependent variables are agreements (on a 0-1 scale) with the statement that the government should provide a decent standard of living for the unemployed/ Provide housing to all everyone who needs it/ Provide income assistance to the poor. In Columns 4 and 5, the dependent variable is (on a 0-1 scale) the support for increasing the minimum wage and the food stamps program (see Appendix A for precise definitions). In Columns 6-8 the dependent variables are agreements (on a 0-1 scale) with the statements that <<Income differences in Russia are too high>> and support for progressive taxation. Standard errors are in parentheses."

esttab m1 m2 m3 m4 m5 m6 m7 m8 using "`fname'", label drop(*_na) mtitles("Unemployed" "Residence" "Poor" "Min wage" "Food stamps" "Inc differences" "Prog tax" "Tax rich") compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace note("`note'")

estimates clear
local fname="`path'covar_table_foll.tex"
local dvlist1="redist1_r1_f_p redist1_r2_f_p redist1_r3_f_p redist2_f_p redist3_f_p tax6_r5_f_p tax6_r6_f_p tax6_r7_f_p"
forval i=1/8 {
	local dvar: word `i' of `dvlist1'
	quietly reg `dvar' t0choice `vlist_controls2' n_low n_corr n_high
	eststo m`i'
}

esttab m1 m2 m3 m4 m5 m6 m7 m8 using "`fname'", label drop(*_na) mtitles("Unemployed" "Residence" "Poor" "Min wage" "Food stamps" "Inc differences" "Prog tax" "Tax rich") compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace  note("`note'")




********************************************************************************************************************************
******************** SPECIFIC BUDGET ITEMS: FULL CONTROLS **********************************************************************
********************************************************************************************************************************

estimates clear
local fname="`path'covar_table_budg.tex"
local dvlist1="budget1_r1_p budget1_r1_f_p budget1_r2_p budget1_r2_f_p budget1_r3_p budget1_r3_f_p budget1_r4_p budget1_r4_f_p budget1_r5_p budget1_r5_f_p budget1_r6_p budget1_r6_f_p budget1_r7_p budget1_r7_f_p"
forval i=1/14 {
	local dvar: word `i' of `dvlist1'
	quietly reg `dvar' t0choice `vlist_controls2' n_low n_corr n_high
	eststo m`i'
}
local note="\tiny OLS regressions. The dependent variable is the belief about the amount of spending on a budget item (1-Too little funding, 0.5 - The right amount, 0 - Too much funding). Standard errors are in parentheses."
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 using "`fname'", label drop(*_na) mtitles(Main Foll Main Foll Main Foll Main Foll Main Foll Main Foll Main Foll) compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace prehead("`head2' &`budg_head' \\") note("`n



********************************************************************************************************************************
******************** TAX BELIEFS AND GOV SPENDING: HETEROGENEITY ***************************************************************
********************************************************************************************************************************

gen pol1_cat=pol1
replace pol1_cat=3 if pol1==99
gen trust_cat=2-(trust_f>0)
replace trust_cat=3 if trust_f==.
gen style_int_cat=2-(style_int>0)
replace style_int_cat=3 if style_int==.

local vlist_controls3="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na"
global vlist="`vlist_controls3'"

global fname="`path'table_hetero_new1.tex"
global title="`gov_head'"
global title2="Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll."
global depvlist1="`dvlist_gov'"

local note="\tiny OLS regressions. In Columns 1-6, the dependent variables are agreements (on a 0-1 scale) with the statements that ``You and your family members are paying too much taxes'', ``In Russia the tax burden is lower than in most European countries'', and ``Russian government spending is too high'', respectively (the scale is reversed for Columns 2 and 3). In Columns 7-8 the dependent variable is the average of opinion on 7 budget needs (1-Too little funding, 0.5 - The right amount, 0 - Too much funding). The independent variable is the tax information treatment, interacted with the following categorical variables: Whether things in the counry are going in right direction/wrong direction/difficult to answer; whether the individual's index of trust toward experts is above mean/below mean/no data; and whether the individual's index of cognitive style is above mean/below mean/no data. Interaction of treatment with prior beliefs on social insurance tax is also included. Marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors are in parentheses. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"

do "`path'gen_table_5.do"






********************************************************************************************************************************
******************** REDISTRIBUTION PREFERENCES: HETEROGENEITY *****************************************************************
********************************************************************************************************************************

global fname="`path'table_hetero_new2.tex"
global title="\multicolumn{2}{c}{Unemployed}&\multicolumn{2}{c}{Residence}&\multicolumn{2}{c}{Poor}&\multicolumn{2}{c}{Min wage}&\multicolumn{2}{c}{Food stamps}&\multicolumn{2}{c}{Inc differences}&\multicolumn{2}{c}{Prog tax}&\multicolumn{2}{c}{Tax rich}"
global title2="Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll.&Main&Foll."
local dvlist1="redist1_r1_p redist1_r1_f_p redist1_r2_p redist1_r2_f_p redist1_r3_p redist1_r3_f_p redist2_p redist2_f_p redist3_p redist3_f_p tax6_r5_p tax6_r5_f_p tax6_r6_p tax6_r6_f_p tax6_r7_p tax6_r7_f_p"
global depvlist1="`dvlist1'"


local note="\tiny OLS regressions. In Columns 1-6 the dependent variables are agreements (on a 0-1 scale) with the statement that the government should provide a decent standard of living for the unemployed/ Provide housing to all everyone who needs it/ Provide income assistance to the poor. In Columns 7-8 and 9-10, the dependent variable is (on a 0-1 scale) the support for increasing the minimum wage and the food stamps program (see Appendix A for precise definitions). In Columns 11-16 the dependent variables are agreements (on a 0-1 scale) with the statements that <<Income differences in Russia are too high>> and support for progressive taxation. The independent variable is the tax information treatment, interacted with the following categorical variables: Whether things in the country are going in right direction/wrong direction/difficult to answer; whether the individual's index of trust toward experts is above mean/below mean/no data; and whether the individual's index of cognitive style is above mean/below mean/no data. Interaction of treatment with prior beliefs on social insurance tax is also included. Marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors are in parentheses. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"


do "`path'gen_table_5.do"


********************************************************************************************************************************
******************** MEDIATORS: TREATMENT EFFECTS ******************************************************************************
********************************************************************************************************************************

global fname="`path'table_treat_new4.tex"
global title="`med_head'"
global title2="Main&Foll.&Main&Main&Main&Main&Main&Main&Foll&Main&Foll.&Main&Foll."

local dvlist1="tax6_r4_p tax6_r4_f_p att1 l_char tax1 sat_av pol3_wrong pol2_r1_p pol2_r1_f_p pol2_r2_p pol2_r2_f_p pol2_r3_p pol2_r3_f_p"
global depvlist1="`dvlist1'"

local note="OLS regressions. DV in Columns 1-2: <<I make more money than the majority of Russians>> (agreement on 0-1 scale). Column 3: Agreement (on a 0-1 scale) with the work/luck question (higher values correspond to more role ascribed to luck). Column 4: Log(donation to charity + 0.5). Column 5: 1 - <<Sometimes it is acceptable not to pay taxes>>, 0 - <<Taxes are mandatory>>. Column 6: Average satisfaction (on 0-1 scale) with state services. Column 7: 1 - <<Money from the state budget is spend generally in the right way>>. Columns 8-13: <<How much do you trust: President of Russia/Government of Russia/Governor (or head) of your region>> (0-1 scale). In Panel A the independent variable is the tax information treatment. In Panel B the independent variable is the tax information treatment, interacted with a categorical variable indicating whether the individual's belief was correct, biased upward/downward, or no answer was provided; marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors in parenthesis. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"

do "`path'gen_table_31.do"


********************************************************************************************************************************
********************** MEDIATORS: FULL CONTROLS ********************************************************************************
********************************************************************************************************************************

estimates clear
local fname="`path'covar_table_med.tex"
local dvlist_med="tax6_r4_p tax6_r4_f_p att1 l_char tax1 sat_av pol3_wrong pol2_r1_p pol2_r1_f_p pol2_r2_p pol2_r2_f_p pol2_r3_p pol2_r3_f_p"
forval i=1/13 {
	local dvar: word `i' of `dvlist_med'
	quietly reg `dvar' t0choice `vlist_controls2' n_low n_corr n_high
	eststo m`i'
}
local note="\tiny OLS regressions. DVs are as in Table \ref{table_compare_h4}. Standard errors in parentheses."
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 using "`fname'", label drop(*_na) mtitles(Main Foll Main Main Main Main Main Foll Main Foll Main Foll) compress nogap se star(* 0.10 ** 0.05 *** 0.01) nonum s(N r2, label("N" "R2")) replace prehead("`head1' &`med_head' \\") note("`note'")

********************************************************************************************************************************
********************** MEDIATORS: HETEROGENEITY ********************************************************************************
********************************************************************************************************************************

global fname="`path'table_hetero_new4.tex"
global title="\multicolumn{2}{c}{Earn more}&Work-luck&Altruism&Evade taxes&Satisfaction&Gov spending&\multicolumn{2}{c}{President}&\multicolumn{2}{c}{Government}&\multicolumn{2}{c}{Governor}"
global title2="Main&Foll.&Main&Main&Main&Main&Main&Main&Foll&Main&Foll.&Main&Foll."
local dvlist1="tax6_r4_p tax6_r4_f_p att1 l_char tax1 sat_av pol3_wrong pol2_r1_p pol2_r1_f_p pol2_r2_p pol2_r2_f_p pol2_r3_p pol2_r3_f_p"
global depvlist1="`dvlist1'"


local note="OLS regressions. DV in Columns 1-2: <<I make more money than the majority of Russians>> (agreement on 0-1 scale). Column 3: Agreement (on a 0-1 scale) with the work/luck question (higher values correspond to more role ascribed to luck). Column 4: Log(donation to charity + 0.5). Column 5: 1 - <<Sometimes it is acceptable not to pay taxes>>, 0 - <<Taxes are mandatory>>. Column 6: Average satisfaction (on 0-1 scale) with state services. Column 7: 1 - <<Money from the state budget is spend generally in the right way>>. Columns 8-13: <<How much do you trust: President of Russia/Government of Russia/Governor (or head) of your region>> (0-1 scale). The independent variable is the tax information treatment, interacted with the following categorical variables: Whether things in the country are going in right direction/wrong direction/difficult to answer; whether the individual's index of trust toward experts is above mean/below mean/no data; and whether the individual's index of cognitive style is above mean/below mean/no data. Interaction of treatment with prior beliefs on social insurance tax is also included. Marginal effects are reported for each case. All regressions include controls as in the lower part of Table 2, with dummies for missing data. Standard errors are in parentheses. * \$ p < 0.1 \$, ** \$ p < 0.05 \$, *** \$ p < 0.01 \$"
global note1="`note'"

do "`path'gen_table_5.do"



********************************************************************************************************************************
************************* MEDIATION ANALYSIS ***********************************************************************************
********************************************************************************************************************************

local fname="`path'medeff_tab.tex"
local vlist_controls2="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
drop _merge

lab var pol2_r1_p "Trust President (main)"
lab var pol2_r1_f_p "Trust President (foll)"
lab var tax6_r3_p_rev "Gov spend too high (main, R)"
lab var sat_av "Satisf. with gov. services"
lab var tax6_r3_f_p_rev "Gov spend too high (foll., R)"
lab var pol2_r3_f_p "Trust Governor (foll)"
lab var redist2_f_p "Min wage (foll)"


.clist=.object.new
.clist.Declare array list
.clist.list[1]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na"
.clist.list[2]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na"
.clist.list[3]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na"
.clist.list[4]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
.clist.list[5]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
.clist.list[6]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na style_int_0 style_int_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
.clist.list[7]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
.clist.list[8]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"
.clist.list[9]="female age l_income_0 l_income_na educ_h_0 educ_h_na empl_fulltime_0 empl_entr_0 empl_na empl2_covid_0 empl2_econ_0 empl2_married_0 empl2_student_0 empl2_manager_0 empl2_retiree_0 empl2_na empl3_state_0 empl3_na trust_f_0 trust_f_na know_econ_0 know_econ_na budg_corr_0 budg_na tax2_fns_0 tax2_na proptax_0 proptax_na pol1_wrong_0 pol1_na"

.o1=.object.new
.o1.Declare array list
.o1.list[1]="pol1==99"
.o1.list[2]="pol1==1"
.o1.list[3]="pol1==2"
.o1.list[4]="trust_f_na==1"
.o1.list[5]="trust_f_na==0&trust_f<0"
.o1.list[6]="trust_f_na==0&trust_f>0"
.o1.list[7]="style_int_na==1"
.o1.list[8]="style_int_na==0&style_int<0"
.o1.list[9]="style_int_na==0&style_int>0"

.o2=.object.new
.o2.Declare array list
.o2.list[1]="Country going: NA"
.o2.list[2]="Country going: Right way"
.o2.list[3]="Country going: Wrong way"
.o2.list[4]="Trust experts: NA"
.o2.list[5]="Trust experts: Below mean"
.o2.list[6]="Trust experts: Above mean"
.o2.list[7]="Intuitive style: NA"
.o2.list[8]="Intuitive style: Below mean"
.o2.list[9]="Intuitive style: Above mean"

local dvlist_med="tax6_r4_p tax6_r4_f_p att1 l_char tax1 sat_av pol3_wrong pol2_r1_p pol2_r1_f_p pol2_r2_p pol2_r2_f_p pol2_r3_p pol2_r3_f_p"
local dvlist1="redist1_r1_p redist1_r1_f_p redist1_r2_p redist1_r2_f_p redist1_r3_p redist1_r3_f_p redist2_p redist2_f_p redist3_p redist3_f_p tax6_r5_p tax6_r5_f_p tax6_r6_p tax6_r6_f_p tax6_r7_p tax6_r7_f_p tax6_r3_p_rev tax6_r3_f_p_rev budg_av budg_av_f"
set more off


file open mf using "`fname'", write replace
file write mf "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write mf "\begin{tabular}{|lllccccc|}" _n
file write mf "\hline" _n
file write mf "Condition&Outcome&Mediator&ACME&Total Effect&\% TE mediated&ACME level&\$\rho\$ \\" _n
file write mf "&&&(90\% CI)&(90\% CI)&(90\% CI)&& \\" _n
file write mf "\hline" _n


forval ii=1/9 {
	local vlist="`.clist.list[`ii']'"
	local cond="`.o1.list[`ii']'"
	local condstr="`.o2.list[`ii']'"
	estimates clear
	
	local medlist=""
	forval i=1/13 {
		local dvar: word `i' of `dvlist_med'
		quietly reg `dvar' t0choice `vlist' n_low n_corr n_high if `cond'
		quietly eststo m`i'
		mat B=e(b)
		mat V=e(V)
		local pp=2*ttail(e(df_r),abs(B[1,1]/sqrt(V[1,1])))
		if `pp'<.1 {
			*di "`dvar'  " `pp'
			local medlist="`medlist' "+"`dvar'"
		}
		
	}
	
	local depvlist=""
	estimates clear
	forval i=1/20 {
		local dvar: word `i' of `dvlist1'
		quietly reg `dvar' t0choice `vlist' n_low n_corr n_high if `cond'
		quietly eststo m`i'
		mat B=e(b)
		mat V=e(V)
		local pp=2*ttail(e(df_r),abs(B[1,1]/sqrt(V[1,1])))
		if `pp'<.1 {
			*di "`dvar'  " `pp'
			local depvlist="`depvlist' "+"`dvar'"
		}
		
	}
	
	if "`depvlist'"!=""&"`medlist'"!="" {
		local n1: word count of `depvlist'
		local n1=`n1'-1
		local n2: word count of `medlist'
		local n2=`n2'-1
		forval i1=1/`n1' {
			local ddv: word `i1' of `depvlist'
			forval i2=1/`n2' {
				local mmv: word `i2' of `medlist'
				quietly reg `ddv' t0choice `vlist' n_low n_corr n_high if `cond'&`mmv'!=.
				local varl=""
				mat B=e(b)
				local vv: colnames e(b)
				local dd=`=colsof(B)'-1
				forval i=2/`dd' {
					if B[1,`i']!=0 {
						local vvv: word `i' of `vv'
						local varl="`varl' "+"`vvv'"
					}
				}
				quietly medeff (regress `mmv' t0choice `varl') (regress `ddv' `mmv' t0choice `varl') if `cond', mediate(`mmv') treat(t0choice) sims(200) l(90)
				if sign(r(delta1hi))==sign(r(delta1lo)) {
					di "`condstr' `ddv' `mmv'"
					local lab1: variable label `ddv'
					local lab2: variable label `mmv'
					local line1="`condstr'&`lab1'&`lab2'&"+string(r(delta1),"%6.4f")+"&"+string(r(tau),"%6.4f")+"&"+string(r(navg),"%6.4f")+"&"
					*di "CONDITION: `cond'"
					*di "`mmv' is a mediator for `ddv' "
					*di "ACME  " %6.4f `r(delta1)' " (" %6.4f r(delta1lo) "  " %6.4f r(delta1hi) ")"
					
					local line2="&&&("+string(r(delta1lo),"%6.4f")+","+string(r(delta1hi),"%6.4f")+")&("+string(r(taulo),"%6.4f")+","+string(r(tauhi),"%6.4f")+")&("+string(r(navglo),"%6.4f")+","+string(r(navghi),"%6.4f")+")&&\\"
					*di "Total effect  " %6.4f `r(tau)' " (" %6.4f r(taulo) "  " %6.4f r(tauhi) ")"
					*di "% of Tot Eff mediated   " %6.4f `r(navg)' " (" %6.4f r(navglo) "  " %6.4f r(navghi) ")"
					quietly medsens (regress `mmv' t0choice `varl') (regress `ddv' `mmv' t0choice `varl') if `cond', mediate(`mmv') treat(t0choice) 
					local rr=string(r(errcr),"%6.4f")
					*di "Rho at which ACME = 0: " %6.4f `r(errcr)'
					quietly medeff (regress `mmv' t0choice `varl') (regress `ddv' `mmv' t0choice `varl') if `cond', mediate(`mmv') treat(t0choice) sims(200) l(95)
					if sign(r(delta1hi))==sign(r(delta1lo)) {
						quietly medeff (regress `mmv' t0choice `varl') (regress `ddv' `mmv' t0choice `varl') if `cond', mediate(`mmv') treat(t0choice) sims(200) l(99)
						if sign(r(delta1hi))==sign(r(delta1lo)) {		
							local line1="`line1'"+".99&"
						}
						else {
							local line1="`line1'"+".95&"
						}
					}
					else {
						local line1="`line1'"+".9&"
					}
					local line1="`line1'`rr' \\"
					file write mf "`line1'" _n
					file write mf  "`line2'" _n
			
				}
			}
		}
	}
}
file write mf "\hline" _n
file write mf "\end{tabular}"
file close mf



