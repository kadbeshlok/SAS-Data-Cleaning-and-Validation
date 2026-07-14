/* Derived from "MY SAS PROJECT CHAPTER 1 2.sas": the chronic-disease index.
   Eleven condition flags are built from BRFSS yes/no items and summed into
   CDINDEX, then each flag is checked against its source variable and the
   index distribution is tabulated.  A small mock BRFSS_a with the eleven
   source variables replaces the r. library extract; the flag construction,
   the CDINDEX sum, and the PROC FREQ checks are the author's. */

data BRFSS_a;
  input CVDINFR4 CVDCRHD4 CVDSTRK3 ASTHMA3 CHCSCNCR CHCOCNCR
        CHCCOPD1 HAVARTH3 ADDEPEV2 CHCKIDNY DIABETE3;
  datalines;
1 2 2 1 2 2 2 1 2 2 1
2 1 2 2 2 2 1 2 1 2 3
2 2 1 1 1 2 2 1 2 1 1
1 1 2 2 2 1 2 2 2 2 2
2 2 2 2 2 2 2 2 2 2 3
1 2 1 1 2 2 1 1 1 2 1
;
run;

/*create index for chronic diseases*/

data IndexExample;
	set BRFSS_a;

	HAFLAG = 0;
	if CVDINFR4 = 1
		then HAFLAG = 1;

	ANGFLAG = 0;
	if CVDCRHD4 = 1
		then ANGFLAG = 1;

	STRKFLAG = 0;
	if CVDSTRK3 = 1
		then STRKFLAG = 1;

	ASTHMAFLAG = 0;
	if ASTHMA3 = 1
		then ASTHMAFLAG = 1;

	SKINCAFLAG = 0;
	if CHCSCNCR = 1
		then SKINCAFLAG = 1;

	OTHCAFLAG = 0;
	if CHCOCNCR = 1
		then OTHCAFLAG = 1;

	COPDFLAG = 0;
	if CHCCOPD1 = 1
		then COPDFLAG = 1;

	ARTHFLAG = 0;
	if HAVARTH3 = 1
		then ARTHFLAG = 1;

	DEPFLAG = 0;
	if ADDEPEV2 = 1
		then DEPFLAG = 1;

	KIDNEYFLAG = 0;
	if CHCKIDNY = 1
		then KIDNEYFLAG = 1;

	DIABFLAG = 0;
	if DIABETE3 = 1
		then DIABFLAG = 1;

	CDINDEX = HAFLAG + ANGFLAG + STRKFLAG + ASTHMAFLAG + SKINCAFLAG +
				OTHCAFLAG + COPDFLAG + ARTHFLAG + DEPFLAG + KIDNEYFLAG + DIABFLAG;

run;


/*check individual flags*/

proc freq data=IndexExample;
	tables HAFLAG * CVDINFR4 /list missing;
	tables ASTHMAFLAG * ASTHMA3 /list missing;
	tables DIABFLAG * DIABETE3 /list missing;
run;

/*check index*/

proc freq data=IndexExample;
	tables CDINDEX /missing;
run;
