---
title: Multi-Head Self-Attention
subtitle: by Ramin Mohammadi & chatGPT
date: 2022-03-25 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi & chatGPT
categories: nlp
---

## Introduction

Self-attention is a mechanism that has revolutionized the field of natural language processing (NLP) by allowing models to selectively focus on different parts of the input sequence. Multi-head self-attention is a variant of self-attention that allows models to attend to different parts of the input sequence simultaneously using multiple attention heads. In this blog post, we will explain the mathematical formulation of multi-head self-attention and demonstrate how it can be used to improve performance on various NLP tasks.

## Basic Self-Attention

Before diving into multi-head self-attention, let's first review the basic self-attention mechanism. Given an input sequence $X \in \mathbb{R}^{n \times d}$, where $n$ is the sequence length and $d$ is the dimensionality of the input vectors, self-attention computes a new sequence $Y \in \mathbb{R}^{n \times d}$ by attending to all other elements in the sequence:

\begin{equation}
\text{Attention}(X) = \text{softmax}\left(\frac{XW_Q(XW_K)^\top}{\sqrt{d_k}}\right)XW_V
\end{equation}

where $W_Q$, $W_K$, and $W_V$ are learnable weight matrices used to project $X$ onto query, key, and value vectors, respectively, and $d_k$ is the dimensionality of the key vectors.

The dot-product attention mechanism used in Equation computes the attention scores between all pairs of elements in the input sequence by taking the dot product between each query vector and each key vector, and then normalizing the scores using the softmax function. The value vectors are then weighted by the attention scores and summed to produce the final output sequence.

## Multi-Head Self-Attention

Multi-head self-attention extends the basic self-attention mechanism by using $h$ separate attention heads to compute multiple sets of attention scores. Each attention head is capable of attending to different parts of the input sequence, allowing the model to capture different aspects of the input at different levels of granularity. The outputs of all attention heads are then concatenated and linearly transformed to produce the final output.

The multi-head self-attention mechanism can be defined as follows:

\begin{equation}
\text{MultiHead}(X) = \text{Concat}(head_1, head_2, ..., head_h)W_O
\end{equation}

where $head_i$ is the output of the $i^{th}$ attention head, $\text{Concat}$ is the concatenation operation along the feature dimension, and $W_O$ is a learnable weight matrix used to linearly transform the concatenated output.

Each attention head $i$ computes its own set of attention scores $\text{Attention}_i(Q_i, K_i, V_i)$ using the same dot-product attention mechanism as basic self-attention:

\begin{equation}
\text{Attention}i(Q_i, K_i, V_i) = \text{softmax}\left(\frac{Q_iW{Q,i}(K_iW_{K,i})^\top}{\sqrt{d_k}}\right)V_iW_{V,i}
\end{equation}


where $Q_i$, $K_i$, and $V_i$ are the query, key, and value matrices obtained by projecting $X$ using separate learnable weight matrices $W_{Q,i}$, $W_{K,i}$, and $W_{V,i}$, and $d_k$ is the dimensionality of the key vectors.

The outputs of all attention heads are then concatenated along the feature dimension to obtain the multi-head attention output:

\begin{equation}
head_i = \text{Attention}_i(Q_i, K_i, V_i)
\end{equation}


The multi-head attention mechanism is designed to allow the model to attend to different parts of the input sequence simultaneously using multiple attention heads, each with its own set of learnable weight matrices. By attending to different parts of the input sequence, the model can capture different aspects of the input at different levels of granularity, improving its ability to represent complex relationships between different parts of the input.

## Conclusion

In this blog post, we have explained the mathematical formulation of multi-head self-attention, a variant of self-attention that allows models to attend to different parts of the input sequence simultaneously using multiple attention heads. Multi-head self-attention has revolutionized the field of natural language processing by enabling models to selectively focus on different parts of the input sequence, improving their ability to represent complex relationships between different parts of the input. We hope that this blog post has provided a clear and concise explanation of this important mechanism and its applications in NLP.

<hr>

## Another Blog - Multi-Head Attention Explained

## Introduction

Self-attention is a powerful mechanism in natural language processing that enables models to selectively attend to different parts of the input sequence. It has become an essential building block in many state-of-the-art models, including the Transformer architecture used in the popular language model GPT-3.

One variant of self-attention that has gained widespread adoption is multi-head self-attention. In this blog post, we will explain the mathematical formulation of multi-head self-attention and why it works.

## Self-Attention

Self-attention is a mechanism that allows a model to compute a weighted sum of the values of the input sequence, where the weights are determined by the similarity between each element of the sequence and a query vector. Specifically, given an input sequence $X = (x_1, x_2, ..., x_n)$ and a query vector $q$, the self-attention mechanism computes a new sequence $Y = (y_1, y_2, ..., y_n)$, where each element $y_i$ is a weighted sum of the values in $X$:

\begin{equation}
y_i = \sum_{j=1}^n \alpha_{ij} x_j
\end{equation}

where $\alpha_{ij}$ is the weight assigned to $x_j$ in the computation of $y_i$, and is defined as follows:

\begin{equation}
\alpha_{ij} = \frac{\exp(e_{ij})}{\sum_{k=1}^n \exp(e_{ik})}
\end{equation}

where $e_{ij}$ is the compatibility score between $q$ and $x_j$:

\begin{equation}
e_{ij} = q^\top W x_j
\end{equation}

where $W$ is a learnable weight matrix.

Intuitively, the self-attention mechanism computes a set of weights that reflect the similarity between the query vector $q$ and each element of the input sequence $X$. By using a weighted sum of the values in $X$ as the output, the model can selectively attend to different parts of the input sequence, focusing on the elements that are most relevant for the task at hand.

## Multi-Head Self-Attention

While self-attention is a powerful mechanism, it has a limitation in that it can only attend to one aspect of the input sequence at a time. Multi-head self-attention overcomes this limitation by allowing the model to attend to different parts of the input sequence simultaneously using multiple attention heads.

The multi-head self-attention mechanism works by splitting the query, key, and value vectors into multiple smaller vectors, and computing the self-attention mechanism independently for each of these smaller vectors. Specifically, given an input sequence $X$ and a set of $h$ attention heads, we compute $h$ separate queries $Q_i$, keys $K_i$, and values $V_i$ for $i=1,2,...,h$, where each of these matrices is obtained by projecting $X$ using separate learnable weight matrices $W_{Q,i}$, $W_{K,i}$, and $W_{V,i}$:

$$
Q_i = XW_{Q,i} \\ 
K_i = XW_{K,i} \\
V_i = XW_{V,i} \\
$$

For each attention head $i$, we then compute the self-attention mechanism independently using the queries, keys, and values associated with that head. The output of the multi-head self-attention mechanism is obtained by concatenating the outputs of each attention head and passing the concatenated vector through a linear layer.

Formally, the output of the multi-head self-attention mechanism is given by:

\begin{equation}
Y = \text{concat}(y_1, y_2, ..., y_h) W_O
\end{equation}

where $y_i$ is the output of the self-attention mechanism for the $i$th attention head:

\begin{equation}
y_i = \text{softmax}(\frac{Q_i K_i^\top}{\sqrt{d_k}}) V_i
\end{equation}

where $\text{softmax}$ is the softmax function, $d_k$ is the dimensionality of the key vectors, and $W_O$ is a learnable weight matrix that maps the concatenated output of the attention heads to the final output dimensionality.

Intuitively, the multi-head self-attention mechanism allows the model to attend to different parts of the input sequence simultaneously, by computing multiple attention mechanisms over different projections of the input sequence. By concatenating the outputs of these attention mechanisms, the model can capture a more fine-grained representation of the input sequence.

## Conclusion

In this blog post, we explained the mathematical formulation of multi-head self-attention and why it works. Multi-head self-attention is a powerful mechanism that allows models to attend to different parts of the input sequence simultaneously, and has become an essential building block in many state-of-the-art natural language processing models. We hope this explanation has provided a clear and intuitive understanding of this important mechanism.