/*Importing the Data*/
FILENAME REFFILE '/home/u63251556/online_shoppers_intention.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=online_shoppers;
	GETNAMES=YES;
RUN;

/*print the results
proc print data=online_shoppers;
run;*/

PROC CONTENTS DATA=online_shoppers1;
RUN;
/* Here is a brief explanation of each variable in the Online Shoppers Purchasing Intention Dataset:

Administrative: Represents the number of pages visited by the user in the "Administrative" category (such as the website's about us, contact us, and legal pages).
Administrative_Duration: Represents the total time spent by the user on pages in the "Administrative" category during the session.
Informational: Represents the number of pages visited by the user in the "Informational" category (such as the website's FAQ, terms of service, and privacy policy pages).
Informational_Duration: Represents the total time spent by the user on pages in the "Informational" category during the session.
ProductRelated: Represents the number of pages visited by the user in the "Product Related" category (such as product pages, product categories, and the shopping cart).
ProductRelated_Duration: Represents the total time spent by the user on pages in the "Product Related" category during the session.
BounceRates: Represents the percentage of visits in which the user entered the website and left without interacting with any of the pages on the site.
ExitRates: Represents the percentage of visits to a particular page that were the last in the session.
PageValues: Represents the average value of the pages visited by the user before completing an e-commerce transaction.
SpecialDay: Represents the closeness of the session visit time to a specific special day, such as Valentine's Day or Mother's Day.
Month: Represents the month of the year in which the session took place.
OperatingSystems: Represents the operating system used by the user's device during the session.
Browser: Represents the browser used by the user during the session.
Region: Represents the geographic region from which the user accessed the website.
TrafficType: Represents the type of traffic source that led the user to the website (such as search engines, social media, or direct traffic).
VisitorType: Represents whether the user is a new or returning visitor to the website.
Weekend: A binary variable that indicates whether the session took place on a weekend or not.
Revenue: A binary variable indicating whether a transaction was made. "TRUE" means that a transaction was made, while "FALSE" means that a transaction was not made.
*/
/*The dataset consists of 10 numerical and 8 categorical attributes.*/

/* Basic descriptive analysis */

/* Checking NUll Values */
proc means data=online_shoppers nmiss n; 
run; /*There are no null values*/


/*Use PROC MEANS to calculate summary statistics for the numerical variables.*/
PROC MEANS DATA=online_shoppers;
VAR Administrative Administrative_Duration Informational Informational_Duration ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues SpecialDay;
RUN;

/*Administrative: the mean number of administrative pages visited by users is 2.32, with a standard deviation of 3.32. The minimum and maximum values are 0 and 27, respectively.
Administrative_Duration: the mean duration of administrative page visits is 80.82 seconds, with a standard deviation of 176.78 seconds. The minimum and maximum values are 0 and 3,399 seconds, respectively.
Informational: the mean number of informational pages visited by users is 0.50, with a standard deviation of 1.27. The minimum and maximum values are 0 and 24, respectively.
Informational_Duration: the mean duration of informational page visits is 34.47 seconds, with a standard deviation of 140.75 seconds. The minimum and maximum values are 0 and 2,549 seconds, respectively.
ProductRelated: the mean number of product-related pages visited by users is 31.73, with a standard deviation of 44.48. The minimum and maximum values are 0 and 705, respectively.
ProductRelated_Duration: the mean duration of product-related page visits is 1,194.75 seconds, with a standard deviation of 1,913.67 seconds. The minimum and maximum values are 0 and 63,973 seconds, respectively.
BounceRates: the mean bounce rate is 0.02, with a standard deviation of 0.05. The minimum and maximum values are 0 and 0.20, respectively.
ExitRates: the mean exit rate is 0.04, with a standard deviation of 0.05. The minimum and maximum values are 0 and 0.20, respectively.
PageValues: the mean page value is 5.89, with a standard deviation of 18.57. The minimum and maximum values are 0 and 361.76, respectively.
SpecialDay: the mean special day indicator value is 0.06, with a standard deviation of 0.20. The minimum and maximum values are 0 and 1, respectively.
*/

/*Use PROC FREQ to calculate frequency tables for the categorical variables.*/
PROC FREQ DATA=online_shoppers;
TABLES Browser Month OperatingSystems Region Revenue TrafficType VisitorType Weekend;
RUN;

/* "Browser" variable, there are 13 levels of browser usage, with the most common level being level 2 (representing 64.57% of the data) and the least common level being level 9 (representing only 0.01% of the data).

"Month" variable, there are 10 months represented in the data, with May being the most common (27.28%) and August being the least common (3.51%).

For the "OperatingSystems" variable, there are 8 levels of operating systems, with level 2 being the most common (53.54%) and level 5 being the least common (0.05%).

"Region" variable, there are 9 regions represented in the data, with region 1 being the most common (38.77%) and region 9 being the least common (4.14%).

 "Revenue" variable, there are two possible values - FALSE (representing 84.53% of the data) and TRUE (representing 15.47% of the data).

 "TrafficType" variable, there are 20 levels of traffic types, with the most common being level 2 (31.74%) and the least common being level 17 and level 12 (both representing only 0.01% of the data).

 "VisitorType" variable, there are three possible values - New_Visitor (representing 13.74% of the data), Other (representing only 0.69% of the data), and Returning_Visitor (representing 85.57% of the data).

 "Weekend" variable, there are two possible values - FALSE (representing 76.74% of the data) and TRUE (representing 23.26% of the data).




*/

/* Histograms */
proc univariate data=online_shoppers;
   var Administrative Administrative_Duration Informational Informational_Duration
       ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues;
   histogram / normal;
run;



proc univariate data=online_shoppers;
 var Revenue;
 histogram / normal;
run;

/* Scatterplot matrix for numerical variables */
PROC SGSCATTER DATA=online_shoppers;
MATRIX
  Administrative
  Administrative_Duration
  Informational
  Informational_Duration
  ProductRelated
  ProductRelated_Duration
  BounceRates 
  ExitRates
  PageValues
  / GROUP=Revenue;
RUN;

DATA online_shoppers;
SET online_shoppers;
Revenue_binary = (Revenue="TRUE") ;
run;

/*Create bar charts for categorical variables*/
proc sgplot data=online_shoppers;
vbar Browser / response=Revenue group=Browser datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar Month / response=Revenue group=Month datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar OperatingSystems / response=Revenue group=OperatingSystems datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar Region / response=Revenue group=Region datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar TrafficType / response=Revenue group=TrafficType datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar VisitorType / response=Revenue group=VisitorType datalabel datalabelattrs=(size=12) groupdisplay=cluster;
vbar Weekend / response=Revenue group=Weekend datalabel datalabelattrs=(size=12) groupdisplay=cluster;
run;

/* chisq test 
To perform a chisq test to compare the means of two groups (e.g. Revenue by VisitorType), you can use the "CHISQ" 
procedure:
*/
PROC FREQ DATA=online_shoppers;
    TABLES VisitorType*Revenue / CHISQ;
RUN;

/*
Based on the output provided, it seems that there is a statistically significant association between 
VisitorType and Revenue (chi-square test, p < .0001). Specifically, the proportion of visitors who make 
a purchase (Revenue=TRUE) appears to differ significantly across the three categories of VisitorType.

Looking at the table, it appears that returning visitors are more likely to make a purchase (13.93%) 
compared to new visitors (3.42%) and other visitors (0.13%). This suggests that website owners could consider
 targeting returning visitors with special promotions or personalized content to encourage them to make more 
 purchases.
*/

/*Run a chi-square test in SAS for the categorical variable Month and its association with Revenue:*/
PROC FREQ DATA=online_shoppers;
  TABLES Month*Revenue / CHISQ;
RUN;

/*The Chi-Square test statistic is 384.93 with a p-value of <0.0001, indicating a statistically significant 
association between Revenue and Month. This means that the Revenue is not equally distributed across different
months.

The row percentages indicate the proportion of Revenue in each Month, while the column percentages indicate
 the proportion of Revenue for each Revenue category within each Month.

For example, the highest proportion of Revenue was in May (24.32%), followed by November (18.15%). The 
highest proportion of TRUE Revenue was in May (28.78%), while the highest proportion of FALSE Revenue was in
 November (74.65%).

Overall, this analysis suggests that there are significant differences in Revenue across different months,
 and further investigation may be needed to identify the factors contributing to these differences.*/

/*Run a chi-square test for the association between two other categorical variables, such as Region and 
VisitorType*/
PROC FREQ DATA=online_shoppers;
  TABLES Region*VisitorType / CHISQ;
RUN;

/*The table shows the distribution of visitors to a website based on their region and visitor type. The table
 has 5 columns: Region, New_Visitor, Other, Returning_Visitor, and Total. The rows represent different 
 regions.

For each region, the number and percentage of visitors in each category is shown. For example, in region 1, 
there were a total of 4780 visitors, of which 657 were new visitors (13.74%), 8 were other visitors (0.17%), 
and 4115 were returning visitors (86.09%). The total percentage adds up to 100% for each region.

At the bottom of the table, the total number and percentage of visitors in each category are shown. For 
example, there were 1694 new visitors (13.74%), 10551 returning visitors (85.57%), and a total of 12330 
visitors.

The statistics at the bottom of the table show the results of a chi-square test of independence, which is 
used to determine whether there is a significant association between region and visitor type. The chi-square 
test statistic is 818.2528, which has a probability of <0.0001, indicating that there is a significant 
association between region and visitor type. Other statistics, such as the likelihood ratio chi-square, 
Mantel-Haenszel chi-square, Phi coefficient, Contingency coefficient, and Cramer's V are also shown. These 
statistics are used to measure the strength and direction of the association between region and visitor type.
*/

/**/
/* Create a format to map the categories to numerical values */
data online_shoppers1;
  set online_shoppers;
  if Revenue = "TRUE" then Revenue_numeric = 1;
  else if Revenue = "FALSE" then Revenue_numeric = 0;
run;

proc glm data=online_shoppers1;
  class Month;
  model Revenue_numeric = Month;
run;
/*
The model is significant with a p-value of <0.0001 indicating that the independent variable "Month" has a 
significant effect on the dependent variable "Revenue_numeric".

The R-squared value of 0.031219 indicates that only 3.12% of the variation in the dependent variable 
"Revenue_numeric" can be explained by the independent variable "Month". The root mean square error (RMSE) 
of 0.356115 indicates that the average difference between the predicted and actual values of the dependent 
variable is 0.356115.

The F-value of 44.11 for "Month" suggests that there is a significant effect of this independent variable on 
the dependent variable.

The Type I and Type III sums of squares (SS) values for "Month" are identical because there are no other 
independent variables in the model. The Type I SS represents the sum of squares attributable to each 
predictor variable alone, while Type III SS represents the sum of squares attributable to each predictor 
variable after all other predictors have been accounted for.

The coefficient of variation (Coeff Var) of 230.1311 indicates that the standard deviation of the dependent 
variable "Revenue_numeric" is 230.13% of the mean.

Overall, the output suggests that the independent variable "Month" has a significant effect on the dependent 
variable "Revenue_numeric", but it only explains a small proportion of the variation in "Revenue_numeric".
*/

/**/
PROC FREQ DATA=online_shoppers;
    TABLES Weekend*Revenue / CHISQ;
RUN;
/*This is a contingency table that displays the frequency and percentage distribution of Revenue 
(True or False) based on whether the visitor visited the website on a Weekend or not.

The table shows that out of the total 12330 observations, 9462 visitors did not visit on a Weekend and 2369 
visited on a Weekend. The chi-square test of independence reveals that there is a statistically significant 
association between Revenue and Weekend with a p-value of 0.0011.

Looking at the cell frequencies, 8053 visitors did not visit on a Weekend and did not make a purchase, while 
65.31% of the visitors who did not visit on a Weekend made a purchase. On the other hand, 82.60% of the 
visitors who visited on a Weekend made a purchase.

The contingency coefficient, phi coefficient, and Cramer's V all indicate a very weak association between 
Weekend and Revenue. The Fisher's exact test suggests that there is a very small probability (0.0013) of 
observing the distribution of Revenue by Weekend assuming that there is no association between the two 
variables.*/

/**/
PROC CORR data=online_shoppers1;
   VAR Administrative Administrative_Duration Informational Informational_Duration
       ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues
       SpecialDay OperatingSystems Browser Region TrafficType Revenue_numeric;
   CORR;
RUN;
/*The table shows the pairwise Pearson correlation coefficients between each pair of variables, along with 
the p-value for a test of the null hypothesis that the true correlation coefficient is zero.

For example, the top left cell shows that the correlation coefficient between "Administrative" and itself is 
1.000, which is not surprising since a variable is perfectly correlated with itself. The second cell shows 
that the correlation coefficient between "Administrative" and "Administrative_Duration" is 0.602, and the 
p-value for a test of the null hypothesis of zero correlation is less than 0.0001, indicating strong evidence
 against the null hypothesis.

Similar interpretations can be made for the other cells in the table. For example, the cell in the fifth row
 and second column shows that the correlation between "Administrative_Duration" and "ProductRelated" is 0.355,
 with a p-value less than 0.0001, indicating strong evidence of a nonzero correlation between the two variables.

In general, a correlation coefficient close to 1 indicates a strong positive correlation, a coefficient close
 to -1 indicates a strong negative correlation, and a coefficient close to 0 indicates little or no
 correlation. The p-values indicate the strength of evidence against the null hypothesis of zero correlation,
 with smaller p-values indicating stronger evidence against the null hypothesis.*/

/* Your data set */
data mydata;
  set online_shoppers1;
run;

/* Compute correlation matrix */
proc corr data=mydata outp=corr_matrix;
  var Administrative Administrative_Duration Informational Informational_Duration ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues SpecialDay Month OperatingSystems Browser Region TrafficType VisitorType Weekend Revenue Revenue_numeric;
run;

/* Find variables with correlation greater than 0.8 */
data corr_subset;
set online_shoppers1;
array corr{*} Administrative--TrafficType;
do i=1 to dim(corr);
    if corr[i] < 0.7 then corr[i] = .;
end;
drop i;
run;

proc print data=corr_subset;
run;

/* Plots */
proc sgplot data=online_shoppers;
  vbox PageValues / category=Month;
  title 'Box Plot of PageValues by Month';
run;

proc sgplot data=online_shoppers;
  vbar SpecialDay / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by SpecialDay';
run;

proc sgplot data=online_shoppers;
  vbar OperatingSystems / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by OperatingSystems';
run;

proc sgplot data=online_shoppers;
  vbar Region / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by Region';
run;

/* Bar chart of TrafficType */
proc sgplot data=online_shoppers;
  vbar TrafficType / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by TrafficType';
run;

/* Bar chart of VisitorType */
proc sgplot data=online_shoppers;
  vbar VisitorType / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by VisitorType';
run;

/* Bar chart of Weekend */
proc sgplot data=online_shoppers;
  vbar Weekend / response=PageValues stat=sum;
  title 'Bar Chart of PageValues by Weekend';
run;


/* Hypothesis testing */
proc reg data=online_shoppers1;
    model Revenue_numeric = PageValues;
run;
/*The table shows that the model has a significant effect (p < 0.0001), with an F-value of 3949.26. The 
adjusted R-squared value of 0.2426 indicates that the model explains about 24.26% of the variability in the 
response variable. The root mean square error (RMSE) of 0.31477 indicates the average distance between the 
predicted values and the actual values.

The parameter estimates table shows the intercept and slope of the regression line. The intercept value of 
0.09824 represents the estimated mean value of the response variable when the predictor variable is zero. The
 slope value of 0.00959 indicates that for every one-unit increase in the predictor variable, the response 
 variable is estimated to increase by 0.00959 units.

Both the intercept and slope estimates have small standard errors, indicating a high degree of precision in 
the estimation. The t-values for both variables are highly significant (p < 0.0001), indicating strong 
evidence that both variables have a significant linear relationship with the response variable.*/

/* Administrative: Higher values of this variable may be associated with users who are more interested in the administrative information about the website, such as contact details or terms of use. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Administrative;
run;
/*The ANOVA table shows that the model is significant (p < 0.0001), indicating that there is a significant 
relationship between Administrative and Revenue_numeric.

The parameter estimates table shows that the intercept is 0.11973, indicating that when Administrative is 0, 
the predicted Revenue_numeric is 0.11973.

The parameter estimate for Administrative is 0.01513, indicating that for every one unit increase in 
Administrative, the predicted Revenue_numeric increases by 0.01513.

The t-value of 15.58 and p-value of <0.0001 indicate that the parameter estimate for Administrative is 
statistically significant.

The R-squared value of 0.0193 indicates that Administrative explains 1.93% of the variation in 
Revenue_numeric, and the adjusted R-squared value of 0.0192 takes into account the number of predictor 
variables in the model.

*/
/* Administrative_Duration: Higher values of this variable may be associated with users who are spending more time on the website, which could indicate a higher level of engagement and interest in the content. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Administrative_Duration;
run;

/*The ANOVA table shows that the model is significant with an F-value of 108.93 and p-value less than 0.0001, 
indicating that the model explains a significant amount of the variance in the dependent variable.

The regression coefficient table shows that the intercept value is 0.13927, which is the predicted value 
of the dependent variable when the predictor variable is 0. The coefficient for "Administrative_Duration" is
 0.00019147, indicating that for every unit increase in "Administrative_Duration", the predicted value of the
 dependent variable increases by 0.00019147 units.

The standard error is 0.00001835, indicating the precision of the estimate of the regression coefficient. The 
t-value of 10.44 indicates that the coefficient is significantly different from 0 at the 0.05 level. The 
p-value of less than 0.0001 confirms that the effect of "Administrative_Duration" on the dependent variable 
is statistically significant.*/
/* Informational: Higher values of this variable may be associated with users who are more interested in the 
informational content on the website, such as articles or blog posts. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Informational;
run;
/*In this case, the p-value is less than 0.0001, which indicates strong evidence that the independent 
variable "Informational" is a significant predictor of "Revenue_numeric".

The parameter estimates section shows the estimated coefficients for the intercept and the independent 
variable "Informational", along with their standard errors, t-values, and associated p-values.

The intercept is 0.14109, which represents the predicted value of "Revenue_numeric" when the value of 
"Informational" is 0. The estimated coefficient for "Informational" is 0.02711, which indicates that a 
one-unit increase in "Informational" is associated with a 0.02711 increase in "Revenue_numeric". The standard
 error of this coefficient is 0.00255, and the t-value is 10.62, which indicates that the coefficient is 
 significantly different from zero.*/

/* Informational_Duration: Higher values of this variable may be associated with users who are spending more
 time engaging with the informational content on the website, which could indicate a higher level of interest
 and engagement. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Informational_Duration;
run;
/*
The analysis of variance (ANOVA) table shows that the model is statistically significant (p < 0.0001), 
indicating that there is a significant relationship between the predictor variable and the response variable.
 The F-value of 61.31 suggests that the model is a good fit for the data.

The parameter estimates table shows the estimated coefficients of the model. The intercept is estimated to be
 0.14851, which represents the predicted value of the response variable when the predictor variable is 0. The
 estimate for "Informational_Duration" is 0.00018076, which suggests that for every unit increase in the 
 predictor variable, the response variable is predicted to increase by 0.00018076 units. The standard error,
 t-value, and p-value are also shown for each coefficient, allowing for inference about the significance of 
 the predictor variable.
*/
/* ProductRelated: Higher values of this variable may be associated with users who are more interested in the
 products or services offered by the website, which could indicate a higher likelihood of making a purchase. */

proc reg data=online_shoppers1;
    model Revenue_numeric = ProductRelated;
run;

/* ProductRelated_Duration: Higher values of this variable may be associated with users who are spending more time engaging with the products or services offered by the website, which could indicate a higher likelihood of making a purchase. */

proc reg data=online_shoppers1;
    model Revenue_numeric = ProductRelated_Duration;
run;

/* BounceRates: Higher values of this variable may be associated with users who are leaving the website quickly, which could be a sign of poor user experience or uninteresting content. */

proc reg data=online_shoppers1;
    model Revenue_numeric = BounceRates;
run;

/* ExitRates: Higher values of this variable may be associated with users who are leaving the website quickly, which could be a sign of poor user experience or uninteresting content. */

proc reg data=online_shoppers1;
    model Revenue_numeric = ExitRates;
run;

/* SpecialDay: Higher values of this variable may be associated with users who are more likely to make purchases on special occasions such as holidays or festivals. */

proc reg data=online_shoppers1;
    model Revenue_numeric = SpecialDay;
run;

/* Month: Different months may have varying levels of user engagement, with certain months such as December having higher levels of user activity due to the holiday season. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Month;
run;

/* OperatingSystems: Different operating systems may have varying levels of compatibility with the website, which could impact user experience and engagement. */

proc reg data=online_shoppers1;
    model Revenue_numeric = OperatingSystems;
run;
/*The output shows the results of an analysis of variance (ANOVA) for a regression model with one predictor
 variable, "OperatingSystems," and one response variable. The ANOVA table shows that the model's F-value is
 2.65, which has a p-value of 0.1034, indicating that the model is not significant at the conventional level
 of 0.05. The root mean square error (RMSE) is 0.36165, and the R-squared value is 0.0002, indicating that
 only a small proportion of the variance in the response variable is explained by the predictor variable. The
 parameter estimate for the intercept is 0.16711, and the parameter estimate for the "OperatingSystems" 
 variable is -0.00582. The t-value for the "OperatingSystems" variable is -1.63, which has a p-value of 
 0.1034, indicating that the effect of this predictor on the response variable is not statistically 
 significant at the conventional level of 0.05.*/

/* Browser: Different browsers may have varying levels of compatibility with the website, which could impact user experience and engagement. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Browser;
run;
/*The first table shows the sources of variation, degrees of freedom (DF), sum of squares (SS), mean square 
(MS), F-value, and p-value (Pr > F). The model row shows the variation explained by the predictor variable, 
which is significant with an F-value of 7.10 and a p-value of 0.0077, indicating that the predictor variable
 significantly contributes to explaining the variation in the dependent variable. The error row shows the 
 unexplained variation. The corrected total row shows the total variation.

The second table shows the parameter estimates for the model, which includes the intercept (the predicted 
value of the dependent variable when the predictor variable is zero) and the effect of the predictor variable
 on the dependent variable. The DF, parameter estimate, standard error, t-value, and p-value (Pr > |t|) are 
 shown. The parameter estimate for the intercept is 0.14284, which is the predicted value of the dependent 
 variable when the browser is zero. The parameter estimate for the browser variable is 0.00505, which 
 indicates that for each unit increase in browser, the dependent variable increases by 0.00505, holding
 all other variables constant.

The root mean square (RMSE) is 0.36159, indicating that the typical difference between the predicted and 
actual values of the dependent variable is 0.36159. The R-squared value is 0.0006, indicating that the 
predictor variable explains only 0.06% of the variation in the dependent variable. The adjusted R-squared 
value is similar to R-squared, which suggests that there are no other predictor variables that need to be 
added to the model to better explain the variation in the dependent variable. Finally, the coefficient of 
variation (CV) is 233.66659%, which is the ratio of the standard deviation to the mean of the dependent 
variable expressed as a percentage, and indicates that the data has a large variation relative to the mean.

*/

/* Region: Different regions may have varying levels of user engagement, with certain regions having a higher concentration of the website's target audience. */

proc reg data=online_shoppers1;
    model Revenue_numeric = Region;
run;

/* Run Stepwise regression*/
proc reg data=online_shoppers1;
    model Revenue_numeric = Administrative Administrative_Duration Informational Informational_Duration ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues SpecialDay OperatingSystems Browser Region TrafficType / selection=stepwise;
run;

data online_shoppers3;
   set online_shoppers2;
   month_num = input(Month, monname3.);
   drop month;
run;
/*The table shows the order in which variables were added or removed from the model at each step, along with the number of variables included in the model, partial R-squared (the proportion of variation in the response variable explained by each predictor), and various model selection criteria such as adjusted R-squared, Cp, F value, and p-value.

At the first step, only the variable "PageValues" was included in the model and it explained 24.26% of the
 variation in the response variable. At each subsequent step, one variable was added to the model while 
 another variable was removed, and the R-squared increased slightly with each step. The final model included
 ten variables and explained 27.2% of the variation in the response variable.*/

/* Drop one variable from each correlated pair */
data online_shoppers2;
  set online_shoppers1;
  drop Administrative_Duration Informational Informational_Duration ProductRelated_Duration ExitRates;
run;


/* Use PROC TRANSPOSE to convert categorical variables into indicator variables */
proc transpose data=online_shoppers ;
  var Month OperatingSystems Browser Region TrafficType VisitorType Weekend;
run;

proc freq data=online_shoppers1;
   table Month / noprint out=month_freq;
run;

/* Print the unique values in "Month" column */
data _null_;
   set month_freq;
   put Month;
run;
data online_shoppers2;
	set online_shoppers1;
	if Month ='Aug'  then Month = 1;
	if Month ='Dec'  then Month = 2;
	if Month ='Feb'  then Month = 3;
	if Month ='Jul'  then Month = 4;
	if Month ='Jun'  then Month = 5;
	if Month ='Mar'  then Month = 6;
	if Month ='May'  then Month = 7;
	if Month ='Nov'  then Month = 8;
	if Month ='Oct'  then Month = 9;
	if Month ='Sep'  then Month = 10;
run;

/* Run logistic regression */
proc logistic data=online_shoppers3;
    model Revenue_numeric(event='1') = Administrative Administrative_Duration Informational Informational_Duration ProductRelated ProductRelated_Duration BounceRates ExitRates PageValues SpecialDay month_num OperatingSystems Browser Region TrafficType;
run;

/*Based on the output, we can see that PageValues and SpecialDay have the strongest association with 
Revenue_numeric. Specifically, a one-unit increase in PageValues is associated with an 8.3% increase in the
 odds of Revenue_numeric=1, while a one-unit increase in SpecialDay is associated with a 63.5% decrease in
 the odds of Revenue_numeric=1. Other predictor variables that are statistically significant (p < 0.05) 
 include ProductRelated, ProductRelated_Duration, ExitRates, month_num, and OperatingSystems.
 the intercept has a log odds ratio of -2.5684, which represents the log odds of the outcome variable when 
 all other predictor variables are at zero. The PageValues predictor variable has a log odds ratio of 0.0799,
 indicating that a one-unit increase in PageValues is associated with an increase in the odds of the outcome 
 variable. On the other hand, the BounceRates predictor variable has a log odds ratio of -3.0200, indicating 
 that a one-unit increase in BounceRates is associated with a decrease in the odds of the outcome variable.
 */

/*
OBSERVATION:
1. The logistic regression model is a good fit for predicting online shoppers' intention to make a purchase.

2. PageValues, SpecialDay, month_num, ExitRates, and OperatingSystems are significant predictors of online 
shoppers' intention.

3. Online shoppers are more likely to make a purchase if they have higher PageValues, if the website is accessed 
during a special day, if the website is accessed during a specific month, if the ExitRates are lower, and if
 they are using a specific operating system.

4. The significance of other predictor variables such as ProductRelated, BounceRates, and Browser cannot be 
ignored, but their effect on online shoppers' intention may not be as strong as the previously mentioned 
variables.

5. There may be some regional differences in the factors that influence online shoppers' intention, as Region
 was not found to be a significant predictor in this model.
 
6. The study found that several factors influence online shoppers' intention, including page values, special 
days, month, operating system, and browser. These factors should be taken into account by online retailers 
when designing and promoting their websites.

7. The study also found that bounce rates and exit rates do not have a significant impact on online shoppers'
 intention, suggesting that these metrics may not be as crucial to online success as previously thought.
 
Robustness checks:

One potential robustness check would be to include interaction terms between the predictor variables to
 capture potential nonlinear relationships between them.
Another robustness check would be to test for multicollinearity among the predictor variables and, if 
necessary, drop one or more variables to improve model performance.
A further robustness check would be to validate the model on an independent dataset to confirm its 
generalizability.

Actionable insights:

Based on the results, online retailers should prioritize improving the relevance and quality of the website's 
content, particularly product-related content, to increase the likelihood of purchase.
Reducing the bounce rate by improving the website's usability and relevance to visitors could significantly
 increase conversion rates.
Online retailers should also consider offering special promotions or discounts on days with 
higher-than-average bounce rates, such as holidays or weekends.

Limitations:

The dataset is limited to visitors to a single website and may not be representative of the broader
 population of online shoppers.
The model assumes that the relationship between the predictor variables and the outcome variable is
 linear and may not capture potential nonlinear relationships.
The model is based solely on observable variables and does not account for unobservable factors that may
 also influence visitors' purchase intentions.

*/

proc print data=online_shoppers(OBS=10);run;
proc print data=online_shoppers1(OBS=10);run;
proc print data=online_shoppers3(OBS=10);run;