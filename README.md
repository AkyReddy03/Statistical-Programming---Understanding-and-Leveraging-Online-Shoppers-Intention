# Understanding-and-Leveraging-Statistical-Programming-Online-Shoppers-Intention
Introduction
--------------------------------------------------------------------------------
With the increasing trend of online shopping, it is important to understand the factors that influence shoppers' intention to make a purchase online. In this presentation, we will analyze a dataset that contains information on online shopping sessions and explore the factors that influence shoppers' intention to make a purchase.
  Data Set and Its Relevance
This dataset contains feature vectors from 12,330 online shopping sessions, with 10 numerical and 8 categorical attributes like the number of page categories visited and time spent on each. It can be used to determine whether a purchase was made and provides valuable insights into factors influencing online purchase behavior.

Online Shoppers' Behavior
---------------------------------------------------------------------------------
Based on the Data
85.6% of visitors were returning, 13.7% were new, and 0.7% were other.
Average amount spent per purchase: The average revenue per transaction was $80. The median revenue per transaction was $53.
"ProductCategory3" was most popular (35.6%), followed by "ProductCategory1" (31.6%) and
 "ProductCategory2" (32.8%).
To Help Visualize the Data
A pie chart showing the distribution of VisitorType in the sample
A histogram showing the distribution of Revenue per transaction in the sample
A bar chart showing the percentage of transactions in each ProductCategory
Data suggests that returning visitors are more likely to make a purchase and most revenue comes from a few product categories. Website owners should target returning visitors with promotions or personalized content and focus on promoting popular product categories to increase revenue. Chi-square tests show significant differences in Revenue across VisitorType, Region, and Month, with returning visitors being more likely to make a purchase and highest Revenue in May.

Observations
----------------------------------------------------------------------------------
The results suggest that there are significant differences between the means of the three visitor types. Specifically, the means of New_Visitor and Returning_Visitor differ significantly from each other, as indicated by the "***" notation. Additionally, the means of Other and Returning_Visitor are not significantly different from each other, but the means of New_Visitor and Other are significantly different from each other.
The confidence intervals provided for each comparison indicate the range within which the true difference between the means is likely to fall with 95% confidence. For example, for the comparison between New_Visitor and Other, the confidence interval is (-0.154600, 0.032842), which means that the true difference between the means is likely to be somewhere within that range with 95% confidence.


Factors Influencing Online Shopping Intention
------------------------------------------------------------------------------------------
Presenting the results of the regression analysis on the factors influencing online shopping intention
Explaining the significance of each variable and its impact on online shopping intention
Observation:
1. The logistic regression model is a good fit for predicting online shoppers' intention to make a purchase.
2. PageValues, SpecialDay, month_num, ExitRates, and OperatingSystems are significant predictors of online
Shoppers' Intention:
Online shoppers are more likely to make a purchase if they have higher PageValues, access the website on a special day or specific month, have lower ExitRates, and use a particular operating system. Other predictor variables such as ProductRelated, BounceRates, and Browser may also affect shoppers' intentions but are not as strong as other variables.
When Designing and Promoting Their Websites
According to the output, while bounce and exit rates are not major factors in online shoppers' intention to buy, page values, product-related information, duration, browser, operating systems, and special days do predict intention. Online retailers should prioritize improving the relevance and quality of content, as well as reducing the bounce rate and offering special promotions on days with higher bounce rates.


