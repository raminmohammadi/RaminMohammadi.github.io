---
title: Lasso, Ridge, and Robust Regression 
subtitle: by Keerthi Godha
date: 2022-02-08 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: Keerthi Godha
categories: ml
---


# Lasso, Ridge, and Robust Regression

### Table of contents
1. [Introduction to Regression](#regression)<br>
2. [Robust Regression](#robust_regression) <br>
3. [What is Overfitting](#overfitting)<br>
4. [Regularization and types of Regularization](#regularization)<br>
    4.1 [Lasso Regression](#lasso_regression)<br>
    4.2 [Ridge Regression](#ridge_regression)<br>

## 1. Regression <a name="regression"></a>
    
   ***Regression*** is a predictive modeling technique in machine learning, which predicts continuous outcomes by investigating the relationship between independent/input variables and a dependent variable/output.

              
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/Regression.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:250px"/>
</p>
<p align='center'>
Figure 1. <a href='https://medium.com/swlh/classical-machine-learning-7efc6674fca1'>
Regression </a>
</p>
        
Linear regression finds the best line (or hyperplane) that best describes the linear relationship between the input variable (X) and the target variable (y). Robust, Lasso, and Ridge regressions are part of the Linear Regression family, where input parameters and output parameters are assumed to have a Linear relationship. <br>

#### Linear Regression is a good practice for the below scenarios.

- Linear Regression performs well when the dataset is linearly separable. It is used to find the nature of the relationship between the input and output variables.
- Linear Regression is easier to implement, and interpret and very efficient to train. 


#### Problems with Linear Regression.
- Linear Regression is limited to datasets having Linear Relationships.
- Linear Regression is Sensitive to Outliers.
- Linear Regression is prone to noise and overfitting.
- Linear Regression assumes that the input variables are independent of each other, hence any multicollinearity must be removed.<br>
<br>

##### Let's see the first problem of Linear Regression, ***which is Outliers.***
As the data may contain outliers in real-world cases, the model fitting can be biased. Robust regression aims at overcoming this problem. 

## 2. Robust Regression <a name="robust_regression"></a>
Robust regression is an alternative approach to ordinary linear regression when the data contains outliers. It provides much better regression coefficient estimates when outliers are present in the data. 

Let's recall the Loss function of Linear Regression, which is Mean Square Error (MSE) i.e Norm 2. It increases sharply with the size of the residual.<br>**Residual:** The difference between the predicted value and the actual value.<br>

<font size="3">  $$   J(θ) = \frac{1}{n} \displaystyle\sum_{i=1}^n(y - ŷ)^2  $$<br></font>
    
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/Norm 2.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:300px"/>
Figure 2. Norm 2 
</p>
<p align='center'>
Figure 2. Norm 2 
</p>

The problem with MSE is that it is highly sensitive toward large errors compared to small ones(i.e outliers). So, the alternative is to use the sum of the absolute value of residuals as a loss function instead of squaring the residual, i.e Norm 1. ***This achieves robustness.*** However, it is hard to work with in practice because the absolute value function is not differentiable at 0.<br>
    
<font size="3">  $$ J(θ) = \frac{1}{n}\displaystyle\sum_{i=1}^n|y - ŷ|$$<br>  </font>

<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/Norm 1.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:300px"/>
</p>
<p align='center'>
Figure 3. Norm 1
</p>

**Huber loss** solves this problem. It preserves the differentiability of a function like Norm 2 and is insensitive to outliers like Norm 1.
Huber loss is a combination of L2 and L1 functions, it looks like as below.<br>
    
    
    
<font size="3"> $$ \begin{aligned} 
         J(θ) & = 
         \begin{cases}
             \frac{1}{2}e^2  & \text{where}\space ,  \space \text{e ≤ 𝜹}\\
             (𝜹|e| - \frac{𝜹^2}{2}) \space  & \text{where}\space , \space \text{e > 𝜹} \\
         \end{cases}\\[3pt]
          \label{equ:yannibel}
       \end{aligned} 
       $$ 
       </font>
 <br>        

<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/Huber Loss.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:300px"/>
 
</p>
<p align='center'>
Figure 4. Huber Loss
</p>

#### Working of Robust Regression:
Robust regression is also called ***Random Sample Consensus (RANSAC)***. It tries to separate data into outliers and inliers and it then fits the model only on the inliers. It calculates the errors (i.e. residuals) between all points and the model (i.e linear line). Points whose error is less than a predefined threshold are classified as inliers and the rest are classified as outliers.<br>
<br>

##### Let's see the second problem of Linear Regression, ***which is Overfitting.***
What is Overfitting, and how is it related to Lasso and Ridge Regression?

## 3. Overfitting <a name="overfitting"></a>
Overfitting occurs when the model performs well on the training data but not so well on unseen/test data. This happens when the model learns the data as well as the noise in the training set.


              
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/overfitting.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:350px"/>
</p>
<p align='center'>
Figure 5. <a href='https://satishgunjal.com/underfitting_overfitting/'>
Overfitting </a>
</p>
       
In the above image, ***black line*** tries to learn the pattern of the data points by finding the relationship between input and target variables. However, the ***blue curve*** memorizes the pattern. In this way, the model won’t be able to adapt to new data as it’s too focused on the training data.

***Overfitting*** is observed in the below scenarios.
1.  When we increase the degree of freedom (increasing polynomials in the equation) for regression models, they tend to overfit.
2.  When the model is biased towards any specific features, the model assigns large coefficients/weights to respective features.
3.  The number of predictor variables(p) in a given set exceeds the number of observations(n) (so-called p >> n problems).
<br> 
<br>

##### Now the Regularization comes into the picture. Regularization is required whenever there is overfitting.

## 4. Regularization <a name="regularization"></a>
***Regularization*** prevents the model from overfitting the data by adding extra information to it **(which is a penalty)**, especially when there is a large variance between train and test set performances.

              
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/Overfit to Good fit.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:700px"/>

</p>
<p align='center'>
Figure 6. <a href='https://www.simplilearn.com/tutorials/machine-learning-tutorial/regularization-in-machine-learning'>
Regularization </a>
</p>

Let’s take the below Linear equation.<br>
$X_1$, $X_2$ …. $X_n$ are input variables, $Y$ represents the dependent/target variable.<br>

 <font size="3">$$Y  =  θ_0 + θ_1X_1 + θ_2X_2 + . . . . . . + θ_nX_n $$ </font> 
 

$θ_0$ is a Bias term and $θ_0$, $θ_1$, $θ_2$ $. . . .$ $θ_n$ represents the coefficients/weights estimates of dependent variables $X_1$, $X_2$ $. . . .$ $X_n$ respectively.
                                   
Below is the hypothesis, which gives the relationship between input variables and the target variable.<br>

 
<font size="3"> $$ \begin{aligned} 
         y = h_θ(x_i) & =  θ_0 + θ_1x_1 + θ_2x_2 + . . . . . . + θ_nx_n \\ 
                  & = θ_0x_0 + θ_1x_1 + θ_2x_2 + . . . . . . + θ_nx_n, \space \space  where \space  x_0 =1 \\
                  & = \displaystyle\sum_{i=1}^n θ_ix_i \\
                  & = θ^Tx \\
\end{aligned} $$ </font> 
 
 
        
The model fitting involves a cost/loss function known as the sum of squares, which is the sum of the squared differences between the actual Y value and predicted value using the defined hypothesis.<br>

<font size="4"> $$L(θ) = \displaystyle\sum_{i=1}^n (y_i -h_θ(x_i))^2 $$ </font>

The minimum value of the cost function represents the relationship between X and Y in the best possible manner. So,  ***our goal is to reduce the cost function (i.e error difference) using best weights by adjusting the regularization factor.***
<br>

**There are 2 types of regularization.**<br>
1. Lasso Regularization
2. Ridge Regularizations

## 4.1 Lasso Regression <a name="lasso_regression"></a>
The full form of LASSO is ***‘Least Absolute Shrinkage and Selection Operation’.*** 
It is a type of Linear Regression/Prediction method that performs both Variable selection and regularization to enhance the prediction accuracy by penalizing the model for the sum of absolute values of the weights.<br><br>
Lasso Regression uses ***L1 regularization technique***. This technique is used in feature selection using a Shrinkage method. ***The penalty term in Lasso regression is equal to the absolute value of the magnitude of the coefficient.***<br><br>

##### Why don't we directly add model parameters as a penalty? 
Because, our model parameters can be negative, adding them might decrease our loss instead of increasing it. To circumvent this, we can either take their absolute values(Lasso) or square our model parameters(Ridge).

  <font size="4"> $$ L1 = ║θ║_1 = \displaystyle\sum_{i=1}^n ┃θ_i┃$$ </font>

### Working of Lasso Regression:
In Linear Regression, during the training phase, if the model feels like any specific features are particularly important, the model may place a large weight on those features (i.e assigns large coefficient values). The model is not penalized for its choice of weights, at all. This sometimes leads to overfitting in small datasets.
Hence, to avoid overfitting Lasso and Ridge regressions are used.<br>

### L1 Regularization:
L1 regularization adds a penalty term to the loss function, which is the sum of absolute values of the magnitude of the coefficient. The job of L1 regularization is to minimize the size of all coefficients and allows some coefficients to be minimized to zero, which removes a few input predictors from the model. <br>

    
  <font size="4"> $$ L(θ) =  \displaystyle\sum_{i=1}^n (y_i-h_θ(x_i))^2 + λ \displaystyle\sum_{i=1}^n 
  ┃θ_i┃$$ </font>
  
It forces to get weights from the shape of Norm 1, as shown below.<br>
       
              
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/L1 Shape.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:450px;width:380px"/>
</p>
<p align='center'>
Figure 7. <a href='https://www.datacamp.com/tutorial/tutorial-lasso-ridge-regression'>
Lasso Regression Shape </a>
</p>

**Least Absolute Shrinkage in Lasso is:** The coefficients determined in the linear regression are shrunk towards the central point as the mean by introducing a penalty.<br>
- Lambda (λ) is the penalty term that denotes the amount of shrinkage.<br>
- Lambda (λ) can get values between 0 to ∞
<br>

**Selection Operation in Lasso is:**  The shrinkage of these coefficients based on the λ value provided leads to some form of automatic feature selection. As the λ value increases, coefficients decrease and eventually ***become zero***. This way, lasso regression provides a type of automatic feature selection by eliminating insignificant input variables from the model, which do not contribute much to the prediction task.<br>

Still confused? 😕  Let’s take a simple Regression example of price prediction for better understanding.<br>
      


- X represents the age of the house, and Y represents the price. Below is what the data looks like.<br>

              
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/ex picture 1.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:300px;width:450px"/> <br>
</p>
<p align='center'>
Figure 8. <a href='https://machinelearningcompass.com/machine_learning_models/elastic_net_regression/'>
Lasso Shape </a>
</p>
        
- Then split the dataset into train and test sets and train the model using linear regression with the training set.<br>
- ***Blue circles*** represent training set data, ***green circles*** represent test data, and the ***blue line*** represents the relationship between input variable age and target variable Price.<br>
- The below graph clearly shows that the linear line passed through all the training data with very minimal training error. However, the same line resulted in errors **e1** and **e2** in the case of test data.<br>


<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/ex picture 2.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:300px;width:450px"/> <br>
</p>
<p align='center'>
Figure 9. <a href='https://machinelearningcompass.com/machine_learning_models/elastic_net_regression/'>
Lasso Shape </a>
</p>       
        
- This clearly shows that our model is overfitting with training data. Coming up with another linear line (yellow line) tends to overfit less and performs well on test data with less error, shown as below graph. <br>
<br>
      

<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/ex picture 3.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:300px;width:450px"/><br>
</p>
<p align='center'>
Figure 10. <a href='https://machinelearningcompass.com/machine_learning_models/elastic_net_regression/'>
Lasso Shape </a>
</p>              

Let’s say the main cause behind overfitting is large coefficients/weights (i.e. θ values) corresponding to input variables, the goal now is to reduce these weights.<br>

***Let’s extend the same example:*** We want to predict the price of a house based on the age of the house, Sq.ft, #No. of. Rooms, Neighborhood, and #Avg Temperature. <br>

As per the hypothesis,

$$ Price (y_{pred}) = \theta_0 + θ_1 * Age + θ_2 * Sq.ft + θ_3 * \#No. of. Rooms + θ_4 * Neighborhood + θ_5* Avg \; Temperature $$

From the above hypothesis, the age of the house, Sq.ft, and #No. of. Rooms are the most relevant features. However, the Neighborhood is less relevant, and the average temperature might be irrelevant to derive the price of the house.<br>

Remember, I mentioned in working on lasso Regression that during the training phase if the model feels like any specific features are particularly important, the model may place a large weight on those features, which causes overfitting.<br>


#### In Lasso Regression,
**Equal importance is given to all features during Feature selection**

Consider the weights/coefficients corresponding to 5 input features as below.<br>
This is just an example.<br>

$$ θ  = [θ_0, θ_1 , θ_2 , θ_3 , θ_4 , θ_5] \\
   θ  = [5, 10, 8, 6, 4, 2] $$ 

$$ \begin{aligned} 
        Lasso  \space / \space L1 \space  penalty & =   \space |θ_0+θ_1+θ_2+θ_3+θ_4+θ_5| \\ 
                &  =\space |5| + |10| + |8| + |6| + |4| + |2| = 35 \\
\end{aligned} $$
<br>
      
If we shrink each parameter by 1, The penalty looks like the below. <br>
$$ \begin{aligned} 
        θ_0 & \space => \space   |4| + |10| + |8| + |6| + |4| + |2| = 34 \\
        age \space of \space the \space house & \space => \space   |5| + |9| + |8| + |6| + |4| + |2| = 34  \\ 
              Sq.ft  & \space => \space |5| + |10| + |7| + |6| + |4| + |2| = 34\\
              No. of. Rooms  & \space => \space |5| + |10| + |8| + |5| + |4| + |2| = 34\\
              Neighborhood  & \space => \space |5| + |10| + |8| + |6| + |3| + |2| = 34\\
              Avg \space Temp  & \space => \space |5| + |10| + |8| + |6| + |4| + |1| = 34\\
\end{aligned} $$
<br>

<br>
This means that, by reducing each parameter by one, ***our penalty is reduced from 35 to 34***.
**Since the lasso penalty consists of the absolute model parameters, large values are not considered more strongly than smaller values.** This means that the lasso penalty gives the same importance to all parameters, it would not prioritize minimizing any particular model parameter, unlike the ridge penalty, which prioritizes large parameters.<br>
<br>

**Feature Selection in Lasso Regression:**
Trying to minimize the cost function, Lasso regression will automatically select those features that are useful and discards the useless or redundant features.
As the λ value increases, coefficients decrease and eventually ***become zero***. This way, lasso regression eliminates insignificant variables from our model.  


  <font size="3"> $$ L(θ) =  \displaystyle\sum_{i=1}^n (y_i-h_θ(x_i))^2 + λ \displaystyle\sum_{i=1}^n 
  ┃θ_i┃$$ </font>
      
Let’s try to minimize the loss function of Lasso Regression <br>
- When **λ = 0**, the regularization term becomes 0, and the objective becomes similar to simple linear regression, hence no coefficients are eliminated from the equation.<br>
- As **λ increases**, more coefficients are set to zero and eliminated. In theory, λ = infinity means all coefficients are eliminated.<br>
- Hence, we need to choose λ efficiently to have the right kind of Lasso regression.<br>

Let’s try to solve this problem mathematically.
For a single data point, consider
      <br><br>
 $$ \begin{aligned} 
         h_θ(X_i) & =   Xθ\\ 
               L(θ) & =(y-xθ)^2 + λ \displaystyle\sum_{i=1}^n |θ| \\
                  & = y^2 + 2xyθ + x^2θ^2 + λ \displaystyle\sum_{i=1}^n |θ| \\
\end{aligned} $$
 <br>
 We need gradient term to update weights, but It is observed from above that, L1 is not differentiable at 0 as L1 is a continuous function, hence there is no closed form solution in Lasso Regression.
Hence it is not feasible to update the weights of the features using a closed form solution or gradient descent, so Lasso uses something called coordinate descent to update the weights. <br><br>
L1 and its derivative look like below. L1 gradient is 1 or -1 unless w = 0 <br>

<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/L1 Derivative.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:200px;width:450px"/>
</p>
<p align='center'>
Figure 11. <a href='https://www.kaggle.com/general/212262'>
L1 Derivative </a>
</p>   

##### Let's see the third problem of Linear Regression, ***which is Multicollinearity.***
What is Multicollinearity, and why is it a problem?

## 4.2 Ridge Regression <a name="ridge_regression"></a>
Ridge Regression is an enhancement of regular linear regression, used for the analysis of multicollinearity in multiple regression data, which results in fewer overfit models.<br>

##### What is multicollinearity?
The actual purpose of a regression equation is to tell us the individual impact of each of the explanatory variables on the dependent/target variable and that is captured by the regression coefficients.
However, when two or more predictors in a regression model are highly related to one another, this means that an independent variable can be predicted from another independent variable in a regression model but does not provide unique and/or independent information to the regression.
**Multicollinearity can be a problem in a regression model because we would not be able to distinguish between the individual effects of the independent variables on the dependent variable.<br>**
<br>
Ridge regression uses ***L2 regularization technique.*** This technique is used to deal with multicollinearity problems by constructing the coefficient and by keeping all the variables. ***The penalty term in Ridge regression is equal to the sum of squared magnitude” of the coefficient.***<br>


  <font size="4"> $$ L2 = ║θ║^2_2 = \displaystyle\sum_{i=1}^n θ_i^2 $$ </font>
        

### L2 Regularization:
L2 regularization adds a penalty term to the loss function, which is the sum of the squared magnitude of the coefficients. The job of Ridge regularization is to penalize a model based on the sum of the squared coefficient values using the L2 penalty.<br>

  <font size="4"> $$ L(θ) =  \displaystyle\sum_{i=1}^n (y_i-h_θ(x))^2 + λ \displaystyle\sum_{i=1}^n 
 θ_i^2 $$ </font>

##### L2/Ridge regularization is used when,
- The number of predictor variables in a given set exceeds the number of observations.<br>
- The data set has multicollinearity (correlations between predictor variables).<br>

##### Using Ridge regularization
- It penalizes the magnitude of coefficients of features.<br>
- Minimizes the error between the actual and predicted observation.<br>
<br>
  
It forces to get weights from the shape of Norm 2, as shown below.

        
<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/L2 Shape.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:450px;width:380px"/>
</p>
<p align='center'>
Figure 12. <a href='https://www.datacamp.com/tutorial/tutorial-lasso-ridge-regression'>
Ridge Regression Shape </a>
</p>


Let’s try to minimize the loss function of Ridge Regression.
The amount of shrinkage is controlled by λ which multiplies the ridge penalty effect of λ on the ridge:
- When **λ = 0**, the objective becomes similar to simple linear regression. So we get the same coefficients as simple linear regression.
- As **λ increases**, more coefficients are set to zero and eliminated because of infinite weightage on the square of coefficients. In theory, λ = infinity means all coefficients are eliminated.
- If **0 < λ < ∞**, the magnitude of λ decides the weightage given to the different parts of the objective.

Let’s try to solve this mathematically.
For a single data point, consider<br>
      <br>
$$ \begin{aligned} 
         h_θ(X_i) \space & = \space Xθ\\ 
               L(θ) \space & = \space (y-xθ)^2 + λ \displaystyle\sum_{i=1}^n θ^2 \\
                  & \space = \space y^2 + 2xyθ + x^2θ^2 + λ \displaystyle\sum_{i=1}^n θ^2 \\
\end{aligned} $$
      
 
Apply first-order derivative w.r.to θ to find local minima, <br>
 
$$ \begin{aligned} 
         \frac{ƏL2}{Əθ} \space & = \space - 2xy + 2x^2θ + 2λθ\\ 
              θ \space & = \space \frac{xy}{x^2+λ} \\
\end{aligned} $$


Optimal θ, i.e $$ θ^* $$  will become 0 only when λ = ∞, ***so it is clear that in ridge regression, coefficients can never become zero.***

L2 and its derivative look like below. 

<p align='center'>
<img src="/images/Posts/Lasso_Ridge_Robust_Regression/L2 Derivative.webp"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:200px;width:450px"/>
</p>
<p align='center'>
Figure 13. <a href='https://www.kaggle.com/general/212262'>
L2 Derivative </a>
</p>  

<br>

 **Unequal importance given to all features during Feature selection**

Let’s see the working of Ridge Regression
Consider the weights/coefficients corresponding to 5 input features as below.<br>
This is just an example. <br>

$$ θ  = [θ_0, θ_1 , θ_2 , θ_3 , θ_4 , θ_5] \\
θ  = [5, 10, 8, 6, 4, 2] $$ 
    
$$ \begin{aligned} 
        Ridge  \space / \space L2 \space  penalty & =   \space θ_0^2+θ_1^2+θ_2^2+θ_3^2+θ_4^2+θ_5^2 \\ 
                &  =\space 25 + 100 + 64 + 36 + 16 + 4 = 245 \\
\end{aligned} $$
<br>
      
If we shrink each parameter by 1, The penalty looks like the below. <br>
$$ \begin{aligned} 
            θ_0 & \space => \space  16 + 100 + 64 + 36 + 16 + 4 = 236 \\ 
        age \space of \space the \space house & \space => \space  25 + 81 + 64 + 36 + 16 + 4 = 226 \\ 
              Sq.ft  & \space => \space 25 + 100 + 49 + 36 + 16 + 4 = 230\\
              No. of. Rooms  & \space => \space 25 + 100 + 64 + 25 + 16 + 4 = 234\\
              Neighborhood  & \space => \space 25 + 100 + 64 + 36 + 9 + 4 = 238\\
              Avg \space Temp  & \space => \space 25 + 100 + 64 + 36 + 16 + 1 = 242\\
\end{aligned} $$
<br>
    

By shrinking $$ θ_0 $$ from 5 to 4, the ridge penalty is reduced by 9, from 245 to 236<br>
      by shrinking the age parameter from 10 to 9, the ridge penalty is reduced by 19, from 245 to 226<br>
      by shrinking the Year manufactured parameter from 8 to 7, the ridge penalty is reduced by 15, from 245 to 230<br>
      by shrinking the Origin parameter from 6 to 5, the ridge penalty is reduced by 9, from 245 to 234<br>
      by shrinking the Income parameter from 4 to 3, the ridge penalty is reduced by 8, from 245 to 238<br>
      by shrinking the Temp parameter from 2 to 1, the ridge penalty is reduced by 3, from 245 to 242<br>

 ***The reduction in penalty is not the same in the case of all features***. Since the ridge penalty squares the individual model parameter, the large values are taken into account much heavier than smaller values. ***This means that our ridge regression model would prioritize minimizing large model parameters over small model parameters.*** This is usually a good thing because if our parameters are already small, they don’t need to be reduced even further.<br>

To summarize, in this post we have learned definition of regularization, types of differet Regulizations and differences between Lasso, Ridge and Robust Regressions with examples.

Yayyy, wasn't it great learning 😎 See you in the next post 👋 👋