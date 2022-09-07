---
title: Loss Functions - part 2 
subtitle: by Siddhartha Putti 
date: 2022-07-02 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
---


In the previous post, We have seen how Loss/cost function works in regression and when to use which cost function. let us also see how that works for classification settings. Let's dive in!

## Graduate Level  

* **Binary Cross Entropy Loss function:**  
<br>
<img src="/images/Posts/Cost_function_2/ccel.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:75px;width:450px" />
<p align = "center">
image credits: twitter
</p>
That's a lot in the equation. to break it down, firstly we see why there is log loss in the equation. we know that log is monotonically increasing function in total, so using log doesn't effect distribution but there will be change in scale. As we are finding log of probabilities, when the prob increases to reach 1, the log(1) reaches to zero i.e loss is zero, this makes sense doesnt it? 

Increase in prob decreases loss and decrease in prob increases loss. (huh...ah moment)

<br>
<img src="/images/Posts/Cost_function_2/logloass.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:400px" />
<p align = "center">
image credits: towardsdatascience
</p>
<br>

The plot above gives us a clear picture —as the predicted probability of the true class gets closer to zero, the loss increases exponentially.

In the avbove equation Yi referes to class, lets say 0,1 as class labels, class 0 makes the first term '0' and class 1 makes the second term '0', basically you are computing loss value with different probs having different classes. 


* **Hinge Loss:** 

The Hinge loss function is mainly used in Support Vector Machine settings. Its is meant to be used with binary classification where targets values are within the set. 

<br>
<img src="/images/Posts/Cost_function_2/hinge.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:250px;width:400px" />
<p align = "center">
image credits: stackoverflow
</p>
<br>

Lets break down how the loss function works for SVM with the above representation: 
- If the distance from the boundary is 0 (meaning that the datapoint is on the boundary), then we incur a loss size of 1. 
- A negative distance from the boundary gives a high hinge loss. which says that we are on the wrong side of the boundary i.e misclassification. 
- A positive distance from the boundary gives a low hinge loss, or zero hinge loss, and the further we are away from the boundary the lower our hinge loss will be.(when correctly classified)

You have seen what hinge loss is and how it works. Now, lets see the mathematical formulation of hinge loss. 

<br>
<img src="/images/Posts/Cost_function_2/hloss.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:50px;width:400px" />
<br>

Note that y should be the "raw" output of the classifier's decision function, not the predicted class label. For instance, in linear SVMs, y = w.x + b.

If the training data can be separated by a linear boundary, then any boundary which does so will have a hinge loss of zero— the lowest achievable value. 

Only if the training data is not linearly separable will the best boundary have a nonzero (positive, worse) hinge loss. In that case, the hinge loss preference will prefer to choose the boundary so that whichever misclassified points are not too far on the wrong side.

<br>

## Post Graduate Level

* **KL Divergence: Kullback–Leibler** 

let me start with the concept of information. Information is defined as

<p align="center">
<font size = 5>
    <strong> I = - log( p(x) ) </strong> </font>
</p>

We know that probability is between 0 and 1 and for the values less than 1 the log is -ve, 
- If prob is very small, - log of very small number is large
- If prob is large, - log is very small, 

You should have got the intuition by now, **The greater the prob the less information you get. The less the prob the more information you get.**

lets say an event you know will occur at high prob, there is no additional information you gain because you already know the event is going to happen, if someone says the astroid is going to hit in next 5 secs, in this case you gained much information from a unlikely event, for which prob is less. 

Another concept relevant to Information is average of information - **entropy: expectation of information.**

<p align="center">
<font size=5>
    <strong>H = - sum( p(x)*log(p(x)) ) </strong> </font>
<p>

Now relating all together

**KL-divergence is measure of dissimilarity of two distributions.** 

KL(p||q) = lets put it this way  

           entropy(p) - entropy(q) {average info from p dsitribution - average info of q distribution}

But if you see KL(p||q) is one distribution with respect to other 

so that changes to 

<p align = 'center'> 
<font size = 5>
<strong>KL(p||q) = - sum( p(x)*log(q(x)) ) + sum( p(x)*log(p(x)) )</strong> </font>
<p>

i.e (avg info of q with respect to p - avg info of p) 

There are two important things in KL-Divergence: 
- It is always greater than zero
- It is not symmetric i.e KL(q||p) ≠ KL(p||q)

Uses: 

- Lets say you are using autoencoders and you dont want your decoder to mimic the input, thus KLD is used as a loss metric to find out how the decoded sequence is diverged from input sequence. 
- Its specifically used to measure how different two distributions are. 

But, what about the loss functions in place that are used in high level settings as Generative Adversial Networks like: 
- minimax loss
- Wasserstein loss

Well that's a post for another what if! 

You kind of took a mini post graduate degree in loss functions! KUDOS

-Siddhartha Putti <br>
putti.s@northeastern.edu






