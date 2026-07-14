/* Derived from "MY SAS PROJECT CHAPTER 1 2.sas": the sleep-duration cleaning
   and grouping work.  SLEPTIM1 has ineligible codes (77/99), so the author
   suppresses them into SLEPTIM2, reviews the distribution with PROC
   UNIVARIATE, then builds a four-level SLEEPGRP plus indicator variables and
   checks them with crosstabs.  A small mock BRFSS_a stands in for the r.
   library extract; the cleaning, grouping, and PROC statements are theirs. */

data BRFSS_a;
  input SLEPTIM1 ASTHMA3;
  datalines;
7 1
6 2
8 1
5 2
9 1
4 2
77 1
99 2
10 1
7 2
6 1
;
run;

/*Review distribution of sleep duration*/

proc freq data = BRFSS_a;
	tables SLEPTIM1 /missing;
run;

/*Create SLEPTIM2 suppressing ineligible values*/

data clean_Example;
set BRFSS_a;

SLEPTIM2=SLEPTIM1;

if SLEPTIM1 ge 77 then SLEPTIM2=.;

run;

/*Check recode with PROC FREQ*/
proc freq data =clean_example;
tables SLEPTIM1*SLEPTIM2/list missing ;
run;

/*PROC UNIVARIATE on new variable is accurate*/

proc univariate data = clean_example;
var SLEPTIM2;
run;

/*Example: Create arbitrary grouping*/

data Grouping_Example;
	set clean_Example;

	SLEEPGRP = 9;

	if SLEPTIM1 le 5
		then SLEEPGRP = 1;
	if (SLEPTIM1 gt 5) & (SLEPTIM1 le 7)
		then SLEEPGRP = 2;
	if (SLEPTIM1 gt 7) & (SLEPTIM1 le 9)
		then SLEEPGRP = 3;
	if SLEPTIM1 gt 9
		then SLEEPGRP = 4;

	if SLEEPGRP = 1
		then SG1 = 1;
	else SG1 = 0;

	if SLEEPGRP = 2
		then SG2 = 1;
	else SG2 = 0;

	if SLEEPGRP = 3
		then SG3 = 1;
	else SG3 = 0;

run;

/*check recode*/

proc freq data=Grouping_Example;
	tables SLEPTIM1*SLEEPGRP/list missing;
	tables SLEEPGRP*SG1/list missing;
	tables SLEEPGRP*SG2/list missing;
	tables SLEEPGRP*SG3/list missing;
run;
