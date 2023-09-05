/*EXAMPLE 8-1 PAGE 308*/
proc factex;
factors A B C D;
size design=8;
model resolution=max;
examine design;
examine aliasing;
/*examine confounding;*/
output out = design.chp8_p1;
run;

data design.chp8_p1;
set design.chp8_p1;
input response;
datalines;
45
75
45
80
100
60
65
96
;

proc glm data=design.chp8_p1;
class A B C D;
model response = A|B|C|D;
run;

proc glm data=design.chp8_p1 outstat = design.ss_p1;
class A B C D;
model response =  A B C D A*B A*C;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'interaction effect A*B' A*B  0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*C' A*C 0.5 -0.5 -0.5 0.5;
run;

proc sql;
    delete from design.ss_p1
    where _SOURCE_ = "ERROR";
quit;

proc sql;
    delete from design.ss_p1
    where _TYPE_ = "SS3";
quit;

data design.ss_p1;
set design.ss_p1;
effect = sqrt(SS/2);
run;


data design.normal_p1;
do j = 1 to 6 by 1;
do pj = (j-0.5)/6;
output ;
end ;
end ;
keep j pj;
run ;


proc sort data=design.ss_p1;
   by effect;
run;


data design.ss_p1;
set design.ss_p1;
set design.normal_p1;


proc plot data=design.ss_p1;
   plot pj*effect = '*' $ _SOURCE_ ;
   title 'Half Normal plot for effects';
run;


data design.effects_p1;
input effects factors $;
datalines;
19.0000000 A
1.5000000 B
16.5000000 C
14.0000000 D
-1.0000000 AB
-18.5000000 AC
;

proc sort data=design.effects_p1;
   by effects;
run;
   
data design.normal_p1;
do j = 1 to 6 by 1;
do pj = (j-0.5)/6;
output ;
end ;
end ;
keep effects factors j pj;
run ;

data design.final1;
set design.effects_p1;
set design.normal_p1;

proc plot data=design.final1;
   plot pj*effects = '*' $ factors ;
   title 'Normal probability plot for effects';
run;

/*EXAMPLE 8-2 PAGE 311*/
proc factex;
factors A B C D E;
size design=16;
model resolution=max;
examine design;
examine aliasing;
/*examine confounding;*/
output out = design.chp8_p2;
run;

data design.chp8_p2;
set design.chp8_p2;
input response;
datalines;
8
6
16
15
34
30
45
44
9
10
22
21
52
50
60
63
;

proc glm data=design.chp8_p2 outstat = design.ss_p2;
class A B C D E;
model response =  A B C D E A*B A*C A*D A*E B*C B*D B*E C*D C*E;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'main effect E' E -1 1 ;
estimate  'interaction effect A*B' A*B  0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*C' A*C 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*D' A*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*E' A*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*C' B*C 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*D' B*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*E' B*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*D' C*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*E' C*E 0.5 -0.5 -0.5 0.5;
run;



proc sql;
    delete from design.ss_p2
    where _SOURCE_ = "ERROR";
quit;

proc sql;
    delete from design.ss_p2
    where _TYPE_ = "SS3";
quit;

data design.ss_p2;
set design.ss_p2;
effect = sqrt(SS)/2;
run;

data design.normal_p2;
do j = 1 to 15 by 1;
do pj = (j-0.5)/15;
output ;
end ;
end ;
keep j pj;
run ;


proc sort data=design.ss_p2;
   by effect;
run;


data design.ss_p2;
set design.ss_p2;
set design.normal_p2;


proc plot data=design.ss_p2;
   plot pj*effect = '*' $ _SOURCE_ ;
   title 'Half Normal plot for effects';
run;


proc glm data=design.chp8_p2;
class A B C D E;
model response =  A B C A*B;
output out=design.out_p2  p=yhat r=resid;
run;

proc gplot data=design.out_p2;
plot resid*yhat;
run;

proc univariate data=design.out_p2;
probplot resid;
run;

/*EXAMPLE 8-3 PAGE 315*/
data design.chp8_p3;
do C =-1 to 1 by 2;
do B =-1 to 1 by 2;
do A =-1 to 1 by 2;
output ;
end ;
end ;
end ;
keep C B A;
run ;

data design.chp8_p3;
set design.chp8_p3;
D = -A*B*C;
run;

data design.chp8_p3;
set design.chp8_p3;
input response;
datalines;
43
71
48
104
68
86
70
65
;
proc glm data=design.chp8_p3;
class A B C D;
model response =  A B C D A*B A*C;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'interaction effect A*B' A*B  0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*C' A*C 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*D' A*D 0.5 -0.5 -0.5 0.5;
run;

/*EXAMPLE 8-4 PAGE 319*/
proc factex;
factors A B C D E F;
size design=16;
model resolution=4;
examine design;
examine aliasing;
examine confounding;
output out = design.chp8_p4;
run;

data design.chp8_p4;
do D =-1 to 1 by 2;
do C =-1 to 1 by 2;
do B =-1 to 1 by 2;
do A =-1 to 1 by 2;
output ;
end ;
end ;
end ;
end ;
keep D C B A;
run ;

data design.chp8_p4;
set design.chp8_p4;
E = A*B*C;
F = B*C*D;
run;

data design.chp8_p4;
set design.chp8_p4;
input response;
datalines;
6
10
32
60
4
15
26
60
8
12
34
60
16
5
37
52
;

proc glm data=design.chp8_p4 outstat = design.ss_p4;
class A B C D E F;
model response = A B C D E F A*B A*C A*D A*E A*F B*D B*F A*B*D;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'main effect E' E -1 1 ;
estimate  'main effect F' F -1 1 ;
estimate  'interaction effect A*B' A*B  0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*C' A*C 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*D' A*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*E' A*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*F' A*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*D' B*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*F' B*F 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*B*D' A*B*D -0.25 0.25 0.25 -0.25 0.25 -0.25 -0.25 0.25;
output out=design.out_p4  p=yhat r=resid;
run;

proc sql;
    delete from design.ss_p4
    where _SOURCE_ = "ERROR";
quit;

proc sql;
    delete from design.ss_p4
    where _TYPE_ = "SS3";
quit;

data design.ss_p4;
set design.ss_p4;
effect = sqrt(SS/4);
run;


data design.normal_p4;
do j = 1 to 14 by 1;
do pj = (j-0.5)/14;
output ;
end ;
end ;
keep j pj;
run ;


proc sort data=design.ss_p4;
   by effect;
run;


data design.ss_p4;
set design.ss_p4;
set design.normal_p4;


proc plot data=design.ss_p4;
   plot pj*effect = '*' $ _SOURCE_ ;
   title 'Half Normal plot for effects';
run;

proc glm data=design.chp8_p4;
class A B;
model response = A B A*B;
output out=design.out_p4  p=yhat r=resid;
run;

proc gplot data=design.out_p4;
plot resid*C;
run;

proc univariate data=design.out_p4;
probplot resid;
run;


/*EXAMPLE 8-5 PAGE 327*/

/*EXAMPLE 8-6 PAGE 332*/

data design.chp8_p6;
do E =-1 to 1 by 2;
do D =-1 to 1 by 2;
do C =-1 to 1 by 2;
do B =-1 to 1 by 2;
do A =-1 to 1 by 2;
output ;
end ;
end ;
end ;
end ;
end ;
keep E D C B A;
run ;

data design.chp8_p6;
set design.chp8_p6;
F = A*B*C;
G = A*B*D;
H = B*C*D*E;
run;

data design.chp8_p6;
set design.chp8_p6;
input block response;
datalines;
3 2.76
2 6.18
4 2.43
1 4.01
1 2.48
4 5.91
2 2.39
3 3.35
1 4.40
4 4.10
2 3.22
3 3.78
3 5.32
2 3.87
4 3.03
1 2.95
2 2.64
3 5.50
1 2.24
4 4.28
4 2.57
1 5.37
3 2.11
2 4.18
4 3.96
1 3.27
3 3.41
2 4.30
2 4.44
3 3.65
1 4.41
4 3.40
;

data design.chp8_p6;
set design.chp8_p6;
response=(response)*1000;
run;

data design.chp8_p6;
set design.chp8_p6;
response=log(response);
run;

proc glm data=design.chp8_p6 outstat = design.ss_p6;
class A B C D E F G H;
model response = A B C D E F G H A*B A*C A*D A*E A*F A*G A*H B*E B*H C*D C*E C*G C*H D*E D*H E*F E*G E*H F*H G*H A*B*E A*B*H;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect E' E -1 1 ;
estimate  'main effect F' F -1 1 ;
estimate  'main effect G' G -1 1 ;
estimate  'main effect H' H -1 1 ;
estimate  'interaction effect A*B' A*B  0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*C' A*C 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*D' A*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*E' A*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*F' A*F 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*G' A*G 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*H' A*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*E' B*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect B*H' B*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*D' C*D 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*E' C*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*G' C*G 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect C*H' C*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect D*E' D*E 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect D*H' D*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect E*F' E*F 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect E*G' E*G 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect E*H' E*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect F*H' F*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect G*H' G*H 0.5 -0.5 -0.5 0.5;
estimate  'interaction effect A*B*E' A*B*E -0.25 0.25 0.25 -0.25 0.25 -0.25 -0.25 0.25;
estimate  'interaction effect A*B*H' A*B*H -0.25 0.25 0.25 -0.25 0.25 -0.25 -0.25 0.25;
output out=design.out_p6  p=yhat r=resid ;
run;

proc sql;
    delete from design.ss_p6
    where _SOURCE_ = "ERROR";
quit;

proc sql;
    delete from design.ss_p6
    where _TYPE_ = "SS3";
quit;

data design.ss_p6;
set design.ss_p6;
effect = sqrt(SS/8);
run;


data design.normal_p6;
do j = 1 to 30 by 1;
do pj = (j-0.5)/30;
output ;
end ;
end ;
keep j pj;
run ;


proc sort data=design.ss_p6;
   by effect;
run;


data design.ss_p6;
set design.ss_p6;
set design.normal_p6;


proc plot data=design.ss_p6;
   plot pj*effect = '*' $ _SOURCE_ ;
   title 'Half Normal plot for effects';
run;

proc glm data=design.chp8_p6;
class block A B D;
model response = block A B D A*D;
output out=design.out_p6  p=yhat r=resid;
run;

proc gplot data=design.out_p6;
plot resid*yhat;
run;

proc univariate data=design.out_p6;
probplot resid;
run;



/*EXAMPLE 8-7 PAGE 340*/
data design.chp8_p7;
do C =-1 to 1 by 2;
do B =-1 to 1 by 2;
do A =-1 to 1 by 2;
output ;
end ;
end ;
end ;
keep C B A;
run ;

data design.chp8_p7;
set design.chp8_p7;
D = A*B;
E = A*C;
F = B*C;
G = A*B*C;
run;

data design.chp8_p7;
set design.chp8_p7;
input response;
datalines;
85.5
75.1
93.2
145.4
83.7
77.6
95.0
141.8
;

proc glm data=design.chp8_p7;
class A B C D E F;
model response =  A B C D E F;
estimate  'main effect A' A -1 1 ;
estimate  'main effect B' B -1 1 ;
estimate  'main effect D' D -1 1 ;
estimate  'main effect C' C -1 1 ;
estimate  'main effect E' E -1 1 ;
estimate  'main effect F' F -1 1 ;
run;

/*EXAMPLE 8-8 PAGE 345*/
