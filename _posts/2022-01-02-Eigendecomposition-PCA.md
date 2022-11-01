---
title: Eigen Value Decomposition
subtitle: Eigen Value Decomposition and PCA - By Yue Chen
date: 2022-01-02 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Yue Chen
categories: math
---



# A Complete Record of Jack and Ashley's Last Peaceful Talk

Jack just finished a phone call with Paul Bettany.

Ashley: Eigen, eigen… Pee-see-ay… I never knew you speak any German besides, you know, bier.

Jack: Calm down. It’s just that Paul has been reading a lot of math, God 
knows how  Jennifer are obsessed with mathematician.


<img src="/images/Posts/PCA/P1.png" width="481" height="517" alt="">


Ashley: Oh really, tell me more about it! You know I’ve got an audition next 
week  right? For “Algebra Man: Curse of Dimensionality”. 

Jack: Ah, Principal Component Analysis or PCA, it's just a method of 
summarizing  some data. Look, we have some glasses of whisky on the table, 
and of  course we can describe each whisky by its colour, age, taste etc., 
then we  can compose a 4 pages’ appreciation paper for each of it. But no, 
this is  just way too much for those whisky newbies! So, instead of a long 
list of  Whisky features, we can use PCA to summarize each whisky through 
extracting  the maximum possible information from the drink while reducing 
the noise  and ignoring the redundant information. 

<img src="/images/Posts/PCA/P2.png" width="593" height="345" alt="">

(The Esquire Rainbow of Whiskey)

Ashley: Hmm, okay. Does it mean PCA returns you a new whisky color or taste 
that  helps you know this drink better?

Jack: Not exactly, the best part of PCA is that it doesn’t restrict itself 
to  currently existing variables! Instead, it creates new variables when 
extra  expression is needed, which is, the Principal Components (PC). PC are 
constructed as linear combinations or mixtures of the initial variables. 
These  combinations are done in such a way that the PCs are uncorrelated and 
most  of the information within the initial variables is squeezed like lime 
into  the first PC~ Like when you have the first sip, you get most of the taste, juicy!

Ashley: Interesting. But I still doubt how PCA distills the drink… I mean, 
summarizes  the information for you? How does it know what’s important and what isn’t?

Jack: Good question. Perhaps I should make a little drawing (takes a napkin 
and  starts scribbling).

<img src="/images/Posts/PCA/P3.png" width="533" height="353" alt="">    <img 
src="/images/Posts/PCA/P4.png" width="717" height="423" alt="">

Then Johnny used his wind borrowed from the Charlie movie, the black line starts to spin.

[//]: # (<img height="200" src="/images/Posts/PCA/P5.gif" width="200")
<img height="200" src="/images/Posts/PCA/P6.gif" width="400">



Johnny’s dog: Magical, papa! I think I can see why the two goals yield the 
same  result. And I also Ashley that you mentioned eigenvectors and 
eigenvalues,  how are they related to PCA?

Jack: My sweetheart, let me explain to you! Eigenvalues and eigenvectors are 
the results of eigen-decomposition of matrix.
The decomposition can be derived from the fundamental property of eigenvectors:

<img src="/images/Posts/PCA/P7.png" alt="" width="182" height="102">

The 2 × 2 real matrix A, may be decomposed into a diagonal matrix through  
multiplication of a non-singular matrix B

<img src="/images/Posts/PCA/P8.png" alt="" width="367" height="87">

Then

<img src="/images/Posts/PCA/P9.png" alt="" width="376" height="87"> for some real diagonal matrix 
<img src="/images/Posts/PCA/P10.png" alt="" width="86" height="71">

Multiplying both sides of the equation on the left by B:

<img src="/images/Posts/PCA/P11.png" alt="" width="352" height="78">

Jack’s dog: Oh I see! The above equation can be decomposed into two simultaneous equations:

<img src="/images/Posts/PCA/P12.png" alt="" width="695" height="147">
      
Letting
 
<img src="/images/Posts/PCA/P13.png" alt="" width="272" height="87">

this gives us two vector equations:

<img src="/images/Posts/PCA/P14.png" alt="" width="147" height="80">
 
And can be represented by a single vector equation involving two solutions as eigenvalues:
 
<img src="/images/Posts/PCA/P15.png" alt="" width="162" height="61">  where λ represents the two 
eigenvalues x  and y, and u represents the vectors a and b.

Shifting λu to the left-hand side and factoring u out
 
<img src="/images/Posts/PCA/P16.png" alt="" width="242" height="67">

Since B is non-singular, it is essential that u is nonzero. Therefore,

<img src="/images/Posts/PCA/P17.png" alt="" width="260" height="58">

Thus

<img src="/images/Posts/PCA/P18.png" alt="" width="291" height="53">

giving us the solutions of the eigenvalues for the matrix A as λ = 1 or λ = 3. 

And the resulting diagonal matrix from the eigen-decomposition of A is thus
<img height="110" src="/images/Posts/PCA/P19.png" width="100"/>
 
Jack: Absolutely! Putting the solutions back into the above simultaneous equations

<img src="/images/Posts/PCA/P20.png" alt="" width="281" height="167">
 
Solving the equations, we have <img src="/images/Posts/PCA/P21.png">

Thus, the matrix B required for the eigen-decomposition of A is

<img src="/images/Posts/PCA/P22.png" alt="" width="390" height="92">

that is:

<img src="/images/Posts/PCA/P23.png" alt="" width="665" height="85">

Ashley: Zzzzz…. Oh! Darling, what should I say? You just keep surprising me 
every  day! Now give me a example of PCA that happened to you.

Jack: There was one. Vinona...

Ashley: Your silly tattoo?

Jack: Say that again?!

## References

[Rainbow of Whiskey](https://www.esquire.com/food-drink/drinks/a33731/esquire-guide-to-whiskey-2015/)

[PCA](https://medium.com/sho-jp/principal-component-analysis-101-part-1-d62aa2b0cc36)

[Eigen-decomposition and PCA](https://blog.clairvoyantsoft.com/eigen-decomposition-and-pca-c50f4ca15501)
