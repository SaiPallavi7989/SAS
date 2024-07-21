libname hi "/home/u63815594/sasuser.v94";
filename github "/home/u63815594/sasuser.v94/Telugu_songs.csv";
data hi.github;
infile github dlm=',';
input song_name :$30. singer :$50.  duration :time11. danceability acousticness energy liveness loudness speechiness tempo mode key Valence time_signature popularity Stream
;
format duration :time11.;
run;   

proc print data=hi.github;
run;

/* Explore the data */
proc contents data=hi.github;
run;

proc means data=hi.github;
  var duration danceability acousticness energy liveness loudness speechiness tempo;
run;

proc freq data=hi.github;
  tables singer mode key time_signature;
run;

/* Analyze song characteristics */
proc corr data=hi.github;
  var danceability acousticness energy liveness loudness speechiness tempo;
run;

proc reg data=hi.github;
  model popularity = danceability acousticness energy liveness loudness speechiness tempo;
run;

/* Analyze singer characteristics */
proc means data=hi.github;
  class singer;
  var duration danceability acousticness energy liveness loudness speechiness tempo;
run;

proc freq data=hi.github;
  tables singer*mode singer*key singer*time_signature;
run;

/* Identify popular songs and singers */
proc sort data=hi.github;
  by descending popularity;
run;

proc print data=hi.github (obs=10);
  var song_name singer popularity;
run;

proc freq data=hi.github;
  tables singer / out=singer_freq;
run;

proc sort data=singer_freq;
  by descending count;
run;

/* Visualize the data */
ods graphics / width=800px height=600px;

proc sgplot data=hi.github;
  scatter x=danceability y=energy;
  title "Danceability vs Energy";
run;

proc sgplot data=hi.github;
  histogram tempo;
  title "Tempo Distribution";
run;

proc sgplot data=hi.github;
  vbox popularity / category=singer;
  title "Popularity by Singer";
run;

proc gchart data=hi.github;
pie3d duration;
run;

/* Create a histogram for the variables */
proc univariate data=hi.github normal; 
histogram  / normal;
run;

/*  ANOVA for 'mode' */
proc anova data=hi.github;
class mode;
model popularity = mode;
run;


/*Data exploration: Uses PROC CONTENTS to display the dataset's structure and PROC MEANS to calculate summary statistics for the numerical variables.
Frequency analysis: Uses PROC FREQ to analyze the categorical variables (singer, mode, key, time_signature).
Correlation analysis: Uses PROC CORR to examine the relationships between the song characteristics (danceability, acousticness, energy, etc.).
Regression analysis: Uses PROC REG to model the relationship between the song characteristics and popularity.
Singer analysis: Uses PROC MEANS and PROC FREQ to analyze the singer characteristics and identify popular singers.
Popular songs and singers: Uses PROC SORT and PROC PRINT to identify the top 10 most popular songs and singers.
Data visualization: Uses PROC SGPLOT to create scatter plots, histograms, and box plots to visualize the data.*/











































































