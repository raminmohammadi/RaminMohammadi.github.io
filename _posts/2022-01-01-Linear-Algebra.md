---
title: Linear Algebra
subtitle: The Robin of Dataman - By Yue Chen
date: 2022-01-01 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Yue Chen
categories: math
---


Linear algebra is a branch of mathematics that is extremely useful in data science. 
It is also the most important math skill in machine learning, as most machine learning 
models can be expressed in matrix form, like how a dataset itself is often represented 
as a matrix. Not only has been used in data preprocessing, data transformation, and model 
evaluation, under the hood, linear algebra powers major areas including the cutting-edge 
fields of Natural Language Processing and Computer Vision. Hence, we can say that, 
if Data Science was Batman, Linear Algebra would be Robin. Here are the topics 
you need to be familiar with:

***

## 1.	Vector
To help you better understand the concept and features of vector, let’s 
start with a comparative study of Scalar VS Vector.

Scalar Definition: A scalar is a number. Examples of scalars are temperature,
distance, speed, or mass – all quantities that have a magnitude but no 
“direction”,  other than perhaps positive or negative.   
<img src="/images/Posts/Linear_Algebra/p1.png" width="400" height="250">

Vector Definition: A vector is a list of numbers. There are (at least) two 
ways  to interpret what this list of numbers mean: 1. Think of the vector as 
being a point in a space. Then this list of numbers is a way of identifying  
that point in space, where each number represents the vector’s component 
that  dimension. Or 2. Think of a vector as a magnitude and a direction, e.g.
a quantity like velocity. In this way of think of it, a vector is a directed 
arrow pointing from the origin to the end point given by the list of numbers.  
 <img src="/images/Posts/Linear_Algebra/p2.png" width="400" height="300">

## 2.	Matrix

<img src="/images/Posts/Linear_Algebra/p3.gif" width="356" height="150" alt="">

__Definition__: Matrices are logical and convenient representations of large 
sets of real numbers or variables, which are arranged in arrays of rows and columns.

Matrix $$ A\in \Re^{n*d}$$ is represented as $$ \begin{bmatrix}a_{11}& ... & a_{1,d} \\ . & ... & .\\ . & ... & . \\ a_{n,1} & ... & a_{n,d} \end{bmatrix} $$

## 3. Properties of matrix

3.1 Transpose of a matrix:
Definition: The transpose of an m x n matrix A is an n x m matrix obtained by 
interchanging rows and columns of A.

<img src="/images/Posts/Linear_Algebra/p5.png" width="553" height="174" alt="">

Try transposing a matrix using your right hand (following this paw):

<img src="/images/Posts/Linear_Algebra/p6.png" width="1004" height="384" alt="">


3.2 Inverse of a matrix

<img src="/images/Posts/Linear_Algebra/p7.png" width="399" height="221" alt="">

The inverse of matrix is another matrix, which on multiplication with the given 
matrix gives the multiplicative identity. 

For a matrix A, its inverse is $$A^{-1}$$ and $$A.A^{-1} = A^{-1}.A = I_n$$
where $$I_n$$ is the identity matrix.
              
<img src="/images/Posts/Linear_Algebra/p8.png" width="237" height="200" alt="">

3.3 Determinant of a matrix
Determinant of a matrix, indirectly calculated the area covered by columns or 
rows of a matrix. 

For a matrix  $$ W = \begin{bmatrix}a & b \\ c 
& d \end{bmatrix} $$ the determinant calculated as:

$$ |W| = a*d - b*c$$





## 4.	Dot product and matrix multiplication

Definition: The dot product is an algebraic operation that takes two same-sized vectors and returns a single number.

<img src="/images/Posts/Linear_Algebra/p9.png" width="1434" height="200" alt="">
                                 
Geometric definition: the dot product is the product of the Euclidean magnitudes of two vectors and the cosine of the angle between two.

<img src="/images/Posts/Linear_Algebra/p10.png" width="1156" height="424" alt="">

Definition of Matrix multiplication: basically, a matrix version of the dot product. Remember the result of dot product is a scalar. The result of matrix multiplication is a matrix, whose elements are the dot products of pairs of vectors in each matrix. 

<img src="/images/Posts/Linear_Algebra/p11.png" width="484" height="227" alt="">


Requirement: 
 the 1st matrix must have the same number of columns as the 2nd matrix has rows.

## 5. Eigenvalues and Eigenvectors


Eigenvector: Every vector (list of numbers) has a direction when it is plotted on XY chart. Eigenvectors are those vectors when a linear transformation (such as multiplying it to a scalar) is performed on them, their direction does not change.

Eigenvalue: The scalar that is used to transform (stretch/compress) an Eigenvector.
 
<img src="/images/Posts/Linear_Algebra/eigen1.png" width="275" height="109" alt="">

In matrix form

<img src="/images/Posts/Linear_Algebra/eigen2.png" width="1056" height="371" alt="">

Meaning: 

* Eigenvalues and Eigenvectors provides summary of a large matrix.
* Eigenvectors and eigenvalues are used to reduce noise in data. 
* They can help us improve efficiency in computationally intensive tasks. 
* They also eliminate features that have a strong correlation between them and also help in reducing over-fitting. 


## References
***
[Matrix](https://www.mathsisfun.com/search/search.html?query=linear+algebra&submit=&search=1#ff)

[Eigenvalues and Eigenvectors](https://medium.com/sho-jp/linear-algebra-part-6-eigenvalues-and-eigenvectors-35365dc4365a)

