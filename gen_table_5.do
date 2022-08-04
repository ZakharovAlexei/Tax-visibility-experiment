
local fname="$fname"
local depvlist1="$depvlist1"
local title="$title"
local title2="$title2"
local vlist="$vlist"
local note="$note1"

local n: word count of `depvlist1'
local n=`n'-1

estimates clear
mat MM=J(9,`n',.)
mat PP=J(9,`n',.)
mat SE=J(9,`n',.)
mat NN=J(1,`n',.)
mat RR=J(1,`n',.)
forval i=1/`n' {
	local depv: word `i' of `depvlist1'
	quietly reg `depv' i.t0choice##i.pol1_cat i.t0choice##i.trust_cat i.t0choice##i.style_int_cat i.t0choice##i.taxpens_cat `vlist'
	mat RR[1,`i']=e(r2)
	quietly margins, dydx(i.t0choice) at(pol1_cat=(1 2 3))
	mat M=r(b)
	mat V=r(V)
	mat NN[1,`i']=r(N)	
	mat MM[1,`i']=M[1,4]
	mat MM[2,`i']=M[1,5]
	mat MM[3,`i']=M[1,6]
	mat PP[1,`i']=2*ttail(r(df_r),abs(M[1,4])/sqrt(V[4,4]))
	mat PP[2,`i']=2*ttail(r(df_r),abs(M[1,5])/sqrt(V[5,5]))
 	mat PP[3,`i']=2*ttail(r(df_r),abs(M[1,6])/sqrt(V[6,6]))
	mat SE[1,`i']=sqrt(V[4,4])
	mat SE[2,`i']=sqrt(V[5,5])
 	mat SE[3,`i']=sqrt(V[6,6])
	quietly margins, dydx(i.t0choice) at(trust_cat=(1 2 3))
	mat M=r(b)
	mat V=r(V)
	mat MM[4,`i']=M[1,4]
	mat MM[5,`i']=M[1,5]
	mat MM[6,`i']=M[1,6]
	mat PP[4,`i']=2*ttail(r(df_r),abs(M[1,4])/sqrt(V[4,4]))
	mat PP[5,`i']=2*ttail(r(df_r),abs(M[1,5])/sqrt(V[5,5]))
 	mat PP[6,`i']=2*ttail(r(df_r),abs(M[1,6])/sqrt(V[6,6]))
	mat SE[4,`i']=sqrt(V[4,4])
	mat SE[5,`i']=sqrt(V[5,5])
 	mat SE[6,`i']=sqrt(V[6,6])
	quietly margins, dydx(i.t0choice) at(style_int_cat=(1 2 3))
	mat M=r(b)
	mat V=r(V)
	mat MM[7,`i']=M[1,4]
	mat MM[8,`i']=M[1,5]
	mat MM[9,`i']=M[1,6]
	mat PP[7,`i']=2*ttail(r(df_r),abs(M[1,4])/sqrt(V[4,4]))
	mat PP[8,`i']=2*ttail(r(df_r),abs(M[1,5])/sqrt(V[5,5]))
 	mat PP[9,`i']=2*ttail(r(df_r),abs(M[1,6])/sqrt(V[6,6]))
	mat SE[7,`i']=sqrt(V[4,4])
	mat SE[8,`i']=sqrt(V[5,5])
 	mat SE[9,`i']=sqrt(V[6,6])
}






set more off
.cond=.object.new
.cond.Declare array list
.cond.list[1]="Political attitudes"
.cond.list[2]="Pol: Right"
.cond.list[3]="Pol: Wrong"
.cond.list[4]="Pol: DTA"
.cond.list[5]="Trust of experts"
.cond.list[6]="Trust: \$> 0\$"
.cond.list[7]="Trust: \$< 0\$"
.cond.list[8]="Trust: DTA"
.cond.list[9]="Intuitive style"
.cond.list[10]="Int.: \$> 0\$"
.cond.list[11]="Int.: \$< 0\$"
.cond.list[12]="Int.: DTA"

.pr=.object.new
.pr.Declare array list
.pr.list[1]="\rowcolor{Gray}"
.pr.list[2]="\rowcolor{white}"
.pr.list[3]="\rowcolor{white}"
.pr.list[4]="\rowcolor{white}"
.pr.list[5]="\rowcolor{Gray}"
.pr.list[6]="\rowcolor{white}"
.pr.list[7]="\rowcolor{white}"
.pr.list[8]="\rowcolor{white}"
.pr.list[9]="\rowcolor{Gray}"
.pr.list[10]="\rowcolor{white}"
.pr.list[11]="\rowcolor{white}"
.pr.list[12]="\rowcolor{white}"

*mat VV=[1,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0]
mat MJ=[1, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9]

file open mf using "`fname'", write replace
file write mf "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write mf "\begin{tabular}{p{3.5cm}*{`n'}{c}}" _n
file write mf "\hline" _n
file write mf "&`title'\\" _n
file write mf "&`title2'\\" _n
file write mf "\hline" _n
forval j=1/12 {
		
		local mtit="`.cond.list[`j']'"
		local prefix="`.pr.list[`j']'"
		file write mf "`prefix'" _n
		file write mf "`mtit'"
		local jj=MJ[1,`j']
		if ~inlist(`j',1,5,9) {
		forval i=1/`n' {
			local s1=""
			local s2=""
			if PP[`jj',`i']<0.01 {
				*local s1="{\bf "
				local s1=""
				*local s2="}"
				local s2="\$ ^{***} \$"
			}
			else if PP[`jj',`i']<0.05 {
				*local s1="{\bf "
				local s1=""
				*local s2="}"
				local s2="\$ ^{**} \$"
			}
			else if PP[`jj',`i']<0.1 {
				*local s1="{\bf "
				local s1=""
				*local s2="}"
				local s2="\$ ^{*} \$"
			}
			local v00=string(MM[`jj',`i'],"%9.4f")
			file write mf "&`s1'`v00'`s2'"						
		}		
		file write mf "\\" _n
		forval i=1/`n' {
			local s1="("
			local s2=")"
			*if PP[`jj',`i']<0.1 {
			*	local s1="{\bf "
			*	local s2="}"
			*}
			local v00=string(SE[`jj',`i'],"%9.4f")
			file write mf "&`s1'`v00'`s2'"						
			
		}		
		}
		if inlist(`j',1,5,9) {
			forval i=1/`n' {
				file write mf "&"
			}
		}
		file write mf "\\" _n
		if inlist(`j',4,8,12) {
				file write mf "\hline" _n
		}
}	

file write mf "\$ R^2 \$"
forval i=1/`n' {
	local v00=string(RR[1,`i'],"%9.4f")
	file write mf "&`v00'"
}
file write mf "\\" _n

file write mf "\$ N \$"
forval i=1/`n' {
	local v00=string(NN[1,`i'],"%9.0f")
	file write mf "&`v00'"
}
file write mf "\\" _n
local nn=`n'+1
file write mf "\multicolumn{`nn'}{p{16cm}}{`note'}" _n
file write mf "\end{tabular}"
file close mf


