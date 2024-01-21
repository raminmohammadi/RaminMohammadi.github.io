---
title: Convex Optimization - Part 1
subtitle: Shamhith Kamasani
date: 2023-08-12 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: Shamhith Kamasani
categories: optimization
---

> <cite>"The great watershed in optimization isn't between linearity and nonlinearity, but  convexity and nonconvexity." - R.Tyrrell Rockafellar</cite>

**Convex optimization** being a vast topic, the main agenda of these articles is to give you a basic understanding of how it works and we’ll discuss a few methods with examples.

In simple terms, the core of machine learning is minimizing the error or maximizing the distance (error and distance are nothing but functions). Before starting with convex optimization, let's discuss more on why “Convexity” is stressed in Machine Learning.

##### Some properties that make convexity very important:

- We can find a minimum point for any convex function/set  
- Efficient algorithms have been developed around convexity properties  
- Scales well with size of data and no.of variables in a model
- Smoothness of the function helps to be less sensitive to noise in the data  
- Interpretability of convex functions is very high

## **CONVEX OPTIMIZATION:**

Let's break it down by explaining each term.

###### Optimization:

**Optimization** is simply choosing an optimal option i.e., one with minimum cost when provided with many options.

General Optimization problems follow below form:  

$$
\begin{aligned}
    \Large{\min_{x} \quad} & \Large{f_{0}(x)}\\
    \textrm{s.t.} \quad & \small{f_{i}(x) \le b_{i}, \quad i=1,2...,m\\}
\end{aligned}$$

- $$ x = [x_1,...x_n] $$(Optimization/ decision variables)  
- $$ f_0 : R^n → R$$ (Objective function)  
- $$ f_i : R^n → R$$ (Constraints)

Optimal solution $x^∗$(vector) has the smallest value of $f_0(x)$ among all vectors satisfying the constraints.

Ex:

$$
\begin{aligned}
    \Large{\min_{\theta} \quad} & \Large{f_\theta(x,y) : x^2 + y^2 − 4 = 0}\\
    \textrm{s.t.} \quad & \small{x,y ≥ 0}\\
\end{aligned}$$

<img src="/images/Posts/Convex_Optimization_1/circle.webp" width="400" height="250">

(NOTE: Constraints aren’t mandatory to call it an optimization problem)  

##### Real life examples:

1. Data Fitting
2. Portfolio Optimization<br>
**Tip**: Always look for the Variables(V), Objective(O), Constraints(C)

<div style="display: inline-block; width: 48%; vertical-align: top;">
  <p style="text-align: center;"><strong>Portfolio Optimization</strong></p>
  <ul style="text-align: left;">
    <li>V: amount invested in different areas</li>
    <li>O: Overall risk/ return variance</li>
    <li>C: Budget, Investment per asset</li>
  </ul>
</div>
<div style="display: inline-block; width: 48%; vertical-align: top;">
  <p style="text-align: center;"><strong>Data Fitting</strong></p>
  <ul style="text-align: left;">
    <li>V: model parameters</li>
    <li>O: Prior info, parameter limits</li>
    <li>C: Accuracy / Precision limit</li>
  </ul>
</div>

## CONVEXITY:

How do we find out if a function and set given is convex? . What are convex sets/ functions?

###### **Convex Sets**:
A **Set**(points in space) is said to be a convex set if, for any 2 points inside the set, the line segment joining the 2 points lie completely inside the set.


##### Points to remember:

• Lines are always convex sets[ (ax=b), (ax { ≤ , ≥ , <,> } b)]  
• If 2 sets S1, S2 are convex then S1 ∩ S2 is    always convex.  
• Norms associated with less than symbol are always convex  
• In case of matrix(A), Ax=b is convex, if all the vectors when broken down are convex

###### Convex Functions:

A Functions whose epigraph(region above the function) is a convex set, is a Convex Function.

<center> Or </center>

If there’s a line joining any 2 points in a given function, then all other points of the function between those 2 points should be either on or below the line. (as visible in the picture below, all function values are below line joining $ θ_1 $ & $ θ_2 $ hence it is a convex funcion)

###### Convex function:

$$
\begin{aligned}
    \Large{\min_{x} \quad} & \Large{f_{0}(x)}\\
    \textrm{s.t.} \quad & \small{f_{i}(x) \le b_{i}, \quad i=1,2...,m\\}
\end{aligned}$$

<img src="/images/Posts/Convex_Optimization_1/parabola_.webp" width="400" height="250">

**4 ways to say if it is a convex function:**
1. $\frac{∂^2f(θ)}{∂^2θ} ≥ 0$ 
2. Hessian Matrix is Positive Semi-Definitie i.e., it's eigenvalues $\ge$ 0
3. Should satisfy triangular inequality
4. Visualize the function and say by looking

**If objective function and constraints($=, \le$ ) are convex then it is a convex optimization problem**.

*Convex Optimization problem is usually in the following form:*

$$
\begin{aligned}
    \Large{\min_{x} \quad} & \Large{f_0(x,y) : x^2 + y^2 − 4 = 0}\\
    \textrm{s.t.} \quad & \small{x,y ≥ 0}\\
\end{aligned}$$

where $ f_0(x),f_1(x) ...f_m(x) : \mathbb{R}^n → R $ are convex i.e. if they satisfy(triangular inequality) 

$$
\Large{f_i(\alpha x + \beta y) ≤ \alpha f_i(x) + \beta f_i(y)}
$$ 

where $\forall \space x, y \in \mathbb{R}^n$ and $\forall \space \alpha, \beta \in \mathbb{R}$ with $ \alpha + \beta = 1, \alpha ≥ 0, \beta ≥ 0$  

(Note: If there are no constraints and objective function is convex, it’s still Convex Optimization.)

<br>
Curious to learn different ways to solve convex optimization problems? See you in Convex Optimization (Part-2)

<br>

###### References:  

[1] [*Convex Optimization* by Stephen Boyd](https://web.stanford.edu/~boyd/cvxbook/bv_cvxbook.pdf)  
[2] *Pattern Recognition and Machine Learning* by Christopher Bishop  
[3] [*Convex Optimization Visually explained ?* (Youtube) ](https://www.youtube.com/watch?v=AM6BY4btj-M&t=602s)  
[4] [*Convex Optimization*(Youtube)](https://www.youtube.com/watch?v=McLq1hEq3UY&list=PL3940DD956CDF0622)