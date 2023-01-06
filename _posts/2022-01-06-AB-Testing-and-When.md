---
title: A/B, A/A Testing, and When to Use
subtitle: by Yanming Liu 
date: 2022-12-07 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Yanming Liu
categories: math
---


# Table of Contents

1. [A/B Testing](#ab_testing)
2. [A/B Multivariate Testing](#ab_mul_testing)
3. [A/A Testing](#aa_testing)
4. [Reference](#ref)

All of them are introduced with a logic of definition, application, and the difference among them is pointed out as well. In the final, we encourage our audience to implement those techniques for deeper understanding, which also be my next experimentation direction. 
<br>

## 1. A/B Testing <a name="ab_testing"></a>

A/B Testing is a randomized controllable experiment that incorporates variant A and variant B to determine which variant is more effective for given tasks. Taking the website below as an example, the click rates for the blue and green buttons can be measured by randomly showing them to visitors, therefore, we can decide which button color will matter more so as to acquire the additional exposure under the attractive color. 

<img src="/images/Posts/AB_Testing/A-B_testing_example.png"
     style="display: block; 
        margin-left: auto;
        margin-right: auto; height:350px;width:600px"/>     
<p align='center'>
   <a href='https://en.wikipedia.org/wiki/A/B_testing#/media/File:A-B_testing_example.png'>
      Figure Credit
   </a>
</p>

<br>

This technique is widely used in the especially commercial area to broadcast the product, increase sales revenue, and improve customer experience. Google conducted at least 7000 A/B testing for tasks like identifying the optimal number of display results on one page, a better way for showing the headlines, etc.
This is true of finding a dynamic price for obtaining extra benefits. They can be used for political elections as well to see what kind of factor will draw the attention of voters. 

<br>

To highlight, segmentation and target approach can be taken into consideration for ideal gains when the effect of our audience attributes on performance is introduced. Returning back to the click rate for variant A (green button) and variant B (blue button) setting, we have a table as follow,

| Gender      | Overall     | Men | Women     |
| :---        |    :----:   |  :----:|        ---: |
| # of Views    |  20      | 10  | 10   |
| # of Clicks   | 8        | 4 |4      |
| Variant A  | 5       | 4 |1     |
| Variant B   | 3        | 0 | 3   |

<br>

In this example, both variants are exposed to the Men or Women group equally for they share 10 identical numbers of views. However, the response of different gender to variants will differ. Overall, Variant A possesses a higher click rate (5/20) than Variant B (3/20). Men are likely to click for Variant A, while Women are prone to respond to Variant B. If we increase the views of Variant A to Men and send more links of Variant B to Women, then the expected click rate will increase in intuition. Furthermore, we can do a good job of increasing rates by analyzing the response for additional audience attributes, such as age and gender. When conducting the analysis, be sure to randomly expose those variants for people with different attributes to remove the bias and ensure a convincing strategy for further usage.

<br>

## 2. A/B Multivariate Testing <a name="ab_mul_testing"></a>

A/B Multivariate Testing is a generalized form of A/B Testing, of which several variants that can be seen by our audience instead of just two are tested for optimal decision. 

<br>

It is used when you would like to explore the effect on performance with variables combination. Run once, and the interactive phenomenon among variables will be presented for you. This is convenient compared to A/B Testing. However, they have difficulty finding a solution in a feasible time. 

<br>

## 3. A/A Testing <a name="aa_testing"></a>

A/A Testing is the byproduct of A/B Testing, instead of comparing two variants A and B, but A VS. A. The purpose of A/A Testing can be as follow, 

- Check whether A/B Testing works or not
- Identify the baseline for the conversion rate
- Find the smallest size of samples that do not give rise to the biased issue

<br>

Let us illustrate the three purposes one by one. For checking the effectiveness of A/B testing, after you set up and write the code for A/B Testing, apply them using A/A Testing on two same variants to check the click rate for each version approximates or not. If so, things work fine for A/B Testing confirmation, otherwise, analyze errors for the correct A/B Testing setting. 

<br>

Suppose the original version for the green button in the above-mentioned example, then you made another version for the blue button, and get the click rate for both. Then you run A/A Testing on the green button/green button, and the click rate results show 5.01% and 5.06% for both green button versions. So, we do A/B Testing, green button/blue button, the click rate of 5.06% can be regarded as the baseline of the conversion rate for A/B Testing. If we see there is a click rate above this baseline value, we reach a safe conclusion that the color matters here. The opposite means no efforts to improve the click rate.

<br>

To guarantee a useful strategy, all button color versions should be exposed to enough people to remove the potential statistical errors in click rate. Similar and stable click rates for A/A testing can find the smallest training samples for us. This smallest number of samples will save us time for further A/B testing. 

<br>

However, A/A Testing needs lots of visits to get the approximate values for click rates. This usually takes lots of time and is not suitable for companies that are visited by fewer people.

<br>

## 4. Reference <a name="ref"></a>
[A/B Testing Wiki](https://en.wikipedia.org/wiki/A/B_testing)

[A/B Multivariate Testing](https://www.optimizely.com/optimization-glossary/multivariate-test-vs-ab-test/#:~:text=Tests%20with%20more%20variables%20take,testing%20is%20the%20optimal%20approach.)

[A/A Testing - 1](https://www.optimizely.com/optimization-glossary/aa-testing/#:~:text=What%20is%20A%2FA%20testing,the%20experiment%20is%20statistically%20fair.)

[A/A Testing - 2 ](https://blog.csdn.net/weixin_41744624/article/details/109990705)

Now, you know the three testing and when to use them. Why not find a practical problem and solve by yourself to gain more insights? Let's always start!


