/* Derived from "MY SAS PROJECT CHAPTER 21.sas": the blood-pressure work.
   The author reviews systolic BP (BPXOSY1) with PROC UNIVARIATE, builds a
   four-level BPGrp following clinical thresholds (<120, 120-129, 130-139,
   140+) while guarding against missing, checks it with a crosstab, and plots
   diastolic against systolic.  A small mock BP_a replaces the LiL library
   extract; the grouping thresholds and PROC statements are the author's. */

data BP_a;
  input BPXOSY1 BPXODI1;
  datalines;
118 78
125 80
132 85
145 90
110 70
138 88
122 79
150 95
. .
128 82
115 75
142 91
;
run;

proc univariate data =BP_a normal plot;
var BPXOSY1;
RUN;

data BP_b;
	set BP_a;

BPGrp = 9;
	if BPXOSY1 < 120 & BPXOSY1 ne .
		then BPGrp = 1;
	if BPXOSY1 ge 120 & BPXOSY1 < 130
		then BPGrp = 2;
	if BPXOSY1 ge 130 & BPXOSY1 <140
		then BPGrp = 3;
	if BPXOSY1 ge 140
		then BPGrp = 4;
run;

proc freq data = BP_b;
	tables BPXOSY1*BPGrp / list missing;
run;

/*group scatter plot by gender*/

proc sgplot data=BP_a;
	scatter y=BPXODI1 x=BPXOSY1;
run;
