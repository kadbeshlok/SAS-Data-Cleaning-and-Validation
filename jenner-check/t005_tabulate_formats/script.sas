/* Derived from "MY SAS PROJECT CHAPTER 1 2.sas": the PROC TABULATE
   descriptive table.  The author labels the analytic variables, defines value
   formats for asthma / diabetes / age group / sex, and builds a cross
   tabulation with N and column-percent statistics.  A small mock analytic
   dataset replaces the r. library extract; the labels, PROC FORMAT value
   definitions, and PROC TABULATE table statement are the author's. */

data example;
  input ASTHMA3 DIABETE4 _AGE_G SEX;
  datalines;
1 1 3 1
2 2 4 2
1 1 5 1
2 2 2 2
1 2 6 1
2 1 3 2
1 1 4 1
2 2 5 2
;
run;

data example;
	set example;
	label ASTHMA3 = "Asthma Status";
	label DIABETE4 = "Diabetes Status";
	label _AGE_G = "Age Group";
	label SEX = "Sex";
run;

/*set up formats*/

proc format;
	value asthma_f
	1 = "Has Asthma"
	2 = "No Asthma"
	;
	value diabete_f
	1 = "Diabetic"
	2 = "Non-diabetic"
	;
	value age_g_f
	1 = "18-24"
	2 = "25-34"
	3 = "35-44"
	4 = "45-54"
	5 = "55-64"
	6 = "65+"
	;
	value sex_f
	1 = "Male"
	2 = "Female"
	;
run;

/*apply formats in proc tabulate*/

proc tabulate data=example;
	format 	ASTHMA3 asthma_f.
			DIABETE4 diabete_f.
			_AGE_G age_g_f.
			SEX sex_f.;
	class 	ASTHMA3
			DIABETE4
			_AGE_G
			SEX;
	table (ALL DIABETE4 _AGE_G SEX),
			(ALL ASTHMA3)*(N colpctn*f=4.1);

run;
