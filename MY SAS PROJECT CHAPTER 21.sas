libname liL "/home/u64117567/MY SAS PROJECT/CODE/Exercise files/ch03";


data LiL.bp_a;
set liL.p_bpxo;
run;


proc contents data =LIL.bp_a;run;


proc univariate data =LIL.bp_a normal plot;
var BPXOSY1;
RUN;



data LIL.BP_b;
	set LIL.BP_a;

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

proc freq data = LIL.BP_b;
	tables BPXOSY1*BPGrp / list missing;
run;


/*group scatter plot by gender*/



data LIL.BP_a;
	set LIL.P_BPXO;
run;

proc contents data=LIL.BP_a;
run;

proc sgplot data=LIL.BP_a;
	scatter y=BPXODI1 x=BPXOSY1;
run;

