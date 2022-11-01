---
title: Linear Regression Limitations - part 2
subtitle: by Yanming Liu 
date: 2022-02-05 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Yanming Liu
categories: ml
---



## Table of contents

1. Linear Regression (LR)
2. LR Assumes Linear Relationship Between Features And Target
3. Features Should be Independent
4. Prone to Outliers 
5. Summary


## 1. Linear Regression (LR)

Linear regression is a simple, but efficient approach when you start to learn supervised learning with the goal of predicting the relationship between the features and target. 
Suppose that we have a dataset $D={(X_1, Y_1), (X_2, Y_2), \ldots, (X_n, Y_n)}$, where $x_i \in R^{1}$ for simplicity. The idea is to use an linear equation, $\hat{Y_i} = b_0 + b_1X_i$, 
to approximate the real target value, $Y_i$.

Moreover, $b_0, b_1$ should be calculated using the [Least Square Method](https://en.wikipedia.org/wiki/Least_squares). In the method, we get the sum of square of differences 
between target and the predicted one, $J(b_0, b_1) = \sum_{i=1}^{n}(e_i)^2, e_i = Y_i - \hat{Y_i}$, then we solve $b_0, b_0$ by letting the derivative of $J$ with respect to $b_i$ equal to $0$. 
Instead of using this close-form solution, [Gradient Descent](https://www.youtube.com/watch?v=yFPLyDwVifc) would be another option to get those parameters.

Want more? check [Math Details Behind LR](https://zhuanlan.zhihu.com/p/25434586).
Ex 1. Figure out the strengths and weaknesses of the closed-form method and Gradient Descent, and determine under which condition you may apply what.

<p align='center'>
<a href='https://medium.com/@manojgupta_rch/linear-regression-performance-evaluation-matrices-simplified-1126915a0243'>
<img src="/images/Posts/Linear_Regression_Limitations_2/lr.JPG"></a>
Figure 1. <a href='https://medium.com/@manojgupta_rch/linear-regression-performance-evaluation-matrices-simplified-1126915a0243'>
Linear Regression</a>
</p>

Now, let us start to illustrate the limitations of this method.

## 2. Linear-Relationship between Features and Target

**The biggest problem is the model can not handle non-linearity for the regression tasks. Here are two examples.**

- One team explores the relationship between weight and age for students. Normally, students will grow weight along with age, then reach a plain and last a similar weight for several years, then decrease when they become old. Can linear regression display such a trend successfully? Of course not. As a consequence, finding the approximate model to suit your data is an essential part of a promising classification/regression result. 
- See the exponential data in the below image, we never can find an accurate linear line to represent 
those points, for their non-linearity nature.

If you still want to use linear regression in the task with exponential data, $$ Users = e^{a * Time} $$, what can you do? Think the following steps, let $Y=log_{e}{Users},
Y = a*Time$. Now, we have a linear relationship between $Time$ and $Y$, go ahead for solving the parameter $a$. This tells us that you can apply some math transformation following your intuition or domain knowledge, 
letting non-linearity into linearity sometimes.  

<p align='center'>
<a href='http://sam-koblenski.blogspot.com/2014/10/everyday-statistics-for-programmers_21.html'>
<img src="/images/Posts/Linear_Regression_Limitations_2/non-linear.png" width='480' height='300' /></a>
Figure 2: <a href='http://sam-koblenski.blogspot.com/2014/10/everyday-statistics-for-programmers_21.html'>
Non-linearity Between Features and Target</a>
</p>

## 3. Features Should be Independent

**If features are correlated, it does harm the performance of our linear model.** Different metrics will mark this relationship of features for various data type. To remove the demage, We may apply some data reduction techniques to confirm the independence among features.

For those features with the data type of numeric, we calculate
**[Pearson Correlation Coefficient](https://www.wallstreetmojo.com/pearson-correlation-coefficient/)** among variables to see if it is related. For example, researchers develop a model to predict the clinician ranking based on seven standard metrics as the label of the heatmap shows. 
Values in the graph represent correlation coefficients. The larger/deeper the value/color is, the more related these two features are. We can clearly see that VLow is closely related to CV and Low as coefficients are 0.74 and 0.75, 
respectively.

For independent comparison among categorical feature, **Chi-Square Test** are conducted. See [a hand-on example](http://sites.utexas.edu/sos/guided/inferential/categorical/chi2/) and know how to [implement &
visualize the Chi-Square Test](https://www.analyticsvidhya.com/blog/2021/06/decoding-the-chi-square-test%e2%80%8a-%e2%80%8ause-along-with-implementation-and-visualization/). 

For those higher correlated features, we may just 
use either of them as the input for our model building instead of all of them to remove the potential hazard on performance. **You can remove them by hand or use lasso regression in an automatic way.**

<p align='center'>
<a href='https://www.hopkinsmedicine.org/endocrinology_diabetes_metabolism/_documents/glycemia-risk-index-article.pdf'>
<img src="/images/Posts/Linear_Regression_Limitations_2/corr.JPG" width='400' height='400'/></a>
Figure 3: <a href='https://www.hopkinsmedicine.org/endocrinology_diabetes_metabolism/_documents/glycemia-risk-index-article.pdf'>
Correlation Between Pairs of Metrics</a>
</p>

## 4. Prone to Outliers 

**Outlier has an impact on our linear regression model.** Outlier are those extreme values far away from the mean value. By **removing outliers** of the data points, we achieve a better approximate line for all data as the graph illustrates. 

Similarly, a robust model equation integrating with the **regularization**
will offset the damage that those outliers bring to the performance. [L-1 regularization is robust against outliers](https://datascience.stackexchange.com/questions/63900/how-regularization-helps-to-get-rid-of-outliers) as it uses the absolute value between the estimated outlier and the penalization term. 
<u>Ex 2. Think why this would work? </u> No idea about regurlarization? Find the [intuitive understanding
for regularization](https://charlesliuyx.github.io/2017/10/03/%E3%80%90%E7%9B%B4%E8%A7%82%E8%AF%A6%E8%A7%A3%E3%80%91%E4%BB%80%E4%B9%88%E6%98%AF%E6%AD%A3%E5%88%99%E5%8C%96/) here. 

To find those outliers, statistic summary, scatter plots(numeric), boxplots(categorical) can be 
conducted for a intuitive visualization. Then, two criterias such as Z-scores or IQR are used to
detect those outliers quantitively. Finally, domain knowledge or statistical extraction will be 
employed for handling outliers. See section 3 in this Jupyter Notebook for [detection & handle of outliers](https://colab.research.google.com/drive/1MvH8etxr6MqnAiqRjvoPp_w-5Ri9FRIm#scrollTo=JAsUO94rU2AFprepr).



<p align='center'>
<a href='http://www.turingfinance.com/regression-analysis-using-python-statsmodels-and-quandl/'>
<img src="/images/Posts/Linear_Regression_Limitations_2/outlier.png" /></a>
Figure 4.<a href='http://www.turingfinance.com/regression-analysis-using-python-statsmodels-and-quandl/'> Regression Performance Under Existing or Removed Outlier
 </a>
</p>


## 5. Summary
In this chapter, we review linear regression for its formula, and how to solve them in two ways, close-form solution, and Gradient Descent. Then we introduce three major limitations for linear regression and point out the potential
ways to avoid them whether in data processing or model robustness if you stick to this method. 

Before we leave, 
- Summarize the key point in each paragraph for logistics. 
- Solve Ex 1-2 for those who are interested. 
- Always feel free to read more online to gain a super understanding of the limitations of linear regression. 