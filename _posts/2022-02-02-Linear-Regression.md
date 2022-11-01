---
title: Linear Regression 
subtitle: by Karan Desai
date: 2022-02-02 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Karan Desai
categories: ml
---


# Linear Regression

<p align='center'>
<img src="/images/Posts/Linear_Regression/img0.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:370px;width:800px" />
</p>

<p align='center'>
Figure 1. 
<a href='https://sdsclub.com/anatomy-of-loss-functions-questions-and-answers/'>
Lets Begin</a>
</p>

#### 1. What is Linear Regression?
Linear regression is a basic and commonly used type of predictive analysis.  The overall idea of regression is to examine two things:
1. Does a set of predictor variables do a good job in predicting an outcome (dependent) variable?
2. Which variables in particular are significant predictors of the outcome variable, and in what way do they–indicated by the magnitude and sign of the beta estimates–impact the outcome variable. 


<p align='center'>
<img src="/images/Posts/Linear_Regression/img1.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:400px;width:500px" />
</p>

<p align='center'>
Figure 2. 
<a href='https://memegenerator.net/Conspiracy-Keanu'>
Confusion</a>
</p>

<br/>
In simpler terms....


Linear Regression is the Supervised Machine Learning model in which the model finds the best fit linear line between the independent and dependent variable i.e it finds the linear relationship between the dependent and independent variable.

For example, say we have housing data with columns  - “# of bedrooms”, “area sq ft”, “location”, “furnished”, “price”. Here we would be interested in knowing the price of the house given the rest of the features. The features can be continuous - “area sq ft”, discrete - “# of bedrooms” or even boolean - “furnished”. 

We just need to make sure that the features are converted to numeric values. Once the preprocessing is done, we train the model to find a linear relationship between the rest of features and the price. This linear relationship is called Linear Regression. In other terms, “best fit”, something like...

<p align='center'>
<img src="/images/Posts/Linear_Regression/img2.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:400px;width:500px" />
</p>

<p align='center'>
Figure 3. 
<a href='https://commons.wikimedia.org/wiki/File:Normdist_regression.png'>
Linear Regression</a>
</p>

<br/>


#### 2. How do we find the relation?<br/>
We find this relation using the equation:

<p align='center'>
<img src="/images/Posts/Linear_Regression/img3.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:100px;width:400px" />
</p>

<p align='center'>
Figure 4. 
<a href='https://www.kdnuggets.com/2020/10/guide-linear-regression-models.html'>
Linear Regression Equation</a>
</p>

It's a good idea to be familiar with a few terms like…

#### Independent Variable/Target variable:
Is the variable that we want to predict Eg. Price.
<br/><br/>

#### Dependent Variable/Input: 
The variables used to predict the value of the output variable Eg. # of bedrooms, area sq ft, location, furnished.
<br/><br/>
#### β0/Intercept: 
Point where the estimated regression line crosses the y-axis.
<br/><br/>
#### β1: 
Slope of the regression line.
<br/><br/>
#### Error:
The random component of the linear relationship between the dependent and independent variables OR 
the disturbance of the model, the part of y that X is unable to explain. 
<br/><br/>



For the data we are using, the equation will look something similar to:<br/>
<em>**y = β0 +  β1.#_of_bedrooms  + β2.area_sq_ft + β3.location  + β4.furnished + E**<em>

Finding the values of these constants (β1, β2, β3, β4) is what a regression model does by minimizing the error function and fitting the best line.
    
### 3. Cost Function<br/>

We can very well have multiple lines for different values of slopes and intercepts. But the main question that arises is which of those lines actually represents the best relationship between the dependent and target variables.
By achieving the best-fit regression line, the model aims to predict y value such that the error difference between predicted value and true value is minimum. So, it is very important to update the β1 values, to reach the best value that minimize the error between predicted y value (pred) and true y value (y). In other words we need to find the best values for β1, β2, β3, β4 for wich we use a Cost Function. <br><br>
One of the Cost function(J) of Linear Regression is the Root Mean Squared Error (RMSE)

<p align='center'>
<img src="/images/Posts/Linear_Regression/img4.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:100px;width:300px" />
</p>

<p align='center'>
Figure 5. 
<a href='https://www.geeksforgeeks.org/ml-linear-regression/'>
Cost Function</a>
</p>
    
For more info on Cost Functions you can refer [this](https://www.simplilearn.com/tutorials/machine-learning-tutorial/cost-function-in-machine-learning#:~:text=For%20the%20Linear%20regression%20model,minimum%20of%20these%20error%20values) link.
:<br>

### 4. Assumptions of LR
    
There are some assumptions we need to consider while applying Linear Regression on any dataset:


**1. Linearity**: <br>
    Linearity means that a linear relationship already exists between Dependent Variables and Target Variable.<br>
    We just need to find that relaionship.<br><br>
    
    
**2. Independence**:<br>
    Independence means that there is no relation between the data points i.e row #3 is independent of row #10.<br>
    All observations are independent of each other.<br><br>
    
**3. Homoscedasticity**:<br>
    Homoscedasticity in a model means that the error is constant along the values of the dependent variable.<br><br>

    
**4. Normality**: <br>
    For any fixed value of X, Y is normally distributed.<br>
    X = Dependent Variable<br>
    Y = Target Variable
    
 
 
 <br/>

References:<br/>

1. https://www.kdnuggets.com/2020/10/guide-linear-regression-models.htm<br/>
2. https://www.analyticsvidhya.com/blog/2021/03/data-science-101-introduction-to-cost-function/<br>
3. https://towardsdatascience.com/assumptions-of-linear-regression-fdb71ebeaa8b<br/>