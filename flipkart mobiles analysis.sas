libname hi "/home/u63842406/sasuser.v94";
filename mobile "/home/u63842406/sasuser.v94/Flipkart_Mobiles.csv";
data hi.mobile;
infile mobile dsd dlm=',';
input Brand	$ Model :$40. Color :$15. Memory $ Storage $ Rating SellingPrice :9. OriginalPrice :9.
;
run;
 
proc print data=hi.mobile;
run;

title "Average Selling Price and Original Price";
proc means data=hi.mobile;
var SellingPrice;
var OriginalPrice;
run;

title "Most offered colors by all Mobile Brands";
proc gchart data=hi.mobile;
pie3d Color/ levels=all;
run;

title "Histogram for Selling Price"; 
proc sgplot data=hi.mobile; 
 histogram sellingprice; 
 density sellingprice; 
run;

title "Histogram for Original Price"; 
proc sgplot data=hi.mobile; 
 histogram originalprice; 
 density originalprice; 
run;

/* plotting of Mobile Brands */
proc sgplot data=hi.mobile;
  vbar Brand;
run;

title "Relation between Rating and SellingPrice";
proc sgscatter data=hi.mobile;
plot rating * sellingprice/jitter reg;
run;

title "Distribution of rating and sellingprice";
proc univariate data=hi.mobile normal;
var rating sellingprice;
histogram rating sellingprice /normal(mu=est sigma=est);
inset skewness kurtosis;
run;

title "correlation between rating and sellingprice";
proc corr data=hi.mobile pearson rank plots=matrix (nvar=all histogram);
var rating sellingprice;
run;

title "Regression between rating and sellingprice";
proc reg data=hi.mobile;
model rating= sellingprice;
run;

title "Mobile Brand with most product offering in the Indian Market";
proc gchart data=hi.mobile;
var3d brand;
run;

title "anova";
proc anova data=hi.mobile;
class brand;
model sellingprice=brand;
run;

/* Create a box plot for Selling Price by Brand */
proc sgplot data=hi.mobile;
  vbox sellingprice / category=Brand;
run;

/* plotting original prices of Brands*/
proc sgplot data=hi.mobile;
  hbox OriginalPrice / category=Brand ;
run;

footnote "Analysis of Flipkart Mobiles Dataset";
run;






