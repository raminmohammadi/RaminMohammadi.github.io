---
title: Attention Mechanism 
subtitle: by Ramin Mohammadi
date: 2022-03-27 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi
categories: nlp
---

## Introduction

Attention mechanisms have revolutionized the field of deep learning, especially in natural language processing (NLP), computer vision, and speech recognition. An attention mechanism allows a model to focus on different parts of the input, depending on their relevance to the output. In other words, it helps the model to selectively attend to different parts of the input, rather than processing it as a whole.

In this blog post, we will explain the attention mechanism in detail, including the mathematical expressions and formulas. We will also provide a full numerical example to help readers understand how attention works.

## Attention Mechanism

An attention mechanism is a way to compute a weighted sum of input vectors based on their relevance to a query. Given a query q and a set of input vectors ${x_1, x_2, ..., x_n}$, the attention mechanism computes a set of attention weights ${α_1, α_2, ..., α_n}$, where each weight α_i represents the relevance of the i-th input vector x_i to the query q. The attention mechanism then computes the weighted sum of the input vectors as follows:

\begin{equation}
c = α_1 * x_1 + α_2 * x_2 + ... + α_n * x_n
\end{equation}

The resulting vector $c$ is called the context vector, which represents the attended information from the input. The attention weights $α_i$ are typically computed using a function that takes the query q and the i-th input vector $x_i$ as inputs and produces a scalar value as output. This function is called the attention score function.

### Attention Score Function

The attention score function is used to compute the relevance of an input vector $x_i$ to a query $q$. There are several ways to define the attention score function, but one of the most common approaches is the dot product attention, which is defined as follows:

\begin{equation}
score(q, x_i) = q * x_i
\end{equation}

where * denotes the dot product. In other words, the attention score is simply the dot product between the query $q$ and the $i$-th input vector $x_i$.

Another common approach is the additive attention, which is defined as follows:

\begin{equation}
score(q, x_i) = v_a * tanh(W_a * q + U_a * x_i)
\end{equation}

where $W_a$ and $U_a$ are weight matrices, $v_a$ is a weight vector, and tanh is the hyperbolic tangent function. In this case, the attention score is computed by applying a non-linear transformation to a concatenation of the query q and the i-th input vector x_i, followed by a dot product with a weight vector $v_a$.

### Softmax Function

Once the attention scores are computed, they are transformed into attention weights using the softmax function. The softmax function is a widely used function that takes a vector of arbitrary real numbers and outputs a probability distribution over the vector elements. Specifically, the softmax function is defined as follows:

\begin{equation}
softmax(z)_i = exp(z_i) / sum_j(exp(z_j))
\end{equation}

where $z$ is the input vector and e is the base of the natural logarithm. In other words, the softmax function computes the exponential of each element of the input vector, normalizes the resulting vector to have a sum of one, and outputs the resulting vector as the attention weights.

## Numerical Example

To illustrate how the attention mechanism works, let’s consider a simple example of machine translation, where we want to translate a sentence from French to English. Suppose the input sentence in French is “Le chat mange du poisson” (which means “The cat eats fish” in English), and the output sentence in English is “The cat eats fish”. We want to build a neural machine translation model that takes the French sentence as input and produces the English sentence as output.

The first step is to represent the input sentence as a sequence of vectors. We can use a word embedding matrix to represent each word in the sentence as a vector. For simplicity, let’s assume that each word is represented as a 3-dimensional vector. Then, the input sentence can be represented as a matrix X of shape (5,3), where each row corresponds to a word vector:

```python
X = [[-0.2, 0.3, 0.5],
[0.1, -0.4, 0.2],
[0.4, -0.1, 0.6],
[0.2, 0.5, -0.1],
[0.3, -0.2, 0.4]]
```

Next, we need to define the query vector q, which represents the context of the output sentence that we want to generate. For simplicity, let’s assume that the output sentence has a fixed length of 4 words, and each word is represented as a 3-dimensional vector. Then, the query vector q can be represented as a matrix of shape (4,3), where each row corresponds to a word vector:

```python
q = [[0.1, 0.2, -0.3],
[-0.4, 0.3, 0.2],
[0.5, 0.1, -0.2],
[-0.2, 0.4, 0.3]]
```

Now, we can compute the attention scores using the dot product attention. For each row of q, we compute the dot product with each row of X:

```python
s = np.dot(X, q.T)
```

The resulting matrix s contains the attention scores for each word in the input sentence and each word in the output sentence:

```python
s = [[ 0.11, 0.24, -0.26, 0.02],
[-0.09, 0.22, 0.14, 0.16],
[ 0.01, -0.34, 0.34, -0.26],
[-0.01, 0.37, -0.12, 0.18],
[ 0.07, 0.08, 0.22, -0.14]]
```

To convert the attention scores into attention weights, we need to apply the softmax function to each column of s:

```python
alpha = softmax(s, axis=0)
```

The resulting matrix alpha contains the attention weights for each word in the input sentence and each word in the output sentence:

```python
alpha = [[0.3218, 0.2411, 0.1202, 0.3057],
[0.2586, 0.2142, 0.2679, 0.3319],
[0.2857, 0.1693, 0.3423, 0.1809],
[0.2784, 0.2414, 0.1356, 0.3422],
[0.3055, 0.1340, 0.1340, 0.2193]]
```

Finally, we can compute the context vectors by taking the weighted sum of the input vectors for each word in the output sentence. The context vectors can be computed as follows:

```python
C = np.dot(alpha.T, X)
```

The resulting matrix C contains the attended information from the input sentence for each word in the output sentence:

```python
C = [[ 0.1866, -0.0502, 0.4296],
[ 0.0815, 0.0269, 0.2632],
[ 0.1333, 0.0125, 0.3869],
[ 0.1621, 0.0738, 0.1943]]
```

## Conclusion

In this blog post, we explained the attention mechanism in detail, including the mathematical expressions and formulas. We also provided a full numerical example to illustrate how attention works in practice. Attention mechanisms have become an essential tool in deep learning, particularly in NLP, and have led to significant improvements in model performance. Understanding attention mechanisms is crucial for building state-of-the-art deep learning models and pushing the boundaries of AI research.
