---
title: Multi-Head Self-Attention
subtitle: by Ramin Mohammadi & chatGPT
date: 2022-03-25 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi
categories: nlp
---

## Introduction
Self-attention is a mechanism that has revolutionized the field of natural language processing (NLP) by allowing models to selectively focus on different parts of the input sequence. Multi-head self-attention is a variant of self-attention that allows models to attend to different parts of the input sequence simultaneously using multiple attention heads. In this blog post, we will explain the mathematical formulation of multi-head self-attention and demonstrate how it can be used to improve performance on various NLP tasks.

## Basic Self-Attention
Before diving into multi-head self-attention, let's first review the basic self-attention mechanism. Given an input sequence $X \in \mathbb{R}^{n \times d}$, where $n$ is the sequence length and $d$ is the dimensionality of the input vectors, self-attention computes a new sequence $Y \in \mathbb{R}^{n \times d}$ by attending to all other elements in the sequence:

\begin{equation}
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^\top}{\sqrt{d_k}}\right)V
\end{equation}

where $Q$, $K$, and $V$ are the query, key, and value matrices, and $d_k$ is the dimensionality of the key vectors.

## Multi-Head Self-Attention
Multi-head self-attention extends the basic self-attention mechanism by using $h$ separate attention heads to compute multiple sets of attention scores. Each attention head is capable of attending to different parts of the input sequence, allowing the model to capture different aspects of the input at different levels of granularity. The outputs of all attention heads are then concatenated and linearly transformed to produce the final output.

The multi-head self-attention mechanism can be defined as follows:

\begin{equation}
\text{MultiHead}(Q, K, V) = \text{Concat}(head_1, head_2, ..., head_h)W_O
\end{equation}

where $head_i$ is the output of the $i^{th}$ attention head, $\text{Concat}$ is the concatenation operation along the feature dimension, and $W_O$ is a learnable weight matrix used to linearly transform the concatenated output.

Each attention head $i$ computes its own set of attention scores $\text{Attention}_i(Q_i, K_i, V_i)$ using the same dot-product attention mechanism as basic self-attention:

\begin{equation}
\text{Attention}_i(Q_i, K_i, V_i) = \text{softmax}\left(\frac{Q_iK_i^\top}{\sqrt{d_k}}\right)V_i
\end{equation}

The outputs of all attention heads are then concatenated along the feature dimension to obtain the multi-head attention output:

\begin{equation}
head_i = \text{Attention}_i(Q_i, K_i, V_i)
\end{equation}

The multi-head attention mechanism is designed to allow the model to attend to different parts of the input sequence simultaneously using multiple attention heads, each with its own set of learnable weight matrices. By attending to different parts of the input sequence, the model can capture different aspects of the input at different levels of granularity, improving its ability to represent complex relationships between different parts of the input.

## Conclusion
In this blog post, we have explained the mathematical formulation of multi-head self-attention, a variant of self-attention that allows models to attend to different parts of the input sequence simultaneously using multiple attention heads. Multi-head self-attention has revolutionized the field of natural language processing by enabling models to selectively focus on different parts of the input sequence, improving their ability to represent complex relationships between different parts of the input. We hope that this blog post has provided a clear and concise explanation of this important mechanism and its applications in NLP.