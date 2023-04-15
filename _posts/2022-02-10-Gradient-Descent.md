---
title: Gradient Descent 
subtitle: by Jinchuan He 
date: 2022-02-10 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: Jinchuan He
categories: ml
---


# Gradient Descent and its variations

<br>
<h2 id="table-of-contents">Table of contents</h2>
<ol>
  <li><a href="#what_is_gradient_descent">What is Gradient Descent (GD)?</a></li>
  <li><a href="#Blind_Bear_Climb_the_Hill">Blind Bear Climb the Hill</a></li>
  <li><a href="#How_the_Gradient_Descent_Work">How does the Gradient Descent Work?</a></li>
  <li><a href="#BGD">Batch Gradient Descent (BGD)</a></li>
  <li><a href="#SGD">Stochastic Gradient Descent (SGD)</a></li>
</ol>

<h2 id="what is Gradient Descent">What is Gradient Descent (GD)? <a name="what_is_gradient_descent"></a></h2>

"A gradient measures how much the output of a function changes if you change the inputs a little bit." — Lex Fridman (MIT)

Gradient Descent is an optimization algorithm used for minimizing the cost function in various machine learning algorithms. It is basically used for updating the parameters of the learning model.

<h2 id="Blind Bear Climb the Hill">Blind Bear Climb the Hill<a name="Blind_Bear_Climb_the_Hill"></a></h2>

I will use the chart to help you to understand what is gradient descent.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Gradient_Descent/bear.webp" width="500" height="400"><p>
<p align='center'>Figure 1. <a href='https://www.jamitarris.com/image/I0000mAheJNe3_R0'>A Bear Climb the Hill</a></p>

You can imagine a blind bear wanting to climb to the top of a hill with the fewest steps possible. When the bear started climbing, he will take big steps which he can do as long as he is not close to the top. While the bear comes closer to the top, his steps will get smaller and smaller to avoid overshooting the top point. You can think this process is using the gradient.
        
In mathamatics, we can use the below figure to explain it.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Gradient_Descent/gradient descent row.webp" width="400" height="200"><p>   
<p align='center'>Figure 2. <a href='http://127.0.0.1:4000/blog/gradient-descent'>Gradient Descent - Top View</a></p>

You can imagine the red arrows are the steps of the bear and the center of the circle is the top point. In the beginning, the gradient range is much longer than the others.


<h2 id="How the Gradient Descent Work">How the Gradient Descent Work ?<a name="How_the_Gradient_Descent_Work"></a></h2>
When we learn some machine learning models, we need to use the gradient descent method to resolve the result. Now we need to understand how it is working.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Gradient_Descent/gradient descent.webp" width="400" height="400"><p>
<p align='center'>Figure 3. <a href='https://towardsdatascience.com/mathematical-intuition-behind-gradient-descent-f1b959a59e6d'> Gradient Descent - Front View</a></p>
        
We hope we can get the optimized point in a short time. Therefore, we need to reduce the interactive times. The gradient descent can help us to do that.

In machine learning, we input the initial value and then get the gradient information of the function. We can move a certain distance (step size) in the gradient descent direction (negative gradient direction) and then get the next point. In this case, we find the gradient descent direction of this point, and so on, constantly approaching the minimum value.
<h2 id="Batch Gradient Descent (BGD)">Batch Gradient Descent (BGD)<a name="BGD"></a></h2>

Batch gradient descent(vanilla gradient descent) calculates the error for all data within the training dataset. After calculating all training examples, the parameter of the model gets updated. Therefore, if the size of the dataset is large, the batch gradient descent is very expensive to calculate.

<h2 id="Stochastic Gradient Descent (SGD)">Stochastic Gradient Descent (SGD)<a name="SGD"></a></h2>

Stochastic gradient descent (SGD) will calculate the error for each training example. Thus, SGD does not calculate all data within the training dataset. The advantage of stochastic gradient descent is faster than batch gradient descent. However, the noisy data will cause the error rate because SGD calculates each data to update the parameter.

<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Gradient_Descent/SGD and BGD.webp" width="800" height="600"><p>

The image above explains the difference between SGD and BGD. SGD will iterate more times, but the time of each iteration is slow. Thus, SGD is faster than BGD.
<p align='center'>Figure 4. <a href='https://towardsdatascience.com/a-deeper-look-into-gradient-based-learning-for-neural-networks-ad7a35b17b93'>SGD vs. GD</a></p>
     
<h2>References</h2>
<ol>
  <li><a href="https://en.wikipedia.org/wiki/Gradient_descent">Gradient Descent</a></li>
</ol>