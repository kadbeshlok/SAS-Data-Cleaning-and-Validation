/* Derived from "MY SAS PROJECT CHAPTER 1 2.sas": the Chapter 3 block that
   collapses BRFSS demographic variables into analytic grouping variables
   (MARGRP, EDGROUP, GENHLTH2, INCOME3, RACEGRP, EXERANY3, HLTHPLN2, BMICAT)
   and then checks each recode with a list/missing crosstab.  A small mock
   brfss_i with the same source variables replaces the r. library extract;
   the recode logic and PROC FREQ checks are the author's. */

data brfss_i;
  input MARITAL EDUCA GENHLTH INCOME2 _MRACE1 EXERANY2 HLTHPLN1 _BMI5CAT;
  datalines;
1 6 2 5 1 1 1 3
6 4 3 6 2 2 2 2
2 5 4 7 3 1 1 4
3 3 1 8 4 2 2 1
5 2 5 4 5 1 1 3
4 1 3 2 7 2 1 2
2 4 2 3 6 1 2 4
;
run;

data brfss_recoded;
set brfss_i;

margrp=9;
if (MARITAL = 1 | MARITAL = 6)
		then MARGRP = 1;
if MARITAL in (2, 3, 4)
		then MARGRP = 2;
	if MARITAL = 5
		then MARGRP = 3;

	EDGROUP = 9;
	if EDUCA in (1, 2, 3)
		then EDGROUP = 1;
	if EDUCA = 4
		then EDGROUP = 2;
	if EDUCA = 5
		then EDGROUP = 3;
	if EDUCA = 6
		then EDGROUP = 4;

	GENHLTH2 = GENHLTH;

	if GENHLTH2 not in (1, 2, 3, 4, 5)
		then GENHLTH2 = 9;

	INCOME3 = INCOME2;

	if INCOME3 not in (1, 2, 3, 4, 5, 6, 7, 8)
		then INCOME3 = 9;

	RACEGRP = _MRACE1;

	if _MRACE1 = 7
		then RACEGRP = 6;
	if _MRACE1 not in (1, 2, 3, 4, 5, 6, 7)
		then RACEGRP = 9;

	EXERANY3 = EXERANY2;

	if EXERANY2 not in (1, 2)
		Then EXERANY3 = 9;

	HLTHPLN2 = HLTHPLN1;

	if HLTHPLN1 not in (1, 2)
		Then HLTHPLN2 = 9;

	BMICAT = _BMI5CAT;

	if BMICAT not in (1, 2, 3, 4)
		then BMICAT = 9;
run;

	proc freq data = brfss_recoded;
	tables MARITAL *MARGRP/list missing;
	table EDGROUP * EDUCA / list missing;
table GENHLTH2 * GENHLTH / list missing;
table INCOME3 * INCOME2 / list missing;
table RACEGRP * _MRACE1 / list missing;
table EXERANY3 * EXERANY2 / list missing;
table HLTHPLN2 * HLTHPLN1 / list missing;
table BMICAT * _BMI5CAT / list missing;
run;
