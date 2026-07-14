/* Derived from "MY SAS PROJECT CHAPTER 1 2.sas": the DIABETE3 -> DIABETE4
   recode and the "check recode with a crosstab" pattern.  The original reads
   the BRFSS 2014 XPT extract through the r. library; here a small mock
   brfss_b with the same variables stands in so the recode logic runs
   in isolation.  The recode and PROC FREQ statements are the author's. */

data brfss_b;
  input VETERAN3 DIABETE3 ASTHMA3 SLEPTIM1 SEX;
  datalines;
1 1 1 7 1
1 3 2 6 2
1 2 1 8 1
1 4 2 5 2
1 1 1 9 1
1 3 1 6 2
1 2 2 7 1
1 1 2 8 2
;
run;

/* create recode of DIABETE3 in DIABETE4 */

data brfss_g;
set brfss_b;
DIABETE4 = 9;
if  DIABETE3 in (1,2)
then  DIABETE4 =1 ;

if  (DIABETE3 =3 |  DIABETE4 =4)
then  DIABETE4 =2 ;
run;

/*   check recode */

/* proc freq without list options  */
proc freq data = brfss_g;
tables DIABETE3*DIABETE4/missing;
run;

/* proc freq with list options  */
proc freq data = brfss_g;
tables DIABETE3*DIABETE4/list missing;
run;

/* chi-square between the recoded diabetes flag and asthma */
proc freq data = brfss_g;
	tables DIABETE4*ASTHMA3/nocol norow nopercent chisq;
run;
