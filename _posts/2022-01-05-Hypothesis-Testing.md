---
title: Hypothesis Testing and When to Use
subtitle: by Sachini Weerasekara
date: 2022-12-07 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Sachini Weerasekara
categories: math
---

# Hypothesis Testing
This read will cover what hypothesis testing is, and when and how to use it in your data science project...

## Contents
1. [What is hypothesis testing](#hy_test)
2. [Performing hypothesis testing in machine learning](#performing)
3. [Steps in hypothesis testing](#steps_in_ht)
4. [Possible errors while performing hypothesis testing](#possible_errors)
<br>

## 1. What is hypothesis testing <a name="hy_test"></a>

Any data science project starts with exploring a set of sample data through exploratory data analysis and inferal statistics. Then we want to use these observations to draw inferences about the entire population. 


<img src="/images/Posts/Hypothesis_Testing/figure1.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:350px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure 1: Using samples to make inferences about the population
   </a>
</p>

<br>

Hypothesis testing is used to determine if in the known sample, we have enough statistical evidence to draw conclusions about the population, within a desied error limit. 

<br>

## 2. Performing hypothesis testing in your machine learning <a name="performing"></a>

Hypothesis testing comes after data pre-processing and model building steps. We use hypothesis testing to build confidence in the machine learning model by making sure the model makes significantly correct predictions of the population. 

<img src="/images/Posts/Hypothesis_Testing/figure2.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:300px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure 2: Steps in any ML project and when to perform hypothesis testing
   </a>
</p>

<br>

For instance, let's take a linear regression model where we formulate the intercept and the beta coefficients. Everytime we build the model, we check if the model is significant by performing hypothesis testing on the parameters to make sure they are significant. 

<br>

### 3. Steps in hypothesis testing <a name="steps_in_ht"></a>
1) Formulate the hypothesis
There are two hypothesis that should be formulated.

Null hypothesis: $H_0:$ The initial claim based on the sample. Eg: The model is not significant.
Alternative hypothesis: $H_1:$ This is the counter argument to $H_1$. Usually we want to prove this is true. 

<br>

2) Determine the significance level

<img src="/images/Posts/Hypothesis_Testing/figure3.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:350px;width:600px"/>     
<p align='center'>
   <a href='https://medium.com/@saima.sayyed/what-is-the-significance-level-confidence-level-and-p-value-and-how-are-they-related-to-692e8b2dbf4d'>
      Figure 3: Critical region and confidence interval
   </a>
</p>

<br>

Significant level refers to the proportion of the sample laying in the rejection region and the confidence level refers to the proportion laying in the acceptance region. In Figure 3, the significane level is 5% i.e., $\alpha$=5%.

If P-value $\leq$ $\alpha$ ; Reject $H_0$
If P-value $>$ $\alpha$ ; Fail to reject $H_0$

<br>

3) Determine the type of the test

| Dataset attributes | Type of the predictor variable | Predictor variable distribution | Desired test | 
|--|--|--|--|
| Sample size $\geq$ 30, $\sigma$ known | Quantitative | Normal dist. | Z-test |
|Sample size $<$ 30, $\sigma$ unknown |Quantitative| T dist./ Normal dist. | T-test 
| Compare 3 or more variables | Quantitative | Positively skewed | F-test
| Test for independance, goodness of fit , test for homogeneity | Categorical | NA | Chi-squared test

<br>

4) Calculate test statistic values and P-values
  

<img src="/images/Posts/Hypothesis_Testing/figure4.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:230px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure 4: Test statistics of Z-test, T-test, F-test, and chi-squared test
   </a>
</p>

<br>

    
When we need to compare the means of two samples, we can use two sample tests.

<br>

5) Decision making
Next we find the P-value associated with the test statistic. P-value is a measure of how strong the evidence is in favour of the null hypothesis. If the P-value $\leq$ $\alpha$ there is enough evidence to reject $H_0$ and if the P-value $>$ 0, there is no sufficient evidence to reject $H_0$. 

<br>

### 4. Possible errors while performing hypothesis testing <a name="possible_errors"></a>

<img src="/images/Posts/Hypothesis_Testing/figure5.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:100px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure 5: Possible errors in hypothesis testing: type I error and type II error
   </a>
</p>

<br>

 
Type I error: Happens when the null hypothesis is true but we reject it. The level of significance: $\alpha$ is the probability of type I error. 

Type II error:  Happens when the null hypothesis is false but we fail to reject it. The probability of type II error is commonly denoted (in Figure 6) as $\beta$. 

<img src="/images/Posts/Hypothesis_Testing/figure6.jpg"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:350px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure 6: Probabilities of type I and type II errors
   </a>
</p>

